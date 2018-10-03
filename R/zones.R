#' build the zone string
#'
#' @template zone
#'
#' @keywords internal
build_zone_string <- function(zone) {
  if (is.null(zone)) {
    zone <- .holidays_zones
  } else {
    if (!all(tolower(zone) %in% .holidays_zones)) {
      stop("'", toString(zone), "' is not a valid zone!")
    }
    zone <- tolower(zone)
  }

  paste("vacances_zone", zone, sep = "_")
}

.holidays_zones <- c("a", "b", "c")
