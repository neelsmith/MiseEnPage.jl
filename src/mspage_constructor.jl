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
    @debug("TYPE Of scholia pairs is $(typeof(scholiapairs))")
    iliadboundingbox = iliadboundbox(scholiapairs)
    
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

#function iliadboundbox(textpairs::Vector{Union{Nothing, MiseEnPage.ScholionIliadPair}}; digits = 3)::Union{Nothing, NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}}

"""Get a containing rectangle for the *Iliad* lines on a page.
`iliadlines` should be a Vector with *Iliad* lines on a single page;
`dse` is a DSE collection covering those lines.
$(SIGNATURES)
"""
function iliadboundbox(textpairs; digits = 3)::Union{Nothing, NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}}
    @debug("iliadboundbox: Textpairs is a $(typeof(textpairs))")
    if isempty(textpairs)
        nothing
    else
        topval = MiseEnPage.iliad_top.(textpairs) |> minimum
        bottomval = MiseEnPage.iliad_bottom.(textpairs) |> maximum
        leftval = MiseEnPage.iliad_left.(textpairs) |> minimum
        rightval = MiseEnPage.iliad_right.(textpairs) |> maximum

        (left = leftval, top = topval, right = rightval, bottom = bottomval)
    end
end