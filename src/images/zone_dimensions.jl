
# Reasonable defaults for column boundaries.
EXTERIOR_WIDTH = 0.22
EXTERIOR_RECTO_LEFT = 0.58
EXTERIOR_RECTO_RIGHT = EXTERIOR_RECTO_LEFT + EXTERIOR_WIDTH
EXTERIOR_VERSO_LEFT = 0.24
EXTERIOR_VERSO_RIGHT = EXTERIOR_VERSO_LEFT + EXTERIOR_WIDTH

ZONE_TOP = (left = 0.17, top = 0.12, width = 0.62, height = 0.08)
# urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.1665,0.1280,0.6176,0.08357
ZONE_ADJACENT = (left = 0.59, top = 0.21, width = 0.21, height = 0.53 )
# urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.5756,0.2086,0.2077,0.5275
ZONE_BOTTOM = (left = 0.16, top = 0.74, width = 0.63, height = 0.18)
# urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.1525,0.7427,0.6310,0.1785


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
