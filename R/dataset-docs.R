#' @title Example CTD data for Rijpfjorden
#' @docType data
#' @keywords datasets
#' @family ts_plot section_plot
#' @name ctd_rijpfjord
#' @description A dataframe containing an example CTD transect data from Rijpfjorden.
#' @format data.frame
"ctd_rijpfjord"

#' @title Example CTD data for Kongsfjorden
#' @docType data
#' @keywords datasets
#' @family ts_plot
#' @name ctd_kongsfjord
#' @description A dataframe containing example CTD data for Kongsfjorden.
#' @format data.frame
"ctd_kongsfjord"

#' @title Water mass definitions for Rijpfjorden
#' @docType data
#' @keywords datasets
#' @family ts_plot
#' @name rijpfjord_watermasses
#' @description A dataframe containing water mass definitions for Rijpfjorden.
#' @details A pre-made \code{\link[=define_water_type]{WM}} data frame for the NPI's Rijpfjorden transect. The water types in this classification have been modified from Pérez-Hernández et al. (2017), which was originally made for the same region without the fjord. The changes include addition of Winter Cooled Water from Cottier et al. (2005) and exlusion of density in the categorization. Instead, salinity threshold of 34.87 for Atlantic and Arctic Intermediate Waters (AIW) was used. This decision is purely due to the difficulty of programming polygons in 3D space. It may cause very minor changes in water mass classification at the boundary of AIW and PSW.
#' @format data.frame
"rijpfjord_watermasses"

#' @title Water mass definitions for Kongsfjorden
#' @docType data
#' @keywords datasets
#' @family ts_plot
#' @name kongsfjord_watermasses
#' @description A dataframe containing water mass definitions for Kongsfjorden. An example of formatting of the \code{WM} argument in \code{\link{define_water_type}}
#' @details A pre-made \code{\link[=define_water_type]{WM}} data frame for the NPI's Kongsfjorden transect (also called MOSJ transect). the water types are returned after the definition in Cottier et al. (2005) with slight modifications to avoid overlaps of water types. \strong{Density} boundaries have not been implemented as these seem to have relatively little meaning in tested data after limiting water types using temperature and salinity.
#' @format data.frame
"kongsfjord_watermasses"
