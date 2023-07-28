SERVICE_URL = "http://www.homermultitext.org/iipsrv"
SERVICE_PATH_ROOT = "/project/homer/pyramidal/deepzoom"

"""Instantiate a citable image service.
$(SIGNATURES)
"""
function imgservice()
    IIIFservice(SERVICE_URL, SERVICE_PATH_ROOT)
end

"""Instantiate an `Image` from a URN.  Returns
a matrix of RGB values.
$(SIGNATURES)
"""
function load_rgb(imgurn::Cite2Urn; w = 800)::Matrix{RGB{N0f8}}
    trimmed = dropsubref(imgurn)
	iifrequest = url(trimmed, imgservice(); w = w)
    f = Downloads.download(iifrequest)
    img = load(f)
	rm(f)
	img
end

"""Instantiate an `Image` from a URN.
Returns a matrix of RGBA values.
$(SIGNATURES)
"""
function load_rgba(imgurn::Cite2Urn; w = 800, alpha = 1.0)::Matrix{RGBA{N0f8}}
    img = load_rgb(imgurn; w = w)
	RGBA.(img, alpha)
end

