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

"""Height of scholion's bounding box.
$(SIGNATURES)
"""
function scholion_height(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.scholionbox)
    @debug("scholion_height: coords are $(coords)")
    round(coords[:height], digits = digits)
end

"""Top of scholion's bounding box.
$(SIGNATURES)
"""
function scholion_top(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.scholionbox)
    round(coords[:top], digits = digits)
end


"""Top of *Iliad* text's bounding box.
$(SIGNATURES)
"""
function iliad_top(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.iliadbox)
    round(coords[:top], digits = digits)
end

"""Bottom of *Iliad* text's bounding box.
$(SIGNATURES)
"""
function iliad_bottom(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.iliadbox)
    round(coords[:top] + coords[:height], digits = digits)
end

"""Left of *Iliad* text's bounding box.
$(SIGNATURES)
"""
function iliad_left(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.iliadbox)
    round(coords[:left], digits = digits)
end


"""Right of *Iliad* text's bounding box.
$(SIGNATURES)
"""
function iliad_right(sipair::ScholionIliadPair; digits = 3)
    coords = imagefloats(sipair.iliadbox)
    round(coords[:left] + coords[:width], digits = digits)
end