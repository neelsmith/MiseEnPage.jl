
# Reasonable defaults for column boundaries.
EXTERIOR_WIDTH = 0.22
EXTERIOR_RECTO_LEFT = 0.58
EXTERIOR_RECTO_RIGHT = EXTERIOR_RECTO_LEFT + EXTERIOR_WIDTH
EXTERIOR_VERSO_LEFT = 0.24
EXTERIOR_VERSO_RIGHT = EXTERIOR_VERSO_LEFT + EXTERIOR_WIDTH

ZONE_TOP = (left = 0.18, top = 0.11, width = 0.61, height = 0.05)
ZONE_ADJACENT = (left = 0.61, top = 0.17, width = 0.19, height = 0.55 )
ZONE_BOTTOM = (left = 0.18, top = 0.73, width = 0.61, height = 0.1)



"""Find location of top zone for scholia in manuscript `siglum`.
$(SIGNATURES)
"""
function topzone_box(; siglum = "msA")
    if siglum == "msA"
        ZONE_TOP
    else
        @warn("Default zone widths not yet defined for MS $(siglum); using values for Venetus A.")
        topzone_box(; siglum = "msA")
    end
end

"""Find location of bottom zone for scholia in manuscript `siglum`.
$(SIGNATURES)
"""
function bottomzone_box(; siglum = "msA")
    if siglum == "msA"
        ZONE_BOTTOM
    else
        @warn("Default zone widths not yet defined for MS $(siglum); using values for Venetus A.")
        bottomzone_box(; siglum = "msA")
    end
end

"""Find location of adjacent (middle) zone for scholia in manuscript `siglum`.
$(SIGNATURES)
"""
function adjacentzone_box(; siglum = "msA")
    if siglum == "msA"
        ZONE_ADJACENT
    else
        @warn("Default zone widths not yet defined for MS $(siglum); using values for Venetus A.")
        bottomzone_box(; siglum = "msA")
    end
end
