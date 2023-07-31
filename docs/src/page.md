
```@setup model
using CitableObject
pageid = Cite2Urn("urn:cite2:hmt:msA.v1:112r")
using MiseEnPage
pg = msPage(pageid)
```


# Modelling a page

The `MSPage` type models the information needed to analyze page layout.  The following series of functions exposing that information are mostly self explanatory. (See the API documentation for further details.)
 

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

## Text pairs

The `MSPage` object also includes a vector of `MiseEnPage.ScholionIliadPair`s.  This is a type that 

```@example model
textpairs(pg)
```