library(httr)
library(dplyr)
resp <- GET("https://raw.githubusercontent.com/AntoineAugusti/vacances-scolaires/master/data.csv")

if (resp$status_code != 200) stop("can't retrieve data")

boolify <- function(x) {
  ifelse(x == "False", FALSE, TRUE)
}

naify <- function(x) {
  ifelse(x == "", NA, x)
}

vacances <- read.csv(text = httr::content(resp)) %>%
  mutate_at(vars(starts_with("vacances")), boolify) %>%
  mutate_at(vars(nom_vacances), naify)

usethis::use_data(vacances, internal = TRUE, overwrite = TRUE)
