
# ggOceanPlots

**Water mass classification, TS- and section plots using ggplot2 to aid
analysis of oceanographic data. R package version 0.1.6**

This package contains water mass classification, temperature-salinity-,
and section plot functions from
[PlotSvalbard](https://github.com/MikkoVihtakari/PlotSvalbard). These
functions are more up-to-date in this package, which may eventually be
submitted to CRAN.

Note that the [spatial interpolation
function](https://github.com/MikkoVihtakari/ggOceanPlots/blob/main/R/interpolate_spatial.R)
is a direct translation from PlotSvalbard and works suboptimally at the
moment. Use PlotSvalbard or ggOceanMaps and [the ggplot2
interpolation](https://ggplot2.tidyverse.org/reference/geom_contour.html)
instead of ggOceanPlots for spatial interpolation. Revision of the
spatial interpolation functions in this package may happen eventually.

## Installation

The package can be installed from GitHub using the
[**devtools**](https://cran.r-project.org/web/packages/devtools/index.html)
(or
[remotes](https://cran.r-project.org/web/packages/remotes/index.html))
package:

``` r
devtools::install_github("MikkoVihtakari/ggOceanPlots")
```
