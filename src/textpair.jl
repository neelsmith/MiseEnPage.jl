"""A scholion paired with the *Iliad* line it comments on.
Each text passage has a corresponding image with region of interest.
`lineindex` is the relative position of the Iliad text on its page.
"""
struct ScholionIliadPair
    scholion::CtsUrn
    scholionbox::Cite2Urn
    iliadline::CtsUrn
    iliadbox::Cite2Urn
    lineindex::Union{Int, Nothing}
end

"""
"""
function scholion_height(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.scholionbox)
    @debug("scholion_height: coords are $(coords)")
    round(coords[4], digits = digits)
end

"""
"""
function iliad_top(sipair::ScholionIliadPair)
    coords = imagefloats(sipair.iliadbox)
    coords[2]
end