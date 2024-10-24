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
surveys %>%
  filter(is.na(weight)) %>%
  select(weight, species) %>%
  group_by(species) %>%
  tally() %>%
  arrange(-n)
#Highly concentrated in the harrisi species

surveys %>%
  filter(is.na(weight)) %>%
  select(weight, genus) %>%
  group_by(genus) %>%
  tally() %>%
  arrange(-n)

#Highly concentrated in the Dipodomys genus

surveys %>%
  filter(is.na(weight)) %>%
  select(weight, taxa) %>%
  group_by(taxa) %>%
  tally() %>%
  arrange(-n)
#Highest concentration overall in Rodent taxa

surveys %>%
  filter(is.na(weight)) %>%
  select(weight, plot_type) %>%
  group_by(plot_type) %>%
  tally() %>%
  arrange(-n)
#Highly concentrated in the control plot_type

#Remove the rows where weight is NA and add a column average weight of each species+sex combination to the full surveys dataframe. 
#Get rid of all the columns except for species, sex, weight, and your new average weight column. 
surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species, sex) %>%
  mutate(., mean_weight = mean(weight)) %>%
  select(species, sex, weight, mean_weight)

surveys_avg_weight
#How would we make a summary table
surveys_mini <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species, sex) %>%
  summarize(mean_weight = mean(weight), max_weight = max(weight))

surveys_mini

#Add a new column called above_average that contains logical values stating 
#whether or not a row’s weight is above average for its species+sex combination
surveys_avg_weight %>%
  mutate(., above_average = weight > mean_weight) %>%
  arrange(above_average)
