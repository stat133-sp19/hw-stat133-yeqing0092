library(testthat)

context("tests for checker functions")

# Test check_prob
test_that("the check_prob works with normal input",{
  expect_equal(check_prob(prob = 0.5),TRUE)
  expect_length(check_prob(prob = 0.5),1)
  expect_type(check_prob(prob = 0.5), "logical")

} )

# Test check_trials
test_that("the check_trials works with negative integer",{
  expect_euqal(check_trials(trials = -5),TRUE)
  expect_length(check_trials(trials = -5),1)
  expect_type(check_trials(trials = -5),"logical")

})

# Test check_success
test_that("the check_success works with normal input",{
  expect_length(check_success(success = 5,trials = 10),1)
  expect_type(check_success(success = 5,trials = 10),"logical")
  expect_true(check_success(success = 5,trials = 10))

} )
