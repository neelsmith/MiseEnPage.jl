```@setup scores
using CitableObject
page_urn = Cite2Urn("urn:cite2:hmt:msA.v1:112r")
using MiseEnPage
pg = msPage(page_urn)
```

# Systematically evaluating hypotheses


The `score_by_proximity_y` function evaluates how successfully the proximity hypothesis predicts the layout of scholia for a single page by comparing the model's placement of scholia with their actual recorded positions.
It has optional parameters that allow you to limit the analysis to a specific set of scholia (default: `msA`, the main scholia of the Venetus A manuscript), and to set a threshhold distance for how close a placement constitutes a successful predicted layout. The threshhold is scaled from 0.0 to 1.0. A threshhold of 1.0 matches anything on the page; a threshhold of 0.0 matches nothing.  The default value of 0.1 considers the model's placement successful when its y value falls within 10% of the actual y value. Compare the following examples

```@example scores
score_default = score_by_proximity_y(mspage; threshhold = 0.1)
```
```@example scores
success_rate(score_default)
```

```@example scores
score15 = score_by_proximity_y(mspage; threshhold = 0.1)
```

```@example scores
success_rate(score15)
```

## Caveats

Missing data for even a single scholion on a page can skew the model's results. 