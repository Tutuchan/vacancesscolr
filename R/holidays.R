#' check if a date is a holiday
#'
#' @param d a value that can be cast to a Date
#' @template zone
#'
#' @export
is_holiday <- function(d, zone = NULL) {

  assert_date(d)
  d <- as.Date(d)
  s <- subset(vacances, date == d)
  zone_str <- build_zone_string(zone)

  any(s[, zone_str] == TRUE)

}

#' get all holidays for a year
#'
#' Note that you can use short names instead of full names (see [full_holidays_names()])
#'
#' @param year a vector of integers between 2008 and 2018
#' @template zone
#' @param name a character, the name of the holiday period
#' @param drop_zones a logical, if TRUE and `zone` is not NULL, return only the specified zones
#'
#' @export
get_year_holidays <- function(year, zone = NULL, name = NULL, drop_zones = FALSE) {

  assert_year(year)
  # Year subset
  year <- as.numeric(year)
  s    <- subset(
    vacances,
    as.numeric(substr(date, 1, 4)) %in% year & !is.na(nom_vacances)
  )

  # Zone subset
  zone_str    <- build_zone_string(zone)
  zone_subset <- apply(s[zone_str], 1, any)
  if (drop_zones) {
    dz <- c("date", zone_str, "nom_vacances")
  } else {
    dz <- names(vacances)
  }
  s <- s[zone_subset, dz]

  # Name subset
  if (!is.null(name)) {
    name <- assert_name(name)
    s    <- s[s$nom_vacances == name,]
  }

  row.names(s) <- 1:nrow(s)
  s
}

globalVariables("nom_vacances")

