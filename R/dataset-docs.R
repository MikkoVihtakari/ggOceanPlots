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
#' @references Pérez-Hernández, M. D., Pickart, R. S., Pavlov, V., Våge, K., Ingvaldsen, R., Sundfjord, A., Renner, A. H. H., et al. 2017. The Atlantic Water boundary current north of Svalbard in late summer. Journal of Geophysical Research: Oceans, 122: 2269–2290. https://doi.wiley.com/10.1002/2016JC012486.
#' 
#' Cottier, F., Tverberg, V., Inall, M., Svendsen, H., Nilsen, F., and Griffiths, C. 2005. Water mass modification in an Arctic fjord through cross-shelf exchange: The seasonal hydrography of Kongsfjorden, Svalbard. Journal of Geophysical Research, 110: C12005. https://doi.wiley.com/10.1029/2004JC002757.
#' @format data.frame
"rijpfjord_watermasses"

#' @title Water mass definitions for Kongsfjorden
#' @docType data
#' @keywords datasets
#' @family ts_plot
#' @name kongsfjord_watermasses
#' @description A dataframe containing water mass definitions for Kongsfjorden. An example of formatting of the \code{WM} argument in \code{\link{define_water_type}}
#' @details A pre-made \code{\link[=define_water_type]{WM}} data frame for the NPI's Kongsfjorden transect (also called MOSJ transect). The water types are returned after the definition in Cottier et al. (2005) with slight modifications to avoid overlaps of water types. \strong{Density} boundaries have not been implemented as these seem to have relatively little meaning in tested data after limiting water types using temperature and salinity.
#' @references Cottier, F., Tverberg, V., Inall, M., Svendsen, H., Nilsen, F., and Griffiths, C. 2005. Water mass modification in an Arctic fjord through cross-shelf exchange: The seasonal hydrography of Kongsfjorden, Svalbard. Journal of Geophysical Research, 110: C12005. https://doi.wiley.com/10.1029/2004JC002757.
#' @format data.frame
"kongsfjord_watermasses"

#' @title Water mass definitions for Isfjorden
#' @docType data
#' @keywords datasets
#' @family ts_plot
#' @name isfjord_watermasses
#' @description A dataframe containing water mass definitions for Isfjorden. Transformed Atlantic Water (TAW) temperature maximum (originally 3 degrees Celcius) has been removed to include values in between Intermediate Water (IW) and Atlantic Water (AW) into the classification. Further, the maximum salinity limit for TAW has been removed as intended by the authors (Fig. 5, defined wrong in Table 1). Finally, the minimum salinity of Winter Cooled Water (originally 34.4) was changed to the maximum salinity of Arctic Water to avoid overlap. 
#' 
#' @details A pre-made \code{\link[=define_water_type]{WM}} data frame for Isfjorden from Skogseth et al. (2020).
#' @references Skogseth, R., Olivier, L. L. A., Nilsen, F., Falck, E., Fraser, N., Tverberg, V., Ledang, A. B., et al. 2020. Variability and decadal trends in the Isfjorden (Svalbard) ocean climate and circulation – An indicator for climate change in the European Arctic. Progress in Oceanography, 187: 102394. https://doi.org/10.1016/j.pocean.2020.102394.
#' @format data.frame
"isfjord_watermasses"

#' @title Chlorophyll-a recordings in Kongsfjorden
#' @docType data
#' @keywords datasets
#' @name chlorophyll
#' @usage data(chlorophyll)
#' @format A dataframe containing following columns:
#' \itemize{
#'   \item Name. Sample name.
#'   \item Station. Sampling station.
#'   \item lon. Longitude of the sampling location in decimal degrees
#'   \item lat. Latitude of the sampling location in decimal degrees.
#'   \item lon.utm. Longitude of the sampling location as UTM coordinates (\code{"+init=epsg:32633"})
#'   \item lat.utm. Latitude of the sampling location as UTM coordinates (\code{"+init=epsg:32633"})
#'   \item From. Sampling depth (m)
#'   \item Chla. Chlorophyll-a value (mg/m3)
#'  }
#' @source Norwegian Polar Institute (\url{https://data.npolar.no/home/})
"chlorophyll"
