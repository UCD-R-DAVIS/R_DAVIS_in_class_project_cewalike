#Surveys tibble

library("tidyverse")
#survey dataset
surveys <- read_csv("data/portal_data_joined.csv")

#Make dataframe called surveys_wide: column for genus, column for every plot type
surveys_wide <- surveys %>%
  group_by(genus, plot_type) %>%
#Each of these columns containing the mean hindfoot length of animals in that plot type and genus.
  filter(!is.na(hindfoot_length)) %>%
  summarize(mean_hindfoot = mean(hindfoot_length)) %>%
#So every row has a genus and then a mean hindfoot length value for every plot type. 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>%
  arrange(Control)
#Sort by values in the Control plot type column. 
surveys_wide

#Calculate a new weight category variable called weight_cat.
sw <-quantile(surveys$weight, probs = c(0,0.25,0.5,0.75,1), na.rm = TRUE)
sw

surveys %>%
  #Define the rodent weight into three categories:
  #“small” is less than or equal to the 1st quartile of weight distribution, 
  #“medium” is between (but not inclusive) the 1st and 3rd quartile, 
  #“large” is any weight greater than or equal to the 3rd quartile.
  filter(weight !="") %>%
  mutate(weight_cat = case_when(
   weight >= sw[4] ~ "large",
   weight > sw[2] ~ "medium",
   weight <= sw[2] ~ "small")) %>%
  select(weight, weight_cat)
  
#(Hint: the summary() function on a column summarizes the distribution). 
#Compare what happens to the weight values of NA, depending on how you specify your arguments.