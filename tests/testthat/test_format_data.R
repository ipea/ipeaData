test_that("format data", {
  result <- format_data(Sys.Date())
  expect_equal(format(Sys.Date(), "%m/%Y"), result)
})
