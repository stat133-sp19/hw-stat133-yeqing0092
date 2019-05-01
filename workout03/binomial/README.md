
<!-- README.md is generated from README.Rmd. Please edit that file -->
`{r, include = FALSE} knitr::opts_chunk$set(   collapse = TRUE,   comment = "#>",   fig.path = "man/figures/README-",   out.width = "100%" )` \# binomial

<!-- badges: start -->
<!-- badges: end -->
Overview
--------

`"binomial"` is a minimal [R](http://www.r-project.org/) package that provides functions to simulate calculating binomial distribution.

-   `bin_choose()` Calculates the number of combinations in which k successes can occur in n trials.
-   `bin_probability()` Calculates the probability in whick k successes can occur in n trials with a constant probability of success on each trial.
-   `bin_distribution()` obtain a data with the probability distribution, producing a `"dis"` object.
-   `plot()` method for a `"dis"` object to plot the histogram of the probability distribution.
-   `bin_cumulative()` obtain a data with the cumulative probability distribution, producing a `"cum"` object.
-   `plot()` method for a `"cum"` object to Plot the cumulative probability distribution.
-   `bin_variable()` list with named elements for binomial variables, producing a `"bin"` object.
-   `summary()` method for a `"bin"` object, listing with named elements and summary for binomial variables
-   `bin_mean()` The expected value or mean of a binomial distribution.
-   `bin_variance()` The variance of a binomial distribution.
-   `bin_mode()` The most likely number of a binomial distribution distribution.
-   `bin_skewness()` Skewness is a measure of the asymmetry of the probability distribution of a random variable about its mean.
-   `bin_kurtosis()` The Kurtosis is a measure of the "tailedness" of the probability distribution of a random variable.

Motivation
----------

This package has been developed to illustrate some of the concepts behind the creation of an R package.

Installation
------------

Install the development version from GitHub via the package `"devtools"`:

``` r
# development version from GitHub:
#install.packages("devtools") 
# install "binomial" (without vignettes)
devtools::install_github("stat133-sp19/hw-stat133-yeqing0092/workout03/binomial")
# install "binomial" (with vignettes)
devtools::install_github("stat133-sp19/hw-stat133-yeqing0092/workout03/binomial", build_vignettes = TRUE)
```

Usage
-----

``` {r}
library(binomial)
# Finding the number of combination in getting 3 heads in 4 tosses.
bin_choose(n=4,k=3)

# Calculates the probability of getting 3 heads in 4 tosses of a fair coin.
bin_probability(success = 3,trials = 4,prob = 0.5)

# the probability distribution for 4 tosses of a fair coin
dis1 <- bin_distribution(trials = 4, prob = 0.5)
dis1

# Plot
plot(dis1)

# The cumulative probability distribution for 4 tosses of a fair coin.
dis2 <- bin_cumulative(4,0.5)
dis2

# Plot
plot(dis2)

# list with named elements binomial distribution for 4 tosses of a fair coin
bin1 <- bin_variable(trials = 4, prob = 0.5)
bin1

# summary
binsum1 <- summary(bin1)
binsum1


#mean
bin_mean(4,0.5)

#variance
bin_variance(4, 0.5)

#mode
bin_mode(4, 0.5)

#skewness
bin_skewness(4, 0.5)

#kurtosis
bin_kurtosis(4, 0.5)
```
