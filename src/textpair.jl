"""A scholion paired with the *Iliad* line it comments on.
Each text passage has a corresponding image with region of interest.
"""
struct BoxedTextPair
    scholion::CtsUrn
    scholionbox::Cite2Urn
    iliadline::CtsUrn
    iliadbox::Cite2Urn
    lineindex::Union{Int, Nothing}
end
