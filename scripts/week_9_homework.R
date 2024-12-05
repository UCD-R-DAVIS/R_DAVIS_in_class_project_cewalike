# Week 9 homework
setwd('C:/Fall-2024/R-Projects/R_DAVIS_in_class_project_cewalike/')
library(tidyverse)

# Load surveys data
surveys <- read.csv("data/portal_data_joined.csv")

# Using a for loop, print to the console the longest species name of each taxon
surveys <- surveys %>%
  mutate(speciesLength = nchar(species))

for(i in unique(surveys$taxa)) {
  eachTaxon <- surveys[surveys$taxa == i,] # Filter for the unique taxa only stored in i
  speciesIndex <- which(eachTaxon$speciesLength == max(eachTaxon$speciesLength))
  print(i)
  print(unique(eachTaxon$species[speciesIndex]))
}

# Load mloa data
mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# Use the map function from purrr to print the max of each of the following 
# columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,
# “temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.
mloa %>% 
  select(windDir,windSpeed_m_s,baro_hPa,temp_C_2m,temp_C_10m,
          temp_C_towertop,rel_humid, precip_intens_mm_hr) %>%
  map(max, na.rm = T) # gives a list

# Make a function called C_to_F that converts Celsius to Fahrenheit. 
# Hint: first you need to multiply the Celsius temperature by 1.8, then add 32
C_to_F <- function(tempC){
  f <- (tempC * 1.8) + 32
  return(f)
}

# Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” 
# by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”.
mloaF <- mloa %>%
  select(temp_C_2m, temp_C_10m, temp_C_towertop) %>%
  map_dfc(C_to_F) # %>% rename("temp_F_2m" = "temp_C_2m"...)

new_names <- c("temp_F_2m", "temp_F_10m", "temp_F_towertop")
colnames(mloaF) <- new_names # Could also use rename function

# Challenge: use lapply to make a new column that includes genus and species together
# as a string
surveys %>% mutate(genusspecies = lapply(1:nrow(surveys), function(i){
  paste0(surveys$genus[i], " ", surveys$species[i])
}))

install.packages("stringr")
library("stringr")

str_replace("temp_F_2m", "F", "C")
    
