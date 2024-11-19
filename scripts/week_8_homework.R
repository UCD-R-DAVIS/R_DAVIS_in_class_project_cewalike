# Mauna Loa meteorological data

library(tidyverse)
library(ggplot2)
library(lubridate)
library(dplyr)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
# Timezone: UTC (Coordinated Universal Time)

# Remove observations with missing values in rel_humid (-99), 
# temp_C_2m (-999.9), and windSpeed_m_s (-999.9)
mloa %>%
  filter(rel_humid != -99, temp_C_2m != -999.9, windSpeed_m_s != -999.9)

# Generate a column called “datetime” using the year, month, day, hour24, 
# and min columns
mloa$datetime <- ymd_hm(paste0(mloa$year, "-", mloa$month,
                          "-", mloa$day, ", ", mloa$hour24, ":",
                          mloa$min))
glimpse(mloa)

# Create a column called “datetimeLocal” that converts the datetime column 
# to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz())
?with_tz
mloa$datetimeLocal <- with_tz(mloa$datetime, "HST")
glimpse(mloa)


# Use dplyr to calculate the mean hourly temperature each month 
# using the temp_C_2m column and the datetimeLocal columns. 
# (HINT: Look at the lubridate functions called month() and hour())
?month()
?hour()

mloa %>%
  mutate(months = month(mloa$datetimeLocal, label = T)) %>%
  mutate(hours = hour(mloa$datetimeLocal)) %>%
  group_by(months, hours) %>%
  summarize(meanTemp = mean(temp_C_2m)) %>%
  # Make a ggplot scatterplot of the mean monthly temperature, 
  # with points colored by local hour.
  ggplot(data = ., aes(x = months, y = meanTemp)) +
  geom_point(aes(color = hours)) +
  scale_color_viridis_c(option = "H") +
  xlab("Month (Name)") +
  ylab("Mean temperature (degrees C)") +
  theme_classic() +
  theme(axis.title = element_text(size = 12,
                                  color = "black",
                                  face = "bold"))

  
  



