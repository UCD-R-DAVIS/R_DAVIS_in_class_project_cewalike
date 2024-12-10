#Download final data -----
Data <- read.csv('https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv')

library(ggplot2)
library(RColorBrewer)
library(tidyverse)
library(lubridate)

#Clean data -----

#Filter data for only running activities
runData <- Data %>% 
  filter(sport == 'running') 

#Filter out laps with a pace > 10 minutes_per_mile pace, pace < 5 minute_per_mile pace 
#And abnormally short records where the total elapsed time is one minute or less.  
runData <- runData %>%
  filter(minutes_per_mile <= 10 & minutes_per_mile >= 5) %>%
  filter(total_elapsed_time_s > 60) %>%
#Create three time periods:
  #1. pre-2024 running, 
  #2. January to June of this year
  #3. activities from July to the present
  mutate(time_period = case_when(
    year == 2023 ~ "2023",
    year == 2024 & month < 7 ~ "Jan - Jun 2024",
    year == 2024 & month >= 7 ~ "July 2024 - Present")) %>%
  drop_na()


#Create a scatterplot ----
#Make a scatter plot that graphs SPM over speed by lap.
ggplot(runData, aes(x = minutes_per_mile, y = steps_per_minute)) +
  scale_color_brewer(palette = "Set2") +
  geom_point(aes(color = time_period)) +
#Make 5 aesthetic changes to the plot to improve the visual
  xlab("Speed (minutes per mile)") + 
  ylab("Cadence (steps per mile)") +
  theme_classic() +
  geom_jitter(alpha = 0.01) +
#Add linear trendlines to the plot to show the relationship between speed and SPM
  geom_smooth(aes(color = time_period), method = "lm")

display.brewer.all(colorblindFriendly = TRUE)

##Does this relationship maintain or break down as Tyler gets tired? ----
#Focus just on post-intervention runs (after July 1, 2024)
runDataPostJune <- runData %>%
  filter(time_period == "July 2024 - Present")

#Make a plot (of your choosing) that shows SPM vs. speed by lap
ggplot(runDataPostJune, aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point()

# Determine laps each day. Select only laps 1-3
runDataPostJune$date <- as.Date(runDataPostJune$timestamp)
first3 <- runDataPostJune %>% 
  group_by(date) %>% 
  slice(1:3) 
#Assign lap numbers
##Struggled to determine how to do this

#Make a plot that shows SPM, speed, and lap number
ggplot(first3, aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(aes(color = date))

