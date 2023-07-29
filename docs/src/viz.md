```@setup viz
using CitableObject
page_urn = Cite2Urn("urn:cite2:hmt:msA.v1:44r")
using MiseEnPage
pg = msPage(page_urn)
```

# Brief tutorial: visualizing page layout

`MiseEnPage` includes high-level functions for retrieving a documentary image for a page, and for diagramming page layout data using the `Luxor` graphics package.  These functions make it straightforward to visualize the layout problem and analysis.

## Documentary image

Continuing with the example page from the preceding documentation, we can load a documentary image for a page with the `load_rgba` function. Optional parameters let you scale the resulting image to a given width (`w`), and to set the alpha channel of the image (on a scale of 0.0 to 1.0).

```@example viz
img = load_rgba(pg; w = 200, alpha = 0.4)
```

In Julia, an image is just a normal Julia matrix of pixel values (here, `RGBA` values). 

```@example viz
img |> typeof
```
!!! info "Using images in Julia"
     See the [`JuliaImages` documentation](https://juliaimages.org/latest/) or watch the wonderful [video introduction](https://computationalthinking.mit.edu/Fall23/images_abstractions/images/) by Grant Sanderson (3blue1brown), part of MIT's "Computational Thinking" course, if you want to learn more about working with images in Julia.


`MiseEnPage` includes a convenience function to save the width and height of the image in a named tuple.

```@example viz
dimm = dimensions(img)
```

## Diagramming page layout with Luxor

Luxor includes shorthand macros to create diagrams as files on disk (e.g., `@png`) or for display in an interactive environment (`@draw`). You can specify a width and height for the resulting image following the macro's `begin`..`end` block. This boilerplate code uses the dimensions we just saved to create a drawing space of the same dimensions as our image.


 ```@example viz
using Luxor
# Boilerplate framework:
@draw begin

    
end dimm[:w] dimm[:h]
```

Next, we'll use two standard Luxor functions to place the image in the drawing space, `translate` and `placeimage`.  By default, Luxor places the coordinate origin at the center of the drawing space, but's easier to draw on the image if we align the coordinate system's origin (0,0) to be the top left corner of the space.  We can do that by shifting the origin up and to the left (both negative directions) for one half the size of our image. (That's the `translate` function in the following code snippet.)  Then we'll place the image at the origin, here named with the Luxor shorthand `O` (the letter `O`).

```@example viz
@draw begin
     translate(-1 * dimm[:w]/2,  -1 * dimm[:h]/2)
     placeimage(img,O)
     
end dimm[:w] dimm[:h]
```

Now we have our image in a Luxor drawing space where we can continue our diagram. `MiseEnPage` includes functions you can use to add to the composition of a Luxor drawing.


- `pagebox` draws a rectangle around the physical page
- `iliadbox` draws a rectangle around the block of edited *Iliad* text

You can mix these in with normal Luxor functions like `sethue` and `setline`, as in the following example.


```@example viz
@draw begin
     translate(-1 * dimm[:w]/2,  -1 * dimm[:h]/2)
     placeimage(img,O)
     sethue("green")
     setline(2)
     pagebox_luxor(pg, img)
     sethue("blue")
     iliadbox_luxor(pg, img)
     sethue("gray")
      commented_lines_luxor(pg, img)
end dimm[:w] dimm[:h]
```


!!! info "More information about Luxor"
    See the excellent Luxor [documentation (including tutorial)](https://juliagraphics.github.io/Luxor.jl/stable/) if you want to learn more about creating graphics with Luxor.
