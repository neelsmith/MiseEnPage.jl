"""URN identifying page `mspage`.
$(SIGNATURES)
"""
function pageurn(mspage::MSPage)::Cite2Urn
    mspage.pageurn
end

"""Determine if page is `:recto` or `:verso`.
$(SIGNATURES)
"""
function rv(mspage::MSPage)
    mspage.folioside
end

"""URN for documentary image illustrating page.
$(SIGNATURES)
"""
function imageurn(mspage::MSPage)
    dropsubref(mspage.pagebounds)
end

"""Lines of *Iliad* on page `mspage`.
Returns a (possibly empty) vector of URNs.
$(SIGNATURES)
"""
function iliadlines(mspage::MSPage)
    mspage.iliadlines
end

"""Compose a CTS URN for the range of *Iliad*
lines on page `mspage`.  Returns `nothing` if 
there are no *Iliad* lines  on the page.
$(SIGNATURES)
"""
function iliadrange(mspage::MSPage)::Union{CtsUrn, Nothing}
    lines_v = iliadlines(mspage)
    if isempty(lines_v)
        nothing
    else
        psgrange = string(passagecomponent(lines_v[1]), "-", passagecomponent(lines_v[end]))
        addpassage(lines_v[1], psgrange)
    end
end

"""Find a bounding box for the physical page `mspage`
on a documentary image.
Returns a named tuple of floats.
$(SIGNATURES)
"""
function page_bbox_roi(mspage::MSPage; digits = 3)::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}
    boxdata = mspage.pagebounds |> MiseEnPage.imagefloats
    
    t = round(boxdata[:top], digits = digits)
    l = round(boxdata[:left], digits = digits)
    b = round(boxdata[:top] + boxdata[:height], digits = digits)
    r = round(boxdata[:left] + boxdata[:width], digits = digits)

    @debug("Here are pagebounds: $(t), $(l), $(b), $(r)")
    (left = l, top = t,  right = r, bottom = b)
end

"""Find a bounding box on a documentary image for the *Iliad* lines on page `mspage`.
Returns a named tuple of floats.
$(SIGNATURES)
"""
function iliad_bbox_roi(mspage::MSPage; digits = 3)::NamedTuple{(:left, :top, :right, :bottom), NTuple{4, Float64}}
    mspage.iliad_bbox
end


function load_rgba(mspage::MSPage; alpha = 0.6)
    load_rgba(imageurn(mspage); alpha = alpha)
end





"""Find height in image percent coordinates of scholia on page.
$(SIGNATURES)
"""
function scholion_heights(mspage::MSPage)
    scholion_height.(mspage.scholia)
end

"""Find tops of *Iliad* lines in image percent coordinates of scholia on page.
$(SIGNATURES)
"""
function iliad_tops(mspage::MSPage)
    iliad_top.(mspage.scholia)
end

