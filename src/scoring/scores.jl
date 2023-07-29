"""Record of score for analysis of a page.
$(SIGNATURES)
"""
struct PageScore
    pgurn::Cite2Urn
    successes::Int
    failures::Int
end

"""Serialize score for a single page.
$(SIGNATURES)
"""
function delimited(pgScore::PageScore; delimiter = ",")
    string(pgScore.pgurn, delimiter, pgScore.successes, delimiter, pgScore.failures)
end

"""Instantiate a single `PageScore` object from a delimited-text source.
$(SIGNATURES)
"""
function resultsfromdelimited(txt; delimiter = ",")
    columns = split(txt, delimiter)
    u = Cite2Urn(columns[1])
    successes = parse(Int, columns[2])
    failures = parse(Int, columns[3])
    PageScore(u, successes, failures)
end

"""Score number of scholia correctly placed on page using proximity model. Optionally specify siglum of scholia to model. If `siglum` is `nothing`, include all scholia.
$(SIGNATURES)
"""
function score_by_proximity(mspage::MSPage; threshold = 0.1, siglum = "msA")::PageScore
  

  
end


"""Score number of scholia correctly placed on page using model
of placement by zone. Optionally specify siglum of scholia to model. If `siglum` is `nothing`, include all scholia.
$(SIGNATURES)
"""
function score_by_zones(mspage::MSPage; threshold = 0.1, siglum = "msA")
    nothing
end