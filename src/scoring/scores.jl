"""Record of score for analysis of a page.
$(SIGNATURES)
"""
struct PageScore
    pgurn::Cite2Urn
    successes::Int
    failures::Int
end


"""URN of page scored.
$(SIGNATURES)
"""
function pageurn(score::PageScore)
    score.pgurn
end

"""Number of scholia successfully modeled.
$(SIGNATURES)
"""
function successes(score::PageScore)
    score.successes
end

"""Number of scholia unsuccessfully modeled.
$(SIGNATURES)
"""
function failures(score::PageScore)
    score.failures
end


"""Total number of scholia on page.
$(SIGNATURES)
"""
function total(score::PageScore)
    score.failures + score.successes
end


"""Success rate of model's layout (0.0:1.0).
$(SIGNATURES)
"""
function success_rate(score::PageScore)
    round(score.successes / total(score), digits = 3)
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
function score_by_proximity_y(mspage::MSPage; threshhold = 0.1, siglum = "msA")#::PageScore
  
    predicted_ys = model_by_proximity_y(mspage; siglum = siglum)
    actual_ys = scholion_tops(mspage; siglum = siglum)
    sheep = 0
    goats = 0
    for (i, y) in enumerate(predicted_ys)
        absdiff = round(abs(actual_ys[i] - y), digits = 3)
        @debug(y, " => ", actual_ys[i], " diff ", absdiff)
        if  absdiff > threshhold
            goats = goats + 1
        else
            sheep = sheep + 1
        end
    end
    PageScore(pageurn(mspage), sheep, goats)
end


"""Score number of scholia correctly placed on page using model
of placement by zone. Optionally specify siglum of scholia to model. If `siglum` is `nothing`, include all scholia.
$(SIGNATURES)
"""
function score_by_zones(mspage::MSPage; threshold = 0.1, siglum = "msA")
    
    predicted = model_by_zones(mspage; siglum = siglum)
    actual = scholia_by_zones(mspage; siglum = siglum)
    sheep = 0
    goats = 0
    for i in 1:length(actual)
        if predicted[i] == actual[i]
            sheep = sheep + 1
        else
            goats = goats + 1
        end
    end
    PageScore(pageurn(mspage), sheep, goats)
end
