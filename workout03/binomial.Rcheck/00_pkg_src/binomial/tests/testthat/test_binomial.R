library(testthat)

context("tests for binomial functions")

#bin_choose
test_that("bin_choose works with normal input", {
  expect_equal(bin_choose(n = 5, k = 2),10)
  expect_length(bin_choose(n = 5, k = 2),1)
  expect_type(bin_choose(n = 5, k = 2),"double")
})

#bin_probability
test_that("bin_probability works with normal input", {
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_type(bin_probability(success = 2, trials = 10, prob = 0.5), "double")
  expect_length(bin_probability(success = 4, trials = 10, prob = 0.5), 1)
})

#bin_distribution
test_that("bin_distribution works with normal input", {
  expect_is(bin_distribution(trials = 5, prob = 0.5), c("bindis","data.frame"))
  expect_type(bin_distribution(trials = 5, prob = 0.5),"list")
  expect_length(bin_distribution(trials = 5, prob = 0.5), 2)
})


#bin_cumulative
test_that("bin_cumulative works with normal input", {
  expect_is(bin_cumulative(trials = 10, prob = 0.5), c("bincum", "data.frame"))
  expect_type(bin_cumulative(trials = 10, prob = 0.5),"list")
  expect_length(bin_cumulative(trials = 10, prob = 0.5),3)
})