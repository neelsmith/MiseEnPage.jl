"""Record of score for analysis of a page.
$(SIGNATURES)
"""
struct PageScore
    pgurn::Cite2Urn
    successes::Int
    failures::Int
end