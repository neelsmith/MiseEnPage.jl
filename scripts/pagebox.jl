#=
Give a MSPage object, use Luxor to plot
the page image with outline of page bounding box.
=#


using MiseEnPage
using CitableObject
using Luxor


pgurn = Cite2Urn("urn:cite2:hmt:msA.v1:47r")
mspage = msPage(pgurn)

function plotpagebounds(pgurn::Cite2Urn)
    pgdata = msPage(pgurn)
    plotpagebounds(pgdata)
end

function plotpagebounds(mspg::MSPage)
    img = MiseEnPage.load_rgba(mspg.pagebounds, alpha = 0.6)
    iheight = size(img)[1]
    iwidth = size(img)[2]

    thebox = MiseEnPage.pageboxscaled(mspg)
    ltpt = MiseEnPage.lefttop_luxor(thebox)
    rbpt = MiseEnPage.rightbottom_luxor(thebox)

    @draw begin
        translate(-1 * iwidth/2,-1 * iheight / 2)
        placeimage(img,O)
        sethue("red")
        circle(ltpt, 20, :fill)
        circle(rbpt, 20, :fill)

        sethue("green")
        setline(10)
        Luxor.box([ltpt, rbpt]; action = :stroke)

    end iwidth iheight
end

# Plot it for a `MSPage`
plotpagebounds(mspage)

# Plot it for page identifed by URN:
plotpagebounds(Cite2Urn("urn:cite2:hmt:msA.v1:47v"))