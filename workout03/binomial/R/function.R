# Binomial Related functions


# 1.1) Private Checker Functions

#Function check_prob()

# title   Check probability Function
# description   check the probability of success.
# param   prob the probabiltiy for which we want to check.
# return  If prob is valid, then check_prob() should return TRUE.If prob is invalid, then check_prob() should return 'invalid prob value'.
# example
# check_prob(0.5)


check_prob <- function(prob){
  if(prob >= 0 & prob <= 1){
    return(TRUE)
  }else{
    stop("invalid prob value")
  }
}


# check_trials()

# title Check trials function
# description Check trials of the binomial Distribution is valid.
# param trials the trials for which we want to check
# return If trials is valid, then check_trials() should return TRUE.If trials is invalid, then check_trials() should return 'invalid trials value'.
# examples
#check_trials(0.33)
#check_trails(3)

check_trials <- function(trials){
  if(trials >= 0 & trials == round(trials)){
    return(TRUE)
  }else{
    stop("invalid trials value")
  }
}



#Check_success()

# title Check success function
# description Check the success fo the binomial distribution is valid.
# param success the vector for which we want to check.
# param trials the non-negative integer.
# return If success is valid, then check_success() should return TRUE. If success is invalid, then check_success() should return 'invalid success value'.
# examples
#check_success(c(2,3),5)
#check_success(2,5)
#check_success(5.2)

check_success <- function(success, trials){
  if(all(success == round(success)) & all(success >= 0) & all(success <= trials)){
    return(TRUE)
  }else{
    stop("incalid success values")
  }
}




#1.2) Private Auxiliary Functions


# title Private Auxiliary Mean Function
# description calculate the mean of the binominal distribution
# param prob Probability of success in the binomial distribution.
# param trials Number of trials in the binomial distribution.
# return the mean of the binominal distribution
# examples
#aux_mean(10,0.3)

aux_mean <- function(trials,prob){
  return(trials*prob)
}


# title Private Auxiliary Variance Function
# description calculate the variance of the binominal distribution
# param prob Probability of success in the binomial distribution.
# param trials Number of trials in the binomial distribution.
# return the variance of the binominal distribution
# examples
#aux_variance(10,0.3)

aux_variance <- function(trials,prob){
  variance = trials*prob*(1-prob)
  return(variance)
}



# title Private Auxiliary Mode Function
# description calculate the mode of the binominal distribution
# param prob Probability of success in the binomial distribution.
# param trials Number of trials in the binomial distribution.
# return the mode of the binominal distribution
# examples
#aux_mode(10,0.3)

aux_mode <- function(trials,prob){
  m = as.integer(trials*prob+prob)
  if(trials%%2==0){
    return(m)
  }else{
    return(c(m-1,m))
  }
}


# title Private Auxiliary Skewness Function
# description calculate the skewness of the binominal distribution
# param prob Probability of success in the binomial distribution.
# param trials Number of trials in the binomial distribution.
# return the skewness of the binominal distribution
# examples
#aux_skewness(10,0.3)

aux_skewness <- function(trials,prob){
  s = (1-2*prob)/sqrt(trials*prob*(1-prob))
  return(s)
}


# title Private Auxiliary kurtosis Function
# description calculate the kurtosis of the binominal distribution
# param prob Probability of success in the binomial distribution.
# param trials Number of trials in the binomial distribution.
# return the kurtosis of the binominal distribution
# examples
#aux_kurtosis(10,0.3)

aux_kurtosis <- function(trials,prob){
  k = (1-6*prob*(1-prob))/(trials*prob*(1-prob))
  return(k)
}




#1.3) Function bin_choose()


#' @title Bin Choose function
#' @description calculate the number of combinations in which k successes can occur in n trials
#' @param k a variable that represents the number of successes out of n trials.
#' @param n Number of (fixed) trials in the binomial distribution.
#' @return the number of combinations in which k successes can ouucr in n trials
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
#' @export

bin_choose <- function(n,k){
  if(any(k > n)){
    stop("k cannot be greater than n")
  } else{
    choose = factorial(n)/(factorial(k)*factorial(n-k))
  }
  return(choose)
}



#1.4) Function bin_probability()


#' @title Bin probability function
#' @description calculate the probability of getting k successes in n trials
#' @param success a variable that represents the number of successes out of n trials.
#' @param trials Number of (fixed) trials in the binomial distribution .
#' @param prob the probability of success on each trial.
#' @return the probability of getting k successes in n trials
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)
#' @export
bin_probability <- function(success, trials, prob){
  check_prob(prob)
  check_success(success,trials)
  check_trials(trials)
  p = bin_choose(n=trials, k=success)*(prob^success)*((1-prob)^(trials-success))
  return(p)
}



#1.5) Function bin_distribution()


#' @title Bin distribution function
#' @description a data frame with number of success and its probability
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return a data frame with the probability distribution: sucesses in the first column, probability in the second column.
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
#' @export
bin_distribution <- function(trials, prob){
  success <- c(0:trials)
  probability <- bin_probability(success,trials,prob)
  dis <- data.frame(success, probability)
  class(dis) <- c("bindist","data.frame")
  return(dis)
}



#' @export

plot.bindist <- function(x){
  library(ggplot2)
  bin_dis <- ggplot(x, aes(x= x$success, y = x$probability))+
    labs(x="successes", y = "probability")+
    geom_bar(stat = "identity")+
    theme_classic()
  bindist <- bin_dis +
    scale_y_continuous(breaks = seq(0, max(x$probability), by = 0.05))+
    scale_x_continuous(breaks=(seq(0, max(x$success), by = 1)))
  return(bindist)
}



#1.6) Function bin_cumulative()



#' @title Bin cumulative function
#' @description  a data frame with both the probability distribution and the cumulative probabilities
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return  a data frame with both the probability distribution and the cumulative probabilities
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
#' @export


bin_cumulative <- function(trials, prob){
  success <- c(0:trials)
  probability <- bin_probability(success,trials,prob)
  cumulative <- c()
  for(i in 2:length(probability)){
    cumulative[1] <- probability[1]
    cumulative[i] <- cumulative[i-1] + probability[i]
  }
  cum <- data.frame(success, probability,cumulative)
  class(cum) <- c("bincum","data.frame")
  return(cum)
}

#' @export
plot.bincum <- function(x){
  library(ggplot2)
  bincum <- ggplot(data = x, aes(x= x$success, y = x$cumulative)) +
    geom_line() +
    geom_point(shape = 1, size = 3) +
    theme_classic() +
    labs(x = "success", y = "probability")
  bincum <-  bincum +
    scale_y_continuous(breaks = seq(0, 1, by = 0.2))
  return(bincum)
}



#1.7) Function bin_variable()

#' @title Bin variable function
#' @description  a list of binomial random variable object
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return  a list with named elements:trials: number of trials and prob: probability of success
#' @examples
#' bin_variable(trials = 5, prob = 0.5)
#' @export

bin_variable <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  binvar <- list(trials = trials, prob = prob)
  class(binvar) <- c("binvar")
  return(binvar)
}


#' @export
print.binvar <- function(x) {
  cat('"Binomial variable"\n\n')
  cat("Parameters\n")
  cat("- number of trials:", x$trials, "\n")
  cat("- prob of success :", x$prob)
}

#' @export
summary.binvar <- function(x) {
  trials <- x$trials
  prob <- x$prob
  summary.binvar <- list(trials = x$trials,
                         prob = x$prob,
                         mean = aux_mean(trials, prob),
                         variance = aux_variance(trials, prob),
                         mode = aux_mode(trials, prob),
                         skewness = aux_skewness(trials, prob),
                         kurtosis = aux_kurtosis(trials, prob))
  class(summary.binvar) <- c("summary.binvar","list")
  summary.binvar
}

#' @export
print.summary.binvar <- function(x) {
  cat('"Summary Binomial"\n\n')
  cat("Parameters\n")
  cat("- number of trials:", x$trials, "\n")
  cat("- prob of success :", x$prob, "\n\n")
  cat("Measures\n")
  cat("- mean    :", x$mean, "\n")
  cat("- variance:", x$variance, "\n")
  cat("- mode    :", x$mode, "\n")
  cat("- skewness:", x$skewness, "\n")
  cat("- kurtosis:", x$kurtosis,"\n")
}



#1.8) Functions of measures

#' @title Binomial Mean
#' @description Computes the mean of the binomial distribution
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return mean of binomial distribution
#' @export
#' @examples
#' bin_mean(10,0.3)
bin_mean <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}

#' @title Binomial variance function
#' @description Compute the variance of the binomial distribution
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return the variance of binomial distribution
#' @export
#' @examples
#' bin_variance(10,0.3)

bin_variance <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}

#' @title Binomial Mode function
#' @description: Compute the mode of the binomial distribution
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return the mode of binomial distribution
#' @export
#' @examples
#' bin_mode(10,0.3)
bin_mode <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}

#' @title Binomial Skewness function
#' @description: Compute the skewness of the binomial distribution
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return the skewness of binomial distribution
#' @export
#' @examples
#' bin_skewness(10,0.3)
bin_skewness <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}

#' @title Binomial Kurtosis function
#' @description Compute the kurtosis of the binomial distribution
#' @param trials Number of (fixed) trials in the binomial distribution.
#' @param prob the probability of success on each trial.
#' @return the kurtosis of binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10,0.3)

bin_kurtosis <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}




