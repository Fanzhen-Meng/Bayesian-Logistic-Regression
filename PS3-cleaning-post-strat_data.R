#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from Voter Study Group
# Author: Fanzhen Meng
# Data: 22 October 2020
# Contact: fanzhen.meng@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data


#### Workspace setup ####
library(broom) 
library(here)
library(skimr) 
library(foreign)
# Read in the raw data.
setwd("~/Desktop/PS3")
usa_raw_data <- read.dta("usa_00002.dta")


# Add the labels
usa_raw_data <- labelled::to_factor(usa_raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
usa_data <- 
  usa_raw_data %>% 
  select(
         sex, 
         age,
         empstat
         )


# change column name "sex" to "gender"
names(usa_data)[names(usa_data) == "sex"] <- "gender"

# removing NAs
usa_data[usa_data=="n/a"] <- NA
usa_data<- usa_data[!is.na(usa_data$empstat),]
usa_data<- usa_data[!is.na(usa_data$gender),]
usa_data<- usa_data[!is.na(usa_data$age),]

usa_data[which(usa_data[,2]>17),]

#sample 10000 observation
set.seed(5849)
usa_sample <- usa_data[sample(1:nrow(usa_data) , 10000),]



# Saving the census data as a csv file in my
# working directory


write_csv(usa_sample, "/Users/angelameng/Desktop/PS3/usa_sample.csv")



         