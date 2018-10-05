context("test-holiday.R")

test_that("zone strings are built correctly", {
  expect_equal(build_zone_string("A"), "vacances_zone_a")
  expect_equal(build_zone_string("a"), "vacances_zone_a")

  expect_equal(build_zone_string(c("A", "B")), c("vacances_zone_a", "vacances_zone_b"))
  expect_equal(build_zone_string(NULL), c("vacances_zone_a", "vacances_zone_b", "vacances_zone_c"))

  expect_error(build_zone_string("F"))
})

test_that("is_holiday returns the desired value and format", {

  expect_is(is_holiday("2018-01-01"), "logical")

  expect_true(is_holiday("2018-01-01"))
  expect_false(is_holiday("2018-01-15"))

  expect_false(is_holiday("2018-03-05", zone = "A"))
  expect_true(is_holiday("2018-03-05", zone = "B"))

})

test_that("get_holidays returns the desired format", {

  expect_is(get_holidays(2018), "data.frame")
  expect_named(
    get_holidays(2018),
    c("date", "vacances_zone_a", "vacances_zone_b", "vacances_zone_c", "nom_vacances")
  )
})

test_that("drop_zone is taken into account", {
  expect_named(
    get_holidays(2018, zone = "C"),
    c("date", "vacances_zone_a", "vacances_zone_b", "vacances_zone_c", "nom_vacances")
  )

  expect_named(
    get_holidays(2018, zone = "C", drop_zones = TRUE),
    c("date", "vacances_zone_c", "nom_vacances")
  )
})

test_that("short names work properly", {
  expect_equal(
    unique(get_holidays(2018, name = "hiver")$nom_vacances),
    "Vacances d'hiver"
  )
})
