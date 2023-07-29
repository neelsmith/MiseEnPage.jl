# `MiseEnPage`

> Analyze the layout of manuscript pages edited according to the conventions of the Homer Multitext project.


## Shortest possible example: evaluate alternate hypotheses

To analyze the layout of a manuscript page, identify the page by `Cite2Urn`:
```@example intro
using CitableObject
pageid = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
```

Assemble all necessary information to analyze the page layout.

```@example intro
using MiseEnPage
pg = msPage(pageid)
```
