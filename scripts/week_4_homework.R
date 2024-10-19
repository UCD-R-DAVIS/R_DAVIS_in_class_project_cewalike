#Surveys tibble

library("tidyverse")
#survey dataset
surveys <- read_csv("data/portal_data_joined.csv")

#Subset surveys- weight 30-60,print out the first 6 rows.
sub_surveys <- filter(surveys, weight %in% 30:60)
head(sub_surveys, 6)

#Create a new tibble showing the maximum weight for each species + sex combination. 
#Sort the tibble to take a look at the biggest and smallest species + sex combinations. 
biggest_critters <- surveys %>%
  group_by(species, sex) %>%
  filter(weight !="", sex !="") %>%
  summarize(weight = max(weight)) %>%
  arrange(-weight,species,sex)

biggest_critters

#Where are NA weights?