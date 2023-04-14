# load packages 
library(tidyverse)
library(chron)
library(naniar)
library(ggridges)

#Load in the data
alegria <- read_csv("/Users/javipatron/Documents/MEDS/Courses/workshops/functions_workshop/data/raw_data/alegria_mooring_ale_20210617.csv")

carpinteria <- read_csv("/Users/javipatron/Documents/MEDS/Courses/workshops/functions_workshop/data/raw_data/carpinteria_mooring_car_20220330.csv")

mohawk <- read_csv("/Users/javipatron/Documents/MEDS/Courses/workshops/functions_workshop/data/raw_data/mohawk_mooring_mko_20220330.csv")


# Clean data ---
alegria_clean <- alegria |> 
  select(year, month, day, decimal_time, Temp_bot, Temp_mid, Temp_top) |> #keep some columns
  filter(year %in% c(2000:2005)) |> #filter by the years of interest
  mutate(site = rep("Alegria Reef")) |>  # add site column 
  unite(col = date, year, month, day, sep ="-", remove = FALSE ) |> # Create date time column
  mutate(time = times(decimal_time)) |> # Set time format
  unite(col = date_time, date, time, sep = " ", remove = TRUE) |> # Create date and time column
  mutate(date_time = as.POSIXct(date_time, "%Y-%m-%d %H:%M:%S", tz = "GMT"), # coerce data types
         year = as.factor(year),
         month = as.factor(month),
         day = as.numeric(day)) |> 
  # replace 9999s with NAs
  replace_with_na(replace = list(Temp_bot = 9999, Temp_mid = 9999, Temp_top = 9999)) |>
  mutate(month_name = as.factor(month.name[month])) |> # add month name
  select(site, date_time, year, month, day, month_name, Temp_bot, Temp_mid, Temp_top) #reorder cols ---


#plot data

alegria_plot <- alegria_clean |> 
  group_by(month_name) |> 
  ggplot(aes(x = Temp_bot, 
             y = month_name, 
             fill = after_stat(x))) +
  geom_density_ridges_gradient(rel_min_height = 0.01,
                               scale = 2) +
  scale_x_continuous(breaks = c(9, 12, 15, 18, 21)) +
  scale_y_discrete(limits = rev(month.name)) +
  scale_fill_gradientn(colors = c("#2C5374","#778798", "#ADD8E6", "#EF8080", "#8B3A3A"), 
                       name = "Temp. (°C)") +
  labs(x = "Bottom Temperature (°C)",
       title = "Bottom Temperatures at Alegria Reef, Santa Barbara, CA",
       subtitle = "Temperatures (°C) aggregated by month from 2005 - 2020") +
  ggridges::theme_ridges(font_size = 13, grid = TRUE) +
  theme(axis.title.y = element_blank())

alegria_plot

