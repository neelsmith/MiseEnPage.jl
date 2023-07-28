
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
    dimm = size(rgba_img)
    @info("Scale on page + img pair with dimm $(dimm)")
    box = page_bbox_roi(mspage, digits = digits)
    boxscaled(box, dimm[1], dimm[2]; digits = digits)
end


"""Scales percentage coordinate values in the named tuple `boxtuple` to pixels on an image with height `imgheight` and width `imgwidth`. Returns a named tuple of floats.
$(SIGNATURES)
"""
function boxscaled(boxtuple::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}, 
    imgheight::Int, imgwidth::Int;
    digits = 3)
    @info("Scaling from tuple $(boxtuple) with ht $(imgheight) and wt $(imgwidth)")
    t = round(boxtuple[:top] * imgheight, digits = digits)
    l = round(boxtuple[:left] * imgwidth, digits = digits)
    b = round((boxtuple[:bottom]) * imgheight, digits = digits)
    r = round((boxtuple[:right]) * imgwidth, digits = digits)
    (left = t, top = t, right = r, bottom = b)
end

function pageboxscaled(boxtuple, rgba_img::Matrix{RGBA{N0f8}})
    dimm = size(rgba_img)
    pageboxscaled(boxtuple,dimm[1], dimm[2])
end

function pageboxscaled(boxtuple, rgb_img::Matrix{RGB{N0f8}})
    dimm = size(rgb_img)
    pageboxscaled(boxtuple,dimm[1], dimm[2])
end


function page_lefttop_luxor(boxtuple)
    Point( boxtuple[:left], boxtuple[:top])
end


function page_rightbottom_luxor(boxtuple)
    Point(boxtuple[:right], boxtuple[:bottom])
end
