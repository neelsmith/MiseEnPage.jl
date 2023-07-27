SERVICE_URL = "http://www.homermultitext.org/iipsrv"
SERVICE_PATH_ROOT = "/project/homer/pyramidal/deepzoom"

"""Instantiate a citable image service.
$(SIGNATURES)
"""
function imgservice()
    IIIFservice(SERVICE_URL, SERVICE_PATH_ROOT)
end

"""Instantiate an `Image` from a URN.
$(SIGNATURES)
"""
function load_rgb(imgurn::Cite2Urn)
    trimmed = dropsubref(imgurn)
	iifrequest = url(trimmed, imgservice())
    f = Downloads.download(iifrequest)
    img = load(f)
	rm(f)
	img
end


"""Instantiate an `Image` from a URN.
$(SIGNATURES)
"""
function load_rgba(imgurn::Cite2Urn; alpha = 1.0)
	RGBA.(load_rgb(imgurn), alpha)
end


"""Extract region-of-interest string from an image URN, and convert to a Vector of `Float64`s, rounded to `digits` significant digits.
It is an error if the image URN has a subreference with invalid syntax.
$(SIGNATURES)
"""
function imagefloats(imgu::Cite2Urn; digits = 3)
    if hassubref(imgu)
        
        parts = split(subref(imgu),",")
        @debug("Find floats for subreference with parts $(parts)")
        if length(parts) == 4
            floats = map(roi -> parse(Float64, roi), parts)
            rounded = map(num -> round(num, digits=digits), floats)
            (left = rounded[1], top = rounded[2], width = rounded[3], height = rounded[4])
        else
            throw(ArgumentError("""Invalid region of interest in urn `$(imgu)`:  expression must have four comma-separated parts.""")) 
        end

    else
        nothing
    end
end