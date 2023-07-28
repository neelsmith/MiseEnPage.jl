# API documentation


## Exported functions


### Modelling and analyzing page layout

```@docs
MSPage
msPage
pageurn
rv
imageurn
iliadlines
iliadrange, 
page_bbox_roi
iliad_bbox_roi
```

### Documentary images

```@docs
load_rgba
dimensions
```

### Composing visualizations with Luxor

```@docs

```

## Functions used internally

### Working with page layout data

```@docs
MiseEnPage.pairtexts
MiseEnPage.iliadboundbox
MiseEnPage.page_bbox_roi
MiseEnPage.scholion_heights
MiseEnPage.scholion_height
```

### Working with images and Luxor diagrams

```@docs
MiseEnPage.imagefloats
MiseEnPage.imgservice
MiseEnPage.load_rgb
MiseEnPage.boxscaled
MiseEnPage.pageboxscaled
```
