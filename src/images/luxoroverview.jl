
function visualize_proximity_draw(pg::MSPage, img::Matrix{RGBA{N0f8}})
    dimm = dimensions(img)
    @draw begin
        visualize_proximity_luxor(pg, img)
    end dimm[:w] dimm[:h]
end


function visualize_proximity_png(pg::MSPage, img::Matrix{RGBA{N0f8}})
    dimm = dimensions(img)
    @png begin
        visualize_proximity_luxor(pg, img)
    end dimm[:w] dimm[:h]
end

function visualize_proximity_luxor(mspage::MSPage, img::Matrix{RGBA{N0f8}})
    dimm = dimensions(img)
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
end



