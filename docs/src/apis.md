# API documentation


## Exported functions


### Modelling page layout

```@docs
MSPage
msPage
pageurn
rv
imageurn
iliadlines
iliadrange
textpairs
page_bbox_roi
page_top
page_bottom
page_right
page_left
iliad_bbox_roi
```

### Analyzing page layout

```@docs
PageScore
score_by_proximity_y
score_by_zones
successes
failures
total
success_rate
delimited
resultsfromdelimited
```


### Documentary images

```@docs
load_rgba
dimensions
```

### Composing visualizations with Luxor

```@docs
pagebox_luxor
iliadbox_luxor
```

## Functions used internally

### Working with page layout data

```@docs
MiseEnPage.ScholionIliadPair
MiseEnPage.pairtexts
MiseEnPage.iliadboundbox
MiseEnPage.scholion_heights
MiseEnPage.scholion_height
MiseEnPage.scholion_tops
MiseEnPage.scholion_top
MiseEnPage.iliad_tops
MiseEnPage.iliad_top
```

### Working with images and Luxor diagrams

```@docs
MiseEnPage.imagefloats
MiseEnPage.imgservice
MiseEnPage.load_rgb
MiseEnPage.boxscaled
MiseEnPage.pageboxscaled
MiseEnPage.iliadboxscaled
MiseEnPage.pointscaled
```
