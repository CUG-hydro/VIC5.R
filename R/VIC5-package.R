#' @title VIC5: The Variable Infiltration Capacity (VIC) Model version 5 in R
#' @name VIC5
#' @useDynLib VIC5, .registration = TRUE
#' @docType package
#' @importFrom Rcpp sourceCpp
#' @importFrom stats setNames convolve median
#' @importFrom foreach %do% foreach
#' @importFrom utils str read.table
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

.onLoad <- function(libname, pkgname) {
  if(getRversion() >= "2.15.1") {
    utils::globalVariables(c(".", "i"))
  }
}
