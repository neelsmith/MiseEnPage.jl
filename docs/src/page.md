
```@setup model
using CitableObject
pageid = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
using MiseEnPage
pg = msPage(pageid)
```


# Modelling a page

Information in the model:
 

```@example model
pageurn(pg)
```

```@example model
rv(pg)
```

```@example model
imageurn(pg)
```

```@example model
iliadrange(pg)
```

```@example model
iliadlines(pg)
```


```@example model
page_bbox_roi(pg)
```


```@example model
iliad_bbox_roi(pg)
```