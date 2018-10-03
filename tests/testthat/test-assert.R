context("test-assert.R")

test_that("assert_date is viable", {
  # valid objects
  expect_true(assert_date("2018-01-01"))
  expect_true(assert_date("2018/01/01"))
  expect_true(assert_date(Sys.time()))
  expect_true(assert_date(as.POSIXlt("2018-01-01 01:45:26")))

  # invalid objects
  expect_error(assert_date("asdf"))
  expect_error(assert_date(4687542))

})

test_that("assert_year is viable", {

  expect_true(assert_year(2010))
  expect_true(assert_year("2015"))

  expect_error(assert_year(1990))
  expect_error(assert_year("asdf"))
  expect_error(assert_year(FALSE))
})

test_that("assert_name is viable", {

  for (name in .holidays_names) {
    expect_equal(assert_name(name), name)
  }

  for (name in .short_holidays_names) {
    idx <- which(.short_holidays_names == name)
    expect_equal(assert_name(name), .holidays_names[idx])
  }

  expect_error(assert_name("wrong"))

})
