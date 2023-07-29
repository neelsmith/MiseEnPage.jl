#=
Give a MSPage object, use Luxor to plot
the page image with outline of page bounding box.
=#

using MiseEnPage
using CitableObject
using Luxor

pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:47r")
mspage = msPage(pgurn)
img = load_rgba(mspage, w = 400)
dimm = dimensions(img)

@info(dimm)
@png begin
    translate(-1 * dimm[:w] / 2,  -1 * dimm[:h] / 2)
    #@info("traslate $()")
    placeimage(img,O)

    setline(2)
    sethue("green")
    pagebox_luxor(mspage, img)

    sethue("blue")
    iliadbox_luxor(mspage, img)

end  dimm[:w] dimm[:h]
