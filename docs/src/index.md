# `MiseEnPage`

> Analyze the layout of manuscript pages edited according to the conventions of the Homer Multitext project.


## Shortest possible example: evaluate and visualize layout hypothesis


To analyze the layout of a manuscript page, identify the page by `Cite2Urn`. You'll need the `CitableObject` package for that.

```@example intro
using CitableObject
pageid = Cite2Urn("urn:cite2:hmt:msA.v1:112r")
```

Assemble all information necessary to analyze the page's layout in a `MSPage` object.

```@example intro
using MiseEnPage
pg = msPage(pageid)
```

Now score the "proximity" hypothesis.

```@example intro
score_by_proximity_y(pg)
```

Load a documentary image for the page, and visualize the page's layout under the proximity hypothesis compared to the actual layout.  (This last step requires the `Luxor` graphics package.)


```@example intro
img = load_rgba(pg; w = 400)

using Luxor
visualize_proximity_y_draw(pg, img)
```