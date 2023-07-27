"""Model page of a manuscript.
"""
struct MSPage
    pageurn::Cite2Urn
    iliadlines::Vector{CtsUrn}
    scholia::Vector{ScholionIliadPair}
    imagezone::Cite2Urn
    folioside
    top_zone_cutoff
    bottom_zone_cutoff
    
end


function msPage(pageurn::Cite2Urn; data = nothing)::Union{MSPage, Nothing}
    hmtdata = isnothing(data) ? hmt_cex() : data
    dse = hmt_dse(hmtdata)[1] 
    textpassages = textsforsurface(pageurn, dse)

    iliadreff =  filter(u -> startswith(workcomponent(u), "tlg0012.tlg001."), textpassages)
    iliadstrings = map(u -> string(u),iliadreff)

    allcommentary = hmt_commentary(hmtdata)[1]
    
    scholiareff = filter(psg -> startswith(workcomponent(psg), "tlg5026"), textpassages)
    scholiapairs = map(scholiareff) do s
        iliadmatches = filter(pr -> pr[1] == s, allcommentary.commentary)
        if length(iliadmatches) == 1
            iliad = iliadmatches[1][2]
            lineindex = findfirst(isequal(string(iliad)), iliadstrings)

            schimagematches = imagesfortext(s, dse)
            ilimagematches = imagesfortext(iliad, dse)

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


   



    
    izone = Cite2Urn("urn:cite2:fake:no.no:")
    side = nothing
    topthresh = nothing
    bottomthresh = nothing
    MSPage(pageurn, iliadreff, scholiapairs, izone, side, topthresh, bottomthresh)
end