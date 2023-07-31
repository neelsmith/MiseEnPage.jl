using MiseEnPage
using CitableObject
using Luxor

pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:195r")
mspage = msPage(pgurn)
img = load_rgba(mspage, w = 400)
dimm = dimensions(img)


topbox = MiseEnPage.topzone_box()
bottombox = MiseEnPage.bottomzone_box()
sidebox = MiseEnPage.adjacentzone_box()

function boxer(boxcoords, pagedimm)
    lt = Point(boxcoords[:left] * pagedimm[:w], boxcoords[:top] * pagedimm[:h])
    rb = Point(boxcoords[:left] * pagedimm[:w] + boxcoords[:width] * pagedimm[:w], boxcoords[:top]*pagedimm[:h] + boxcoords[:height]*pagedimm[:h])
    
    box(lt, rb, :stroke)
end

@draw begin
    translate(-1 * dimm[:w]/2,  -1 * dimm[:h]/2)
    placeimage(img,O)
    sethue("goldenrod2")
    boxer(topbox, dimm)
    boxer(bottombox, dimm)
    sethue("orchid")
    boxer(sidebox, dimm)

    
    
end dimm[:w] dimm[:h]