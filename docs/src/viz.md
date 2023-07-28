```@setup viz
using CitableObject
pageurn = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
using MiseEnPage
pg = msPage(pageurn)
```

# Visualizing page layout

`MiseEnPage` includes functions to retrieve a documentary image for a page, and for diagramming page layout data using the `Luxor` graphics package.

## Documentary image

Continuing with the example page from the preceding documentation, we can load a documentary image for a page with the `load_rgba` function. Optional parameters let you scale the resulting image to a given width (`w`), and to set the alpha channel of the image (on a scale of 0.0 to 1.0).

```@example viz
img = load_rgba(pg; w = 200, alpha = 0.4)
```
```@example viz
img |> typeof
```
In Julia, an image is just a normal Julia matrix of pixel values (here, `RGBA` values). 

!!! info "Using images in Julia"
     See the [`JuliaImages` documentation](https://juliaimages.org/latest/) or watch the wonderful [video introduction](https://computationalthinking.mit.edu/Fall23/images_abstractions/images/) by Grant Sanderson (3blue1brown), part of MIT's "Computational Thinking" course, if you want to learn more about working with images in Julia.


## Diagramming with Luxor

!!! info "More information about Luxor"
    See the excellent Luxor [documentation (including tutorial)](https://juliagraphics.github.io/Luxor.jl/stable/) if you want to learn more about creating graphics with Luxor.


