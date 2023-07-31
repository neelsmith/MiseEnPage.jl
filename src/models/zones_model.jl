
function model_by_zones()
end



"""Rank the relative sequence of an *Iliad* line `i`
in one of the three page zones.
$(SIGNATURES)
"""
function iliadzone(i::Int; span = 6, linesonpage = ASSUMED_LINES)
    if i <= span
        :top
    elseif i >= (linesonpage  - span)
        :bottom
    else
        :middle
    end
end
