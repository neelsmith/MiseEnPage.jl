using MiseEnPage
using CitableObject
using Luxor
using HmtArchive.Analysis

cex = hmt_cex()
#pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:195r")
pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:12r")
mspage = msPage(pgurn; data = cex)
img = load_rgba(mspage, w = 400)
dimm = dimensions(img)


@draw begin
    translate(-1 * dimm[:w]/2,  -1 * dimm[:h]/2)
    placeimage(img,O)

    setline(2)
    sethue("lightblue3")
    setdash("dot")
    pagebox_luxor(mspage, img)

    sethue("gray81")
    setdash("solid")
    setline(2)
    iliadbox_luxor(mspage, img)

    sethue("gainsboro")
    zonesboxed_luxor(mspage, img)
end dimm[:w] dimm[:h]