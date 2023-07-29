
function visualize_proximity_draw(pg::MSPage, img)
    dimm = dimensions(img)
    @draw begin
        visualize_promity_luxor(pg, img)
    end dimm[:w] dimm[:h]
end

function visualize_proximity_luxor(mspage::MSPage, img)
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