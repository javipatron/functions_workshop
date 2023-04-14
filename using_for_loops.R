# load library ----

library(tidyverse)
library(chron)
library(naniar)
library(stringr)

#source function ----
source("utils/clean_ocean_temps.R")

temp_files <- list.files(path = "data/raw_data",
                         pattern = ".csv")

#for loop to read in data ----
for (i in 1:length(temp_files)) {
  
  # get object from file name ----
  file_name <- temp_files[i]
  message("reading in: ", file_name)
  split_name <- stringr::str_split(file_name, "_")
  site_name <- split_name[[1]][1]
  message("Saving as: ", site_name)
  
  #read in csv ----
  assign(x = site_name, value = read_csv(here::here("data", "raw_data", file_name)))
  
}




