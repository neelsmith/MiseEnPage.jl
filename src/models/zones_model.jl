
function model_by_zones(mspage::MSPage; siglum = "msA")
    toplimit = top_bottom_zone_width(siglum = siglum)
    
end



"""Rank the relative sequence of an *Iliad* line `i`
in one of the three page zones.
$(SIGNATURES)
"""
function iliad_zone(i::Int; span = 6, linesonpage = 24)
    if i > linesonpage 
        throw(ArgumentError("iliad_zone: line number ($(i)) cannot be greater than number of lines on page ($(linesonpage))."))
    elseif i <= span
        :top
    elseif i >= (linesonpage  - span)
        :bottom
    else
        :middle
    end
end


"""Place top of scholion bounding box in one of three page zones.
$(SIGNATURES)
"""
function scholion_zone(textpair::ScholionIliadPair, topbound, bottombound)

end
