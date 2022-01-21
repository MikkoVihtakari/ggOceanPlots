#' @title Return map elements for basemap
#' @description Additional basemap elements to \code{ggOceanMaps::map_cmd}
#' @param command basemap layer to be added
#' @param alternative logical to return alternative formmatting in certain cases. Used to reduce \code{if}-\code{else} statements in \code{\link{basemap}}.
#' @details This is an internal function, which is automatically run by the \code{\link{basemap}} function. Common users do not need to worry about these details. Basemap elements can added together using this function, \code{\link[base]{parse}} and \code{\link[base]{eval}}.
#' @return A character string containing a ggplot2 plotting command. Use \code{eval(parse(text=...))} to plot the string. 
#' @examples ## An example for utm map without glaciers or bathymetry
#' \dontrun{eval(parse(text=paste(map_cmd("base"), map_cmd("land_utm"),
#' map_cmd("grid_utm"), map_cmd("defs_utm"), sep = "+")))}
#' @keywords internal
#' @export
#' @import ggplot2
#' @author Mikko Vihtakari
#' @seealso \code{\link{basemap}}

map_cmd_extra <- function(command, alternative = FALSE) {
  out <- switch(command,
                interpl_surface = '
      geom_tile(data = x$interpolation, aes(x = Lon, y = Lat, fill = var1.pred, color = var1.pred)) + geom_contour(data = x$interpolation, aes(x = Lon, y = Lat, z = var1.pred), color = "black", size = 0.2)
    ',
                defs_interpl_rect = '
      scale_fill_continuous(type = "viridis", limits = col.scale.limits) +
      scale_colour_continuous(type = "viridis", limits = col.scale.limits)
    ',
                stop(paste("map command", command, "not found."))
  )
  
  
  trimws(gsub("\n", " ", out))
}