#' available holidays names
#'
#' @export
holidays_names_full <- function() {
  .holidays_names
}

#' @rdname holidays_names_full
#' @export
holidays_names_short <- function() {
  .holidays_names_short
}

#' @rdname holidays_names_full
#' @export
bank_holiday_names <- function() {
  .bank_holiday_names
}

#' @rdname holidays_names_full
#' @export
bank_holiday_names_unique <- function() {
  res <- .bank_holiday_names
  res[!res %in% c("1 mai", "premier_mai", "8 mai", "huit_mai", "14 juillet", "quatorze_juillet",
               "15 aout", "quinze_aout", "11 novembre", "onze_novembre")]
}

.holidays_names <- c("Vacances de No\u00EBl", "Vacances d'hiver", "Vacances de printemps", "Vacances d'\u00E9t\u00E9", "Vacances de la Toussaint")
.holidays_names_short <- c("noel", "hiver", "printemps", "ete", "toussaint")
.bank_holiday_names <- c("paques", "lundi_paques", "vendredi_saint", "ascension", "pentecote", "jour_an",
  "1 mai", "premier_mai", "fete_travail", "8 mai", "huit_mai", "victoire_allies",
  "14 juillet", "quatorze_juillet", "fete_nationale", "15 aout", "quinze_aout", "assomption",
  "toussaint", "11 novembre", "onze_novembre", "armistice", "noel", "saint_etienne"
)
