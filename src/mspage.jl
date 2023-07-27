"""Model page of a manuscript.
"""
struct MSPage
    pageurn::Cite2Urn
    iliadlines
    scholia#::Vector{BoxedTextPair}
    imagezone::Cite2Urn
    folioside
    
end


function msPage(pageurn::Cite2Urn; data = nothing)::Union{MSPage, Nothing}
    hmtdata = isnothing(data) ? hmt_cex() : data
    dse = hmt_dse(hmtdata)[1] 
    textpassages = textsforsurface(pageurn, dse)
    iliad =  filter(u -> startswith(workcomponent(u), "tlg0012.tlg001."), textpassages)

    allcommentary = hmt_commentary(hmtdata)[1]



    scholia = []
    izone = Cite2Urn("urn:cite2:fake:no.no:")
    side = nothing
    MSPage(pageurn, iliad, scholia, izone, side)
end