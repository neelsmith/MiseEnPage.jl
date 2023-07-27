# `MiseEnPage`

> Analyze the layout of manuscript pages edited according to the conventions of the Homer Multitext project.



## Notes for documentation

The `msPage` function collects all the information needed to analyze a page.

This can be handy:

```@example intro
using HmtArchive.Analysis
data = hmt_cex()
```

Identify a page by `Cite2Urn`:
```@example intro
using CitableObject
pageurn = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
```

```@example intro
using MiseEnPage
pg = msPage(pageurn; data = data)
```