# MiseEnPage.jl

> ☛ *Analyze the layout of manuscript pages edited following the conventions of the Homer Multitext project*.

See the [documentation](https://neelsmith.github.io/MiseEnPage.jl/).

## Visualizations


Interactive Pluto notebook: optimizing placement of *scholia* under the proximity hypothesis:

![demo gif](./mise-en-page.gif)

Results of anlaysis, Venetus A, folio 195 *recto*: theoretical `y` position under the proximity hypothesis versus actual `y` positions:

![page 195 recto](./195r.png)


## Sample data and results of analysis

The Homer Multitext project has not verified that editorial work on all pages reliably includes indexing of all scholia on the page. Because the scoring of layout hypotheses is very sensitive to omissions in the data, it is important to ensure that input data is complete.  The directory `scripts/analyses` includes a list of pages with scholia that have been verified for completeness of coverage, and a julia script that uses the current published release of the HMT project to analyze each page under both the proximity and zoned page hypotheses, and write the results to a pair of `.csv` files.

## Acknowledgments

This package draws heavily on Dennis Ryan's work in the summer of 2023 in collaboration with Neel Smith. Dennis' work is available in [his `MSPageLayout` package](https://github.com/dwryan25/MSPageLayout.jl). We thank the Weiss Summer Research program at Holy Cross for funding Dennis' work. I would also like to thank Kevin Walsh (Mathmatics and Computer Science, College of the Holy Cross) for help understanding the proximity layout model as an optimization problem.
