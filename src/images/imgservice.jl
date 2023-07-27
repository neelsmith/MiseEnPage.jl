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
function loadimage(imgurn::Cite2Urn; alpha = 1.0)
    trimmed = dropsubref(imgurn)
	iifrequest = url(trimmed, imgservice())
    f = Downloads.download(iifrequest)
    img = load(f)
	rm(f)
	RGBA.(img, alpha)
end