
"""Find a bounding box for the physical page scaled
to pixels on the image downloaded for the page RoI urn.
Returns a named tuple of floats.
$(SIGNATURES)
"""
function pageboxscaled(mspage::MSPage; digits = 3)
    img = load_rgba(mspage.pagebounds)
    @info("Loaded image for $(mspage.pageurn)")
    pageboxscaled(mspage, img; digits = digits)
end

"""Find a bounding box for the physical page `mspage` scaled
to pixels on the image `rgba_img`.
Returns a named tuple of floats.
$(SIGNATURES)
"""
function pageboxscaled(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}};
    digits = 3)
    dimm = dimensions(rgba_img)
    @debug("Scale on page + img pair with dimm $(dimm)")
    box = page_bbox_roi(mspage, digits = digits)
    boxscaled(box, dimm[:w], dimm[:h]; digits = digits)
end


function iliadboxscaled(mspage::MSPage, rgba_img::Matrix{RGBA{N0f8}}; digits = 3)
    box = iliad_bbox_roi(mspage, digits = digits)
    dimm = dimensions(rgba_img)
    boxscaled(box,   dimm[:w], dimm[:h]; digits = digits)
end

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


"""Create a Luxor `box` command to draw a box on image `img`
around the physical page illustrated there.
$(SIGNATURES)
"""
function pagebox_luxor(pg::MSPage, img; luxoraction = :stroke)
    coords = pageboxscaled(pg, img)
    ltpt = Point(coords[:left], coords[:top])
    rbpt = Point(coords[:right], coords[:bottom])
    @info("Boxing points $(ltpt), $(rbpt)")
    box(ltpt, rbpt, action = luxoraction)
end


"""Create a Luxor `box` command to draw a box  on image `img`
around the block of *Iliad* text on page `pg`.
$(SIGNATURES)
"""
function iliadbox_luxor(pg::MSPage, img; luxoraction = :stroke)
    coords = iliadboxscaled(pg, img)
    ltpt = Point(coords[:left], coords[:top])
    rbpt = Point(coords[:right], coords[:bottom])
    @info("Boxing points $(ltpt), $(rbpt)")
    box(ltpt, rbpt, action = luxoraction)
end