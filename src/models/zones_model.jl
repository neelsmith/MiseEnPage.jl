
function scholia_by_zones(mspage::MSPage; siglum = "msA")    
    ilbox =  iliad_bbox_roi(mspage)
    map(mspage.scholia) do pr
        scholion_zone(pr, ilbox[:top], ilbox[:bottom])
    end
end

"""Model page layout putting each scholion in one of three zones.
"""
function model_by_zones(mspage::MSPage; siglum = "msA")    
    linecount = mspage.iliadlines |> length
    map(mspage.scholia) do pr
        iliad_zone(pr.lineindex; linesonpage = linecount)
    end
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
    if scholion_top(textpair) < topbound
        :top
    elseif scholion_top(textpair) > bottombound
        :bottom
    else
        :middle
    end
end
