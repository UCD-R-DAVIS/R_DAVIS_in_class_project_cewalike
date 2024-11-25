# Week 9 homework
library(tidyverse)

# Load surveys data
surveys <- read.csv("data/portal_data_joined.csv")

# Using a for loop, print to the console the longest species name of each taxon
surveys <- surveys %>%
  mutate(speciesLength = nchar(species))

for(i in unique(surveys$taxa)) {
  eachTaxon <- surveys[surveys$taxa == i,]
  speciesIndex <- which(eachTaxon$speciesLength == max(eachTaxon$speciesLength))
  print(unique(eachTaxon$taxa))
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
  map(max) # gives a list

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
  map_dfc(C_to_F)

new_names <- c("temp_F_2m", "temp_F_10m", "temp_F_towertop")
colnames(mloaF) <- new_names
    
