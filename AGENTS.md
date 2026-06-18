# AGENTS.md — using ggOceanPlots with an AI assistant

This file is written for AI assistants that are helping a user *use* ggOceanPlots
to analyse and plot oceanographic data. For working on the package source itself,
see [CLAUDE.md](CLAUDE.md).

## What this package does

ggOceanPlots makes three things easy from a plain data frame of CTD / bottle data:

1. **Water-mass classification** — `define_water_type()` labels each T-S point.
2. **Temperature-salinity (TS) diagrams** — `ts_plot()` with isopycnals, water-mass
   polygons and optional marginal density plots.
3. **Section plots** — `section_plot()` for interpolated sections or bubble plots
   along a transect.

`ts_plot()` and `section_plot()` return regular ggplot2 objects (one exception
below), so you extend and save them with normal ggplot2 syntax.

```r
library(ggOceanPlots)
ts_plot(ctd_kongsfjord)                        # TS diagram, default Kongsfjorden water masses
section_plot(ctd_rijpfjord, x = "dist", y = "pressure", z = "temp",
             bottom = "bdepth", interpolate = TRUE)
```

## Input data shape

A **long/tidy data frame**, one row per observation. Column names are passed as
character strings, so the columns can be named anything.

* `ts_plot()` / `define_water_type()` need a **salinity** and a **temperature**
  column (defaults `sal_col = "sal"`, `temp_col = "temp"`). Use **potential
  temperature** and **practical salinity** if you rely on the built-in water masses.
* `section_plot()` needs an x (distance/longitude), y (depth/pressure) and z
  (the variable) column, passed as `x=`, `y=`, `z=`.

The bundled example data (`ctd_kongsfjord`, `ctd_rijpfjord`, `chlorophyll`) show
the expected layout — use them for runnable examples.

## Minimal working examples

### Classify water masses

```r
wt <- define_water_type(ctd_kongsfjord)              # factor, one label per row
dt <- define_water_type(ctd_kongsfjord, bind = TRUE) # original data + `watertype` column
```

### TS diagram

```r
ts_plot(ctd_kongsfjord)                              # colour = water type (default)
ts_plot(ctd_kongsfjord, color = "area")              # colour scaled to a data column
ts_plot(ctd_kongsfjord, color = "red")               # one fixed colour, no scaling
ts_plot(ctd_kongsfjord, zoom = FALSE)                # show the full water-mass diagram
ts_plot(ctd_kongsfjord, margin_distr = TRUE)         # add marginal density plots
```

The `color` argument is overloaded — this trips people up:

| value of `color` | behaviour |
|---|---|
| `"watertype"` (default) | colour by classified water mass, predefined palette |
| a column name in the data | colour scaled to that variable |
| a name from `colors()` e.g. `"red"` | every point that one fixed colour |

### Section plot

```r
# Interpolated CTD section (multilevel B-spline by default)
section_plot(ctd_rijpfjord, x = "dist", y = "pressure", z = "temp",
             bottom = "bdepth", interpolate = TRUE)

# log y-axis to see the surface when stations differ a lot in depth
section_plot(ctd_rijpfjord, x = "dist", y = "pressure", z = "temp",
             bottom = "bdepth", interpolate = TRUE, log_y = TRUE,
             contour = c(-1.8, 0, 1, 3))             # add labelled contours

# Bubble plot (interpolate = FALSE, the default) for sparse samples
section_plot(chlorophyll[grepl("KpN.|Kb[0-4]", chlorophyll$Station), ],
             x = "lon", y = "From", z = "Chla")
```

### Custom water masses

Pass a `WM` data frame to `ts_plot()` / `define_water_type()`. Built-ins:
`kongsfjord_watermasses` (default), `rijpfjord_watermasses`, `isfjord_watermasses`.

```r
ts_plot(ctd_rijpfjord, WM = rijpfjord_watermasses)
ts_plot(dt, WM = NULL)                                # no polygons / no classification
```

A `WM` data frame has columns `type`, `abb`, `sal.min`, `sal.max`, `temp.min`,
`temp.max`. Each row is a **rectangle** in salinity (x) – temperature (y) space.
Use `Inf` / `-Inf` for open-ended bounds. When rectangles overlap, the row that
comes **first** wins, so a point gets exactly one water type.

```r
my_wm <- data.frame(
  type     = c("Warm", "Cold"),
  abb      = c("W", "C"),
  sal.min  = c(34.5, -Inf), sal.max = c(Inf, 34.5),
  temp.min = c(2, -Inf),    temp.max = c(Inf, 2)
)
ts_plot(my_df, WM = my_wm)
```

### Extend and save

```r
p <- ts_plot(ctd_kongsfjord) +
  ggplot2::ggtitle("Kongsfjorden")
ggplot2::ggsave("ts.png", p, width = 6, height = 5, dpi = 300)
```

## Common pitfalls

1. **`color =` is overloaded.** See the table above. `"watertype"`, a column name,
   and a literal colour all do different things. A literal colour only takes effect
   when it is a valid `colors()` name.

2. **`ts_plot(..., margin_distr = TRUE)` does not return a ggplot object.** With
   marginal density plots the function assembles a `gtable`/`grid` composite and
   draws it directly to the device. You cannot `+` more layers onto it or `ggsave()`
   the return value — capture it with `grid`/`cowplot` or save the device instead.
   Without `margin_distr`, `ts_plot()` returns a normal ggplot object.

3. **Use potential temperature + practical salinity with the built-in water masses.**
   The bundled `WM` definitions (and the isopycnals) assume theta and practical
   salinity. In-situ temperature will misclassify points.

4. **`section_plot()` needs more than one unique x value to interpolate.** A single
   station cannot be interpolated; the function warns and returns the input.

5. **`log_y` breaks are in original units.** With `log_y = TRUE` the y data are
   transformed internally as `log10(y + 10)`; supply `ybreaks` in real depths
   (e.g. `c(0, 50, 100)`), not transformed values.

6. **`interpolate = TRUE` with `interp_method = "mba"` (the default) needs `nx == ny`.**
   The MBA backend only handles square output grids.

7. **For spatial (map) interpolation, prefer ggOceanMaps.** `interpolate_spatial()`
   is a legacy port and works suboptimally. Use
   [ggOceanMaps](https://mikkovihtakari.github.io/ggOceanMaps/) plus ggplot2's
   `geom_contour()` instead.

## Where to find more

- Getting started: `vignette("ggOceanPlots")`
- Function reference and source: <https://github.com/MikkoVihtakari/ggOceanPlots>
- Issues / bug reports: <https://github.com/MikkoVihtakari/ggOceanPlots/issues>
- For maps of the same data, see the companion package
  [ggOceanMaps](https://github.com/MikkoVihtakari/ggOceanMaps).
