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
