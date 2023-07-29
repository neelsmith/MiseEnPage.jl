

"""Scale percentage coordinate values in the named tuple `boxtuple` to pixels on the image `rgba_img`. Returns a named tuple of floats.
$(SIGNATURES)
"""
function boxscaled(boxtuple, rgba_img::Matrix{RGBA{N0f8}})
    dimm = dimensions(rgba_img)
    boxscaled(boxtuple,dimm[:w], dimm[:h])
end

"""Scale percentage coordinate values in the named tuple `boxtuple` to pixels on the image `rgb_img`. Returns a named tuple of floats.
$(SIGNATURES)
"""
function boxscaled(boxtuple, rgb_img::Matrix{RGB{N0f8}})
    dimm = dimensions(rgb_img)
    boxscaled(boxtuple,dimm[:w], dimm[:h])
end

"""Scale percentage coordinate values in the named tuple `boxtuple` to pixels on an image with height `imgheight` and width `imgwidth`. Returns a named tuple of floats.
$(SIGNATURES)
"""
function boxscaled(boxtuple::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}, 
    imgwidth::Int,  imgheight::Int;
    digits = 3)
    @info("Scaling from tuple $(boxtuple) with ht $(imgheight) and wt $(imgwidth)")
    t = round(boxtuple[:top] * imgheight, digits = digits)
    l = round(boxtuple[:left] * imgwidth, digits = digits)
    b = round((boxtuple[:bottom]) * imgheight, digits = digits)
    r = round((boxtuple[:right]) * imgwidth, digits = digits)
    (left = l, top = t, right = r, bottom = b)
end


"""Scale point `pt` expressed in percentage values to
a new Luxor `Point` scaled to fit the given image dimensions.
$(SIGNATURES)
"""
function pointscaled(pt::Point, 
    imgwidth::Int,  imgheight::Int;
    digits = 3)
    @info("Scaling from point $(pt) with ht $(imgheight) and wt $(imgwidth)")

    x = round(pt.x * imgwidth, digits = digits)
    y = round(pt.y * imgheight, digits = digits)
    Point(x,y)
end


"""Scale point `pt` expressed in percentage values to
a new Luxor `Point` scaled to fit image `rgba_img`
$(SIGNATURES)
"""
function pointscaled(pt::Point, rgba_img::Matrix{RGBA{N0f8}};
    digits = 3)
    @info("Scaling from point $(pt) with ht $(imgheight) and wt $(imgwidth)")
    dimm = dimensions(rgba_img)
    x = round(pt.x * dimm[:w], digits = digits)
    y = round(pt.y * dimm[:h], digits = digits)
    Point(x,y)
end