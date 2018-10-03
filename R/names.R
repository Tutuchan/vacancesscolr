#' available holidays names
#'
#' @export
full_holidays_names <- function() {
  .holidays_names
}

#' @rdname full_holidays_names
#' @export
short_holidays_names <- function() {
  .short_holidays_names
}

.holidays_names <- c("Vacances de No\u00EBl", "Vacances d'hiver", "Vacances de printemps", "Vacances d'\u00E9t\u00E9", "Vacances de la Toussaint")
.short_holidays_names <- c("noel", "hiver", "printemps", "ete", "toussaint")
