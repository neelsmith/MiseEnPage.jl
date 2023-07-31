
# Reasonable defaults for column boundaries.
EXTERIOR_WIDTH = 0.22
EXTERIOR_RECTO_LEFT = 0.58
EXTERIOR_RECTO_RIGHT = EXTERIOR_RECTO_LEFT + EXTERIOR_WIDTH
EXTERIOR_VERSO_LEFT = 0.24
EXTERIOR_VERSO_RIGHT = EXTERIOR_VERSO_LEFT + EXTERIOR_WIDTH

"""Plot actual y alignment of scholia on page `mspage`.
$(SIGNATURES)
"""
function plot_actual_y_luxor(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}};
    siglum = "msA", digits = 3, diam = 2, nudge = 0.1)
    dimm = dimensions(rgba_img)
    
    x = rv(mspage) == :recto ?  EXTERIOR_RECTO_LEFT + nudge :  EXTERIOR_VERSO_LEFT + nudge
    scaled_x = x * dimm[:w]
    
    raw_ys = scholion_tops(mspage; siglum = siglum)
    scaled_ys = map(y -> y * dimm[:h], raw_ys)
    for y in scaled_ys
        circle(Point(scaled_x, y), diam, :fill)
    end
end

"""Plot proximity's placement of scholia on page `mspage`.
$(SIGNATURES)
"""
function plot_proximity_y_luxor(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}};
    siglum = "msA", digits = 3, diam = 2, nudge = 0.05)
    dimm = dimensions(rgba_img)
    
    
    x = rv(mspage) == :recto ?  EXTERIOR_RECTO_LEFT + nudge :  EXTERIOR_VERSO_LEFT + nudge
    scaled_x = x * dimm[:w]

    raw_ys = model_by_proximity(mspage; siglum = siglum)
    scaled_ys = map(y -> y * dimm[:h], raw_ys)
    for y in scaled_ys
        circle(Point(scaled_x, y), diam, :fill)
    end
end


"""Diagram *Iliad* lines with scholia on page `mspage`.
$(SIGNATURES)
"""
function commented_lines_luxor(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}};
    siglum = "msA", digits = 3, diam = 3)
    dimm = dimensions(rgba_img)
    commented_lines_luxor(mspage, dimm[:w], dimm[:h]; diam = diam, digits = digits, siglum = siglum)
end


"""Diagram *Iliad* lines with scholia on page `mspage`.
$(SIGNATURES)
"""
function commented_lines_luxor(mspage::MSPage, imgwidth::Int, imgheight::Int;
    siglum = "msA", digits = 3, diam = 3)
 
    scholionpairs = isempty(siglum) || isnothing(siglum) ? textpairs(mspage) : filter(pr -> workid(pr.scholion) == siglum, textpairs(mspage))

    @info("$(length(scholionpairs)) scholia with siglum $(siglum)")
    coordlists = map(pr -> imagefloats(pr.iliadbox), scholionpairs)

    for quad in coordlists
        leftraw = Point(quad[:left], quad[:top])
        left = pointscaled(leftraw, imgwidth, imgheight)
        rval = quad[:left] + quad[:width]
        rightraw = Point(rval, quad[:top])
        right = pointscaled(rightraw, imgwidth, imgheight)
        midpointraw = Point((rval + quad[:left]) / 2, quad[:top])
        midpoint = pointscaled(midpointraw, imgwidth, imgheight)
        line(left, right, :stroke)
        circle(midpoint, diam, :fill)
    end


end