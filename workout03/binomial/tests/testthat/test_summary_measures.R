library(testthat)


context("Test for summary measures")

# aux_mean function
test_that("aux_mean works with normal inputs",{
  expect_equal(aux_mean(10,0.3),3)
  expect_length(aux_mean(10,0.3),1)
  expect_type(aux_mean(10,0.3), "double")
})

# aux_variance function
test_that("aux_variance works with normal inputs",{
  expect_equal(aux_variance(10,0.3),2.1)
  expect_length(aux_variance(10,0.3),1)
  expect_type(aux_variance(10,0.3),"double")
})

# aux_mode function
test_that("aux_mode works with normal inputs",{
  expect_equal(aux_mode(10,0.3), 3)
  expect_length(aux_mode(10,0.3),1)
  expect_type(aux_mode(10,0.3),"integer")
})

# aux_skewness function
test_that("aux_skewness works with normal inputs",{
  expect_equal(aux_skewness(10,0.3),(1-2*0.3)/sqrt(10*0.3*(1-0.3)))
  expect_length(aux_skewness(10,0.3),1)
  expect_type(aux_skewness(10,0.3),"double")
})

# aux_kurtosis function
test_that("aux_kurtosis works with normal inputs",{
  expect_equal(aux_kurtosis(10,0.3),(1-6*0.3*(1-0.3))/(10*0.3*(1-0.3)))
  expect_length(aux_kurtosis(10,0.3),1)
  expect_type(aux_kurtosis(10,0.3),"double")
})