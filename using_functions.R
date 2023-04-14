# load libraries
library(tidyverse)
library(chron)
library(naniar)
library(stringr)

#source function ---

source("utils/clean_ocean_temps.R")

# import data ----

alegria <- read_csv("/Users/javipatron/Documents/MEDS/Courses/workshops/functions_workshop/data/raw_data/alegria_mooring_ale_20210617.csv")

carpinteria <- read_csv("/Users/javipatron/Documents/MEDS/Courses/workshops/functions_workshop/data/raw_data/carpinteria_mooring_car_20220330.csv")

mohawk <- read_csv("/Users/javipatron/Documents/MEDS/Courses/workshops/functions_workshop/data/raw_data/mohawk_mooring_mko_20220330.csv")

# clean data ----

alegria_clean2 <- clean_ocean_temps(raw_data = alegria, site_name = "alegria")
mohawk_clean <- clean_ocean_temps(mohawk, "mohawk", include_temps = "Temp_top")
carpinteria_clean <- clean_ocean_temps(carpinteria, "carpinteria", include_temps = c("Temp_bot", "Temp_mid"))

