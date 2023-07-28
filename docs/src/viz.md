# Visualizing page layout

Get an RGBA image for a page. Continue example from previous page.

```@setup viz
using CitableObject
pageurn = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
using MiseEnPage
pg = msPage(pageurn)
```

```@example viz
img = load_rgba(pg)
```
