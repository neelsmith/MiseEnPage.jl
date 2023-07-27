"""Model page of a manuscript.
"""
struct MSPage
    pageurn::Cite2Urn
    folioside
    pagebounds::Cite2Urn

    top_zone_cutoff
    bottom_zone_cutoff

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
    if length(boundsimgs) != 1
        throw(ArgumentError("$(pageurn) does not have indexed page boundaries in the HMT archive"))
    end
    boundsimg = boundsimgs[1][2]

    dse = hmt_dse(hmtdata)[1] 
    
    textpassages = textsforsurface(pageurn, dse)
    iliadreff =  filter(u -> startswith(workcomponent(u), "tlg0012.tlg001."), textpassages)
    scholiareff = filter(psg -> startswith(workcomponent(psg), "tlg5026"), textpassages)

    

    allcommentary = hmt_commentary(hmtdata)[1]
    iliadstrings = map(u -> string(u),iliadreff)
    scholiapairs = pairtexts(scholiareff, allcommentary.commentary, dse, iliadstrings)

    #iliadbounds = iliad

    topzonethresh = nothing
    bottomzonethresh = nothing
    MSPage(
        pageurn, pageside, boundsimg, 
        topzonethresh, bottomzonethresh,
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
function iliadbounds(iliadlines, dse; digits = 3)::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}
    topdse = imagesfortext(iliadlines[1], dse)#[1] |> MiseEnPage.imagefloats
    if length(topdse) != 1
        throw(ArgumentError("iliadbounds: no DSE record found for $(iliadlines[1])"))
    end

    bottomdse = imagesfortext(iliadlines[end], dse)#[1] |> MiseEnPage.
    if length(bottomdse) != 1
        throw(ArgumentError("iliadbounds: no DSE record found for $(iliadlines[end])"))
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