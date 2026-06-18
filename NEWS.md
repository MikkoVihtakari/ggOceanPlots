# ggOceanPlots 0.2.0

Modernisation release. The package now works with **ggplot2 >= 3.4.0** (including
ggplot2 4.0).

## Breaking / compatibility

* Replaced the deprecated `aes_string()` with tidy-evaluation (`aes(.data[[col]])`)
  throughout `ts_plot()` and `section_plot()`.
* Replaced the deprecated line `size` aesthetic with `linewidth` in all line,
  segment, contour and rectangle layers. ggplot2 (>= 3.4.0) is now required.
* Replaced the deprecated `..level..` contour computed variable with
  `after_stat(level)` in `section_plot()`.
* Replaced fragile `class(x) == "..."` checks with `inherits()`.

## Documentation

* Added `AGENTS.md`, a guide for using ggOceanPlots with an AI assistant.
* Added a getting-started vignette (`vignette("ggOceanPlots")`).
* Added a pkgdown configuration (`_pkgdown.yml`).
* Expanded the README with rendered examples.

## Notes

* `interpolate_spatial()` remains a direct port from PlotSvalbard and is known to
  work suboptimally. For spatial interpolation prefer ggOceanMaps together with
  ggplot2's `geom_contour()`.
