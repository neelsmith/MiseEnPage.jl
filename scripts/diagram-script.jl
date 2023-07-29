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

#=
@png begin
    translate(-1 * dimm[:w] / 2,  -1 * dimm[:h] / 2)
    placeimage(img,O)

    setline(2)
    sethue("lightblue3")
    setdash("dot")
    pagebox_luxor(mspage, img)

    sethue("gainsboro")
    setdash("solid")
    setline(2)
    iliadbox_luxor(mspage, img)

    sethue("gray")
    setline(1)
    commented_lines_luxor(mspage, img)

    sethue("green")
    plot_actual_y_luxor(mspage, img)

    sethue("darkorange")
    plot_proximity_y_luxor(mspage, img)
end  dimm[:w] dimm[:h]
=#


# And in short..
visualize_proximity_draw(mspage, img)