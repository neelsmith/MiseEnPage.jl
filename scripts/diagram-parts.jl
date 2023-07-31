using MiseEnPage
using CitableObject
using Luxor

pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:195r")
mspage = msPage(pgurn)
img = load_rgba(mspage, w = 400)
dimm = dimensions(img)

@draw begin
    translate(-1 * dimm[:w]/2,  -1 * dimm[:h]/2)
    placeimage(img,O)
    
    
end dimm[:w] dimm[:h]