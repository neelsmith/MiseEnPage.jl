



""".
$(SIGNATURES)
"""
function commented_lines_luxor(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}};
    siglum = "msA", digits = 3)
    dimm = dimensions(rgba_img)
    commented_lines_luxor(mspage, dimm[:w], dimm[:h])
end


""".
$(SIGNATURES)
"""
function commented_lines_luxor(mspage::MSPage, imgwidth::Int, imgheight::Int;
    siglum = "msA", digits = 3)
 
    
    scholionpairs = isempty(siglum) || isnothing(siglum) ? textpairs(mspage) : filter(pr -> workid(pr.scholion) == siglum, textpairs(mspage))

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
        circle(midpoint, 4, :fill)
    end


end