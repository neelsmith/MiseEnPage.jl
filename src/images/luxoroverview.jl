
"""Draw in an interactive Luxor environment a diagram of the y alignment of scholia for page `pg` according to the promixity model.
$(SIGNATURES)
"""
function visualize_proximity_y_draw(pg::MSPage; w = 400)
    img = load_rgba(pg; w = w)
    visualize_proximity_y_draw(pg, img)
end


"""Draw in an interactive Luxor environment a diagram of the y alignment of scholia for page `pg` according to the promixity model.
$(SIGNATURES)
"""
function visualize_proximity_y_draw(pg::MSPage, img::Matrix{RGBA{N0f8}})
    dimm = dimensions(img)
    @draw begin
        visualize_proximity_y_luxor(pg, img)
    end dimm[:w] dimm[:h]
end

"""Save a diagram of the y alignment of scholia for page `pg` according to the promixity model as a `png` file.
$(SIGNATURES)
"""
function visualize_proximity_y_png(pg::MSPage, img::Matrix{RGBA{N0f8}})
    dimm = dimensions(img)
    @png begin
        visualize_proximity_y_luxor(pg, img)
    end dimm[:w] dimm[:h]
end


"""Compose a Luxor diagram of the y alignment of scholia for page `pg` according to the promixity model. This
code will only work within a Luxor drawing context.
$(SIGNATURES)
"""
function visualize_proximity_y_luxor(mspage::MSPage, img::Matrix{RGBA{N0f8}})
    dimm = dimensions(img)
    translate(-1 * dimm[:w] / 2,  -1 * dimm[:h] / 2)
    placeimage(img,O)


    setline(2)
    sethue("lightblue3")
    setdash("dot")
    pagebox_luxor(mspage, img)

    if ! isempty(textpairs(mspage))
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
end



