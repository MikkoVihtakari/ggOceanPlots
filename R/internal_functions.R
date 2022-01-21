#' @title Convert font sizes measured as points to ggplot font sizes
#' @description Converts font sizes measured as points (as given by most programs such as MS Word etc.) to ggplot font sizes
#' @param x numeric vector giving the font sizes in points
#' @return Returns a numeric vector of lenght \code{x} of ggplot font sizes
#' @keywords internal
#' @family size adjustors
#' @export

FS <- function(x) x/2.845276 # x is the desired font / line size in pt

#' @title Convert line sizes measured as points to ggplot line sizes
#' @description Converts line sizes measured as points (as given by most programs such as Adobe Illustrator etc.) to ggplot font sizes
#' @param x numeric vector giving the lines sizes in points
#' @return Returns a numeric vector of lenght \code{x} of ggplot line sizes
#' @keywords internal
#' @family size adjustors
#' @export

LS <- function(x) x/2.13

#' @title Round to pretty log breaks
#' @param x numeric vector to round
#' @param f rounding function: \code{\link{floor}}, \code{\link{ceiling}} or
#'  \code{\link{round}}
#' @keywords internal
#' @author Mikko Vihtakari
#' @seealso \code{\link{round_any}}

pretty_log <- function(x, f = round) {
  x <- round(x, 0)
  
  ifelse(nchar(x) == 1, round_any(x, 5),
         ifelse(nchar(x) == 2 & x < 20, round_any(x, 5),
                ifelse(nchar(x) == 2 & x < 90, round_any(x, 10),
                       ifelse(nchar(x) == 2, round_any(x, 100),
                              ifelse(nchar(x) == 3 & x < 500, round_any(x, 50),
                                     ifelse(nchar(x) == 3, round_any(x, 100),
                                            ifelse(nchar(x) == 4, round_any(x, 1000),
                                                   ifelse(nchar(x) == 5, round_any(x, 10000), round_any(x, 1e5)))))))))
}
