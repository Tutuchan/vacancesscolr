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

#' when will we be on holidays?
#'
#' When will we be on holidays in France?
#' Check for your zone using the `zone` param.
#'
#' @inheritParams is_holiday
#'
#' @return The date of the next holidays
#' @export
#'
#' @examples
#' next_holidays(zone = "C")
next_holidays <- function(zone = NULL){
  res <- get_year_holidays(format(Sys.Date(), "%Y"), zone = zone)
  res <- res[res$date > Sys.Date(), ]
  res[1, ]
}

#' how many days until the next holidays?
#'
#' how many days until the next holidays in France?
#' Check for your zone using the `zone` param.
#'
#' @inheritParams is_holiday
#' @param quiet whether or not to return a message
#'
#' @return the number of days before the next holidays
#' @export
#'
#' @examples
#' days_until_holidays()
days_until_holidays <- function(zone = NULL, quiet = FALSE){
  res  <- next_holidays(zone)
  days <- difftime(res$date, Sys.Date())
  if (!quiet) {
    cat(
      "Still", days, "days before the next holidays:", res$nom_vacances,
      "start on", as.character(res$date), "!\n"
    )
    invisible(as.numeric(days))
  } else {
    as.numeric(days)
  }
}


#' are we on holidays?
#'
#' are we on holidays somewhere in France?
#' Check for your zone using the `zone` param.
#'
#' @inheritParams days_until_holidays
#'
#' @return a logical, TRUE if we are on holidays, FALSE otherwise.
#' @export
#'
#' @examples
#' is_it_holidays()
is_it_holidays <- function(zone = NULL, quiet = FALSE){
  res <- get_year_holidays(format(Sys.Date(), "%Y"), zone = zone)
  is_it <- Sys.Date() %in% res$date
  if (!quiet){
    if (is_it){
      cat("Yes it is \\o/", "\n")
    } else {
      cat("No it's not ¯\\_(ツ)_/¯")
    }
    invisible(is_it)
  } else {
    is_it
  }
}
