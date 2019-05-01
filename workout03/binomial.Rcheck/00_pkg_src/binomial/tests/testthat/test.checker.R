library(testthat)

context("tests for checker functions")

# Test check_prob
test_that("the check_prob works with normal input",{
  expect_equal(check_prob(0.5),TRUE)
  expect_length(check_prob(0.2),1)
  expect_type(check_prob(0.3), "logical")
  
} )

# Test check_trials
test_that("the check_trials works with negative integer",{
  expect_euqal(check_trials(-5),TRUE)
  expect_length(check_trials(-5),1)
  expect_type(check_trials(-5),"logical")
  
})

# Test check_success
test_that("the check_success works with normal input",{
  expect_true(check_success(5,10))
  expect_length(check_success(5,10),1)
  expect_type(check_trials(15),"logical")
  
} )