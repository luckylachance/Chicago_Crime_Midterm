library(tidyverse)
library(dplyr)
library(plyr)
library(lubridate) # Time manipulation
library(RSocrata)# Open data Source API Interface with data
library(stringi)# Time manipulation
library(ggmap)


#####################################################################
#  Download and/or read the CSV/Json File from the Chicago data set #
#####################################################################

#token <- "9Lf5R5TDVVKdFg3Pxb1C1lNuO"
#incidents_yr <- read.socrata("https://data.cityofchicago.org/resource/x2n5-8w5q.json", app_token = token)
#nrow(incidents_yr)

crime <- read_csv('data/crime.csv')
crime$DTG = as.Date(crime$`DATE  OF OCCURRENCE`, "%m/%d/%Y")# Creates a Date Column
crime$WEEK = as.character(crime$DTG, format="%Y-%U") # Creates a Week Column
crime$COUNT = 1

###########################################################
# Remove Rows where Geodata or other data is missing (NA) #
###########################################################
crime <- crime[-which(is.na(crime$`LOCATION`)),] 
crime <- crime %>% 
  dplyr::rename(OCCURANCE='DATE  OF OCCURRENCE',PRIMARY = 'PRIMARY DESCRIPTION',SECONDARY = 'SECONDARY DESCRIPTION',LOCATION_DESCRIPTION = 'LOCATION DESCRIPTION',X = 'X COORDINATE',Y='Y COORDINATE',LAT = 'LATITUDE',LON = 'LONGITUDE')
colSums(is.na(crime))

##########################
#  Build Filter Lists    #
##########################

weeks <- crime %>% 
  pull(WEEK) %>%
  unique()

blocks <- crime %>% 
  pull(BLOCK) %>% 
  unique()

primary <- crime %>% 
  pull(PRIMARY) %>% 
  unique()

secondary <- crime %>% 
  pull(SECONDARY) %>% 
  unique()

beat <- crime %>% 
  pull(BEAT) %>% 
  unique()

########################
# First Data Analysis  #
########################
crime_wk <- crime %>%
  group_by(WEEK,PRIMARY,SECONDARY,BEAT,BLOCK) %>% 
  dplyr::summarize(INCIDENTS=sum(COUNT)) 

############################
#  Column Names DataFrame  #
############################
cols <- colnames(crime_wk)

