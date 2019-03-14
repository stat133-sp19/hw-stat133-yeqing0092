# title: code of shorts data
# description: the R code to complete the data  preparation.
# input(s): stephen-curry.csv, andre-iguodala.csv, kevin-durant.csv, draymond-green.csv, klay-thompson.csv
# output(s):shots-data.csv, shots-data-summary.txt, stephen-curry-summary.txt, andre-iguodala-summary.txt,draymond-green-summary.txt,kevin-durant-summary.txt,klay-thompson-summary.txt


library(dplyr)


data_types = c("team_name"="character", "game_date"="character", "season" = "integer", "period"="integer",
               "minutes_remaining"="integer", "seconds_remaining"="integer", "shot_made_flag"="character",
               "action_type"="factor", "shot_type"="factor", "shot_distance"="integer", "opponent"="character",
               "x"="integer", "y"="integer")

#

curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE,colClasses = data_types)

iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE,colClasses = data_types)

green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE,colClasses = data_types)

durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE,colClasses = data_types)

thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE,colClasses = data_types)

#

curry <- mutate(curry, name = "Stephen Curry")

durant <- mutate(durant, name = "Kevin Durant")

iguodala <- mutate(iguodala, name = "Andre Iguodala")

green <- mutate(green, name = "Graymond Green")

thompson <- mutate(thompson, name = "Klay Thompson")

#
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"

curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"

iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"

iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"

durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"

durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"

green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"

green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"

thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"

thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"


#
curry <- mutate(curry, minute = period*12-minutes_remaining)

durant <- mutate(durant, minute = period*12-minutes_remaining)

iguodala <- mutate(iguodala, minute = period*12-minutes_remaining)

green <- mutate(green, minute = period*12-minutes_remaining)

thompson <- mutate(thompson, minute = period*12-minutes_remaining)


#
sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()

sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()

sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()

sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()



#
shot_data <- rbind(curry,durant,green,iguodala,thompson)


#
write.csv(
  x = shot_data,
  file = "../data/shot-data.csv"
)


#
sink(file = "../output/shots-data-summary.txt")
summary(shot_data)
sink()
