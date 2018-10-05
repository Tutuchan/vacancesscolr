#' get all bank holidays for a year
#'
#' See [bank_holidays()] for individual functions.
#'
#' @param year an integer
#' @param include_alsace a logical, if TRUE, include the bank holidays
#' from the Alsace-Moselle départements
#'
#' @encoding UTF-8
#' @export
get_year_bank_holidays <- function(year, include_alsace = FALSE) {

  if (!is.numeric(year) | length(year) > 1) {
    stop("'year' must be a numeric of length 1!")
  }

  bhn <- bank_holidays_names_unique()
  if (!include_alsace) {
    bhn <- bhn[bhn != c("vendredi_saint", "saint_etienne")]
  }
  res <- lapply(bhn, function(bh) {
    data.frame(
      type = bh,
      date = bank_holiday(bh)(year),
      stringsAsFactors = FALSE
    )
  })

  res <- Reduce(rbind, res)
  res[order(res$date),]

}

#' pick a bank holiday
#'
#' Note this function returns a function with a `year` parameter.
#'
#' @param type one of the type of bank holidays, see [bank_holidays_names()]
#'
#' @export
bank_holiday <- function(type) {
  switch(
    type,
    "paques" = bh_paques,
    "lundi_paques" = bh_lundi_paques,
    "vendredi_saint" = bh_vendredi_saint,
    "ascension" = bh_ascension,
    "pentecote" = bh_pentecote,
    "jour_an" = bh_jour_an,
    "1 mai" = bh_premier_mai,
    "premier_mai" = bh_premier_mai,
    "fete_travail" = bh_premier_mai,
    "8 mai" = bh_huit_mai,
    "huit_mai" = bh_huit_mai,
    "victoire_allies" = bh_huit_mai,
    "14 juillet" = bh_quatorze_juillet,
    "quatorze_juillet" = bh_quatorze_juillet,
    "fete_nationale" = bh_fete_nationale,
    "15 aout" = bh_quinze_aout,
    "quinze_aout" = bh_quinze_aout,
    "assomption" = bh_quinze_aout,
    "toussaint" = bh_toussaint,
    "11 novembre" = bh_onze_novembre,
    "onze_novembre" = bh_onze_novembre,
    "armistice" = bh_onze_novembre,
    "noel" = bh_noel,
    "saint_etienne" = bh_saint_etienne
  )
}

#' check if a date is a bank holiday
#'
#' @param d a value that can be cast to a Date
#'
#' @export
is_bank_holiday <- function(d) {
  assert_date(d)
  d    <- as.Date(d)
  year <- as.numeric(strftime(d, format = "%Y"))
  bh   <- get_year_bank_holidays(year = year)

  d %in% bh$date
}

#' bank holidays
#'
#' @name bank_holidays
#' @template bh
#' @keywords internal
NULL

#' @rdname bank_holidays
#' @export
bh_paques <- function(year) {

  # intermediate computations
  cm     <- year %% 19
  cent_q <- year %/% 100
  cent_r <- year %% 100
  leap_cent_q <- cent_q %/% 4
  leap_cent_r <- cent_q %% 4

  cp <- (cent_q + 8) %/% 25
  p  <- (cent_q - cp + 1) %/% 3

  e <- (19 * cm + cent_q - leap_cent_q - p + 15) %% 30

  leap_year_q <- cent_r %/% 4
  leap_year_r <- cent_r %% 4

  ld  <- (2 * leap_cent_r + 2 * leap_year_q - e - leap_year_r + 32) %% 7

  corr <- (cm + 11 * e + 22 + ld) %/% 451

  # month and day of year
  q <- e + ld - 7 * corr + 114
  m <- q %/% 31
  d <- q %% 31 + 1

  as.Date(paste(year, m, d, sep = "."), format = "%Y.%m.%d")
}

#' @rdname bank_holidays
#' @export
bh_lundi_paques <- function(year) {
  bh_paques(year) + 1
}

#' @rdname bank_holidays
#' @export
bh_vendredi_saint <- function(year) {
  bh_paques(year) - 2
}

#' @rdname bank_holidays
#' @export
bh_ascension <- function(year) {
  bh_paques(year) + 39
}

#' @rdname bank_holidays
#' @export
bh_pentecote <- function(year) {
  bh_paques(year) + 50
}

#' @rdname bank_holidays
#' @export
bh_jour_an <- function(year) {
  make_date(year, "01", "01")
}

#' @rdname bank_holidays
#' @export
bh_premier_mai<- function(year) {
  make_date(year, "05", "01")
}

#' @rdname bank_holidays
#' @export
bh_fete_travail <- bh_premier_mai

#' @rdname bank_holidays
#' @export
bh_huit_mai <- function(year) {
  make_date(year, "05", "08")
}

#' @rdname bank_holidays
#' @export
bh_victoire_allies <- bh_huit_mai


#' @rdname bank_holidays
#' @export
bh_quatorze_juillet <- function(year) {
  make_date(year, "07", "14")
}

#' @rdname bank_holidays
#' @export
bh_fete_nationale <- bh_quatorze_juillet

#' @rdname bank_holidays
#' @export
bh_quinze_aout <- function(year) {
  make_date(year, "08", "15")
}

#' @rdname bank_holidays
#' @export
bh_assomption <- bh_quinze_aout

#' @rdname bank_holidays
#' @export
bh_toussaint <- function(year) {
  make_date(year, "11", "01")
}

#' @rdname bank_holidays
#' @export
bh_onze_novembre <- function(year) {
  make_date(year, "11", "11")
}

#' @rdname bank_holidays
#' @export
bh_armistice <- bh_onze_novembre

#' @rdname bank_holidays
#' @export
bh_noel <- function(year) {
  make_date(year, "12", "25")
}

#' @rdname bank_holidays
#' @export
bh_saint_etienne <- function(year) {
  make_date(year, "12", "26")
}

make_date <- function(year, month, day) {
  as.Date(paste(year, month, day, sep = "-"))
}
