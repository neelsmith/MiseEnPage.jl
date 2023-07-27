"""Model for analyzing layout of a page of a manuscript.
Note that `pagebounds` is an image URN with region of interest showing
position of the physical page within a documentary photograph.
`iliad_bbox` is a bounding box for *Iliad* passages on the page, expressed in the same image-percent coordinates as image URNs.
"""
struct MSPage
    pageurn::Cite2Urn
    folioside

    pagebounds::Cite2Urn
    iliad_bbox

    iliadlines::Vector{CtsUrn}
    scholia::Vector{ScholionIliadPair}
end


"""Collect all information needed to analyze the
layout of a page.  Optionally include a CEX data string;
if not included, the current release data of the Homer Multitext
project is retrieved from github and used.
$(SIGNATURES)
"""
function msPage(pageurn::Cite2Urn; data = nothing)::Union{MSPage, Nothing}
    hmtdata = isnothing(data) ? hmt_cex() : data

    pageside = nothing
    if endswith(pageurn.urn, "r")
        pageside = :recto
    elseif endswith(pageurn.urn, "v")
        pageside = :verso
    end

    boundsimgs = filter(hmt_pagerois(hmtdata).index) do pr
        string(pr[1]) == string(pageurn)    
    end
    if isempty(boundsimgs)
        @warn("$(pageurn) does not have indexed page boundaries in the HMT archive")
        return nothing
    end
    boundsimg = boundsimgs[1][2]

    dse = hmt_dse(hmtdata)[1]     
    textpassages = textsforsurface(pageurn, dse)

    iliadreff =  filter(u -> startswith(workcomponent(u), "tlg0012.tlg001."), textpassages)
    scholiareff = filter(psg -> startswith(workcomponent(psg), "tlg5026"), textpassages)

    allcommentary = hmt_commentary(hmtdata)[1]
    iliadstrings = map(u -> string(u),iliadreff)
    scholiapairs = pairtexts(scholiareff, allcommentary.commentary, dse, iliadstrings)

    iliadboundingbox = iliadboundbox(iliadreff, dse)
    
    MSPage(
        pageurn, pageside, 
        boundsimg, iliadboundingbox,
        iliadreff, scholiapairs)    
end

"""Pair data for each scholion in `scholialist` with corresponding *Iliad*
data as a `ScholionIliadPair`.
$(SIGNATURES)
"""
function pairtexts(scholialist, commentarydata, dsedata, iliadreff)
    rawmappings = map(scholialist) do s
        iliadmatches = filter(pr -> pr[1] == s, commentarydata)
        if length(iliadmatches) == 1
            iliad = iliadmatches[1][2]
            lineindex = findfirst(isequal(string(iliad)), iliadreff)

            schimagematches = imagesfortext(s, dsedata)
            ilimagematches = imagesfortext(iliad, dsedata)

            if length(schimagematches) == 1 && length(ilimagematches) == 1
                ScholionIliadPair(
                    s,
                    schimagematches[1],
                    iliad,
                    ilimagematches[1],
                    lineindex
                )

            else
                @warn("Failed to find images for scholion $(s) and Iliad line $(iliad).")
                nothing
            end
        else
            @warn("No Iliad match for scholion $(s).")
            nothing
        end
    end
    filter(pr -> !isnothing(pr), rawmappings)
end


"""Get a containing rectangle for the *Iliad* lines on a page.
`iliadlines` should be a Vector with *Iliad* lines on a single page;
`dse` is a DSE collection covering those lines.
$(SIGNATURES)
"""
function iliadboundbox(iliadlines, dse; digits = 3)::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}
    topdse = imagesfortext(iliadlines[1], dse)#[1] |> MiseEnPage.imagefloats
    if length(topdse) != 1
        throw(ArgumentError("iliadboundbox: no DSE record found for $(iliadlines[1])"))
    end

    bottomdse = imagesfortext(iliadlines[end], dse)#[1] |> MiseEnPage.
    if length(bottomdse) != 1
        throw(ArgumentError("iliadboundbox: no DSE record found for $(iliadlines[end])"))
    end

    topbox = topdse[1] |> MiseEnPage.imagefloats
    @debug("Top box on $(iliadlines[1]) is $(topbox)")
    bottombox = bottomdse[end] |> MiseEnPage.imagefloats
    @debug("Bottom box on $(iliadlines[end]) is $(bottombox)")
    lft = min(topbox[1], bottombox[1])
    rghtraw = max(topbox[1] + topbox[3], bottombox[1] + bottombox[3])
    rght = round(rghtraw, digits = digits)
    top = topbox[2]
    bottom = round(bottombox[2] + bottombox[4], digits = digits)
    (left = lft, top = top, right = rght, bottom = bottom)
end


"""Find height in original image percent coordinates of scholia on page.
$(SIGNATURES)
"""
function scholion_heights(mspage::MSPage)
    scholion_height.(mspage.scholia)
end

"""Find tops of *Iliad* lines in original image percent coordinates of scholia on page.
$(SIGNATURES)
"""
function iliad_tops(mspage::MSPage)
    iliad_top.(mspage.scholia)
end


function pageboundbox(mspage::MSPage; digits = 3)::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}
    boxdata = mspage.pagebounds |> MiseEnPage.imagefloats
    
    t = round(boxdata[:top], digits = digits)
    l = round(boxdata[:left], digits = digits)
    b = round(boxdata[:top] + boxdata[:height], digits = digits)
    r = round(boxdata[:left] + boxdata[:width], digits = digits)

    @debug("Here are pagebounds: $(t), $(l), $(b), $(r)")
    (left = l, top = t,  right = r, bottom = b)

end

function pageboxscaled(mspage::MSPage; digits = 3)
    img = load_rgba(mspage.pagebounds)
    @info("Loaded image for $(mspage.pageurn)")
    pageboxscaled(mspage, img; digits = digits)
end

function pageboxscaled(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}};
    digits = 3)
    dimm = size(rgba_img)
    @info("Scale on page + img pair with dimm $(dimm)")
    box = pageboundbox(mspage, digits = digits)
    pageboxscaled(box, dimm[1], dimm[2]; digits = digits)
end

function pageboxscaled(boxtuple::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}, 
    imgheight::Int, imgwidth::Int;
    digits = 3)
    @info("Scaling from tuple $(boxtuple) with ht $(imgheight) and wt $(imgwidth)")
    t = round(boxtuple[:top] * imgheight, digits = digits)
    l = round(boxtuple[:left] * imgwidth, digits = digits)
    b = round((boxtuple[:bottom]) * imgheight, digits = digits)
    r = round((boxtuple[:right]) * imgwidth, digits = digits)
    (left = t, top = t, right = r, bottom = b)
end

function pageboxscaled(boxtuple, rgba_img::Matrix{RGBA{N0f8}})
    dimm = size(rgba_img)
    pageboxscaled(boxtuple,dimm[1], dimm[2])
end

function pageboxscaled(boxtuple, rgb_img::Matrix{RGB{N0f8}})
    dimm = size(rgb_img)
    pageboxscaled(boxtuple,dimm[1], dimm[2])
end


function lefttop_luxor(boxtuple)
    Point( boxtuple[:left], boxtuple[:top])
end


function rightbottom_luxor(boxtuple)
    Point(boxtuple[:right], boxtuple[:bottom])
end

#function luxor_box(boxtuple)
#    # do a box() with lefttop, bottomright
#end