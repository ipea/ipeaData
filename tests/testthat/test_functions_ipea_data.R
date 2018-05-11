test_that("output_control", {
  d <- data.frame(a=c(1, 2, 3), b=c(1, 5, 6))
  result <- output_control(d)
  expect_equal(c('data.table', 'data.frame'), class(result))
  d <- data.frame(a=c(1, 2, 3), b=c(1, 5, 6))
  result <- output_control(d, type='tibble')
  expect_equal(c('tbl_df','tbl', 'data.frame'), class(result))
})


test_that("basic call", {
  result <- basic_call('http://ipeadata2-homologa.ipea.gov.br/api/v1')
  expect_equal(c('data.table', 'data.frame'), class(result))
})

test_that("ipeaData", {
  suppressWarnings(result <- ipeadata('ADMIS'))
  expect_equal(c('data.table', 'data.frame'), class(result))
  suppressWarnings(result <- ipeadata('SERIE SEM RETORNO'))
  expect_true(is.null(result))
})
