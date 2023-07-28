# `MiseEnPage`

> Analyze the layout of manuscript pages edited according to the conventions of the Homer Multitext project.



## Notes for "quick start" documentation

The `msPage` function collects all the information needed to analyze a page.




Identify a page by `Cite2Urn`:
```@example intro
using CitableObject
pageid = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
```

```@example intro
using MiseEnPage
pg = msPage(pageid)
```
