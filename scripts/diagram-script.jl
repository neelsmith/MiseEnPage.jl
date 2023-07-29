using MiseEnPage
using CitableObject
using Luxor

pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:47r")
mspage = msPage(pgurn)
img = load_rgba(mspage, w = 400)

# And in short..
visualize_proximity_png(mspage, img)
visualize_proximity_draw(mspage, img)