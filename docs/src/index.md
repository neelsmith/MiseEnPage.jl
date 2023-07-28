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

Information in the model:
 

```@example intro
pageurn(pg)
```

```@example intro
rv(pg)
```

```@example intro
imageurn(pg)
```

```@example intro
iliadrange(pg)
```

```@example intro
iliadlines(pg)
```


```@example intro
page_bbox_roi(pg)
```


```@example intro
iliad_bbox_roi(pg)
```