using MiseEnPage
using CitableObject

pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:47r")
mspg = msPage(pgurn)

img = MiseEnPage.loadimage(mspg.pagebounds)
