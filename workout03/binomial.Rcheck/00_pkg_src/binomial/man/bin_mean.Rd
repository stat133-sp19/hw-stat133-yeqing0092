% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/function.R
\name{bin_mean}
\alias{bin_mean}
\title{Binomial Mean}
\usage{
bin_mean(trials, prob)
}
\arguments{
\item{trials}{Number of (fixed) trials in the binomial distribution.}

\item{prob}{the probability of success on each trial.}
}
\value{
mean of binomial distribution
}
\description{
Computes the mean of the binomial distribution
}
\examples{
bin_mean(10,0.3)
}
