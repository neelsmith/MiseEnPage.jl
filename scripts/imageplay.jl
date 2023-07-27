using MiseEnPage
using CitableObject
using Luxor


pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:47r")
mspg = msPage(pgurn)

img = MiseEnPage.load_rgba(mspg.pagebounds, alpha = 0.6)


iheight = size(img)[1]
iwidth = size(img)[2]

page_bbox = MiseEnPage.pageboundbox(mspg)

function scalepct(pixels, pct)
    pct * pixels
end

@draw begin
    translate(-1 * iwidth/2,-1 * iheight / 2)
	placeimage(img,O)
    tl = Point(scalepct(iheight,page_bbox[:top]), scalepct(iwidth,page_bbox[:left]))
    tr = Point(scalepct(iheight,page_bbox[:top]), scalepct(iwidth,page_bbox[:right]))
    line(tl, tr, :stroke)
    circle(tl, 5, :fill )
end iwidth iheight
