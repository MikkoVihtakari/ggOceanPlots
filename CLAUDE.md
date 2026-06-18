# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working on the **package source**. For guidance on *using* ggOceanPlots to analyse data (the AI-assistant-facing manual), see [AGENTS.md](AGENTS.md).

## Package overview

ggOceanPlots is an R package providing water mass classification, temperature-salinity (TS) diagrams, and oceanographic section plots built on ggplot2. It is tuned for the Svalbard region (Kongsfjorden, Rijpfjorden, Isfjorden) but supports custom water mass definitions. Requires **ggplot2 >= 3.4.0** (tested on ggplot2 4.0) — the code uses `linewidth` and tidy-eval `aes(.data[[col]])`, not the pre-3.4 `size`/`aes_string()` API.

## Development commands

```r
devtools::load_all()      # load package in-session during development
devtools::document()      # regenerate NAMESPACE and man/ from roxygen2 comments
devtools::check()         # R CMD check (includes examples as tests)
devtools::install()       # install locally
```

There is no dedicated test suite (`tests/` directory does not exist); examples in roxygen2 `@examples` blocks serve as the primary correctness check and are exercised by `devtools::check()`.

## Architecture

### Core function chain

```
define_water_type()          # classifies T-S points into water masses
    ↑ called by
ts_plot()                    # TS diagram with isopycnals, WM polygons, optional marginal density plots

interpolate_section()        # 2D interpolation wrapper (linear/spline/mba/idw)
    ↑ called by
section_plot()               # oceanographic section (interpolated tiles or bubble plot)

interpolate_spatial()        # spatial IDW interpolation → spatInt S3 class (known to be suboptimal; see README)
plot.spatInt()               # S3 plot method for spatInt objects
```

### Water mass definition (WM) data frames

Water masses are defined as rectangular regions in T-S space. The `WM` data frame schema:

| column | description |
|--------|-------------|
| `type` | full water mass name |
| `abb` | abbreviation used in plots |
| `sal.min`, `sal.max` | salinity bounds |
| `temp.min`, `temp.max` | temperature bounds (use `Inf`/`-Inf` for open-ended) |

Row order determines priority: **earlier rows dominate** when rectangles overlap. Built-in WM data frames: `kongsfjord_watermasses` (default), `rijpfjord_watermasses`, `isfjord_watermasses`.

### ts_plot internals

When `margin_distr = TRUE`, the function bypasses the normal ggplot2 print path and manually assembles a composite using `gtable` + `grid`. The legend is extracted with `cowplot::get_legend` and drawn separately. This means `ts_plot()` with marginal plots does **not** return a ggplot object — it draws directly to the device.

### section_plot internals

All conditional plot layers (`contour`, `bottom`, `sampling_indicator`) are injected as `{if(...) ...}` blocks within the ggplot chain. The `log_y` transformation is applied to the data before plotting, so `ybreaks` must be supplied in original (untransformed) units; the function converts them internally via `log10(y + 10)`.

### Interpolation methods in interpolate_section

- `"mba"` (default in `section_plot`) — multilevel B-spline via `MBA::mba.surf`; best visual results; requires `nx == ny`
- `"linear"` / `"spline"` — via `akima::interp`
- `"idw"` — via `gstat::idw`; not recommended for sections (designed for equal-unit axes)

### Utility helpers

- `FS(x)` — converts font sizes from points to ggplot units (`x / 2.845276`)
- `LS(x)` — converts line sizes from points to ggplot units (`x / 2.13`)
- `pretty_log(x)` — rounds values to human-readable log-scale breaks

### ggplot2 conventions in this codebase

- Column names arrive as character strings and are mapped with tidy eval: `aes(x = .data[[sal_col]], ...)`. Do not reintroduce `aes_string()` (deprecated/removed).
- Use `linewidth` (not `size`) for any line, segment, contour or rectangle aesthetic, and `after_stat(level)` (not `..level..`) for contour labels.
- New non-standard-evaluation symbols introduced in `aes()` must be added to the `globalVariables()` list in `R/zzz.R`, or `R CMD check` raises a "no visible binding" NOTE.

### Known limitations

- `interpolate_spatial()` (and its `plot.spatInt` method) is a direct port from PlotSvalbard and works suboptimally. It depends on ggOceanMaps internals (`map_cmd`, `basemap_data`, `shapefile_list`) and the retiring `sp` package. Prefer `ggOceanMaps` + ggplot2's `geom_contour` for spatial interpolation.
