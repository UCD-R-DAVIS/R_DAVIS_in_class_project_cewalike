# ggplot2 ----
## Grammar of Graphics plotting package (included in tidyverse package - you can see this when you call library(tidyverse)!)
## easy to use functions to produce pretty plots
## ?ggplot2 will take you to the package helpfile where there is a link to the website: https://ggplot2.tidyverse.org - this is where you'll find the cheatsheet with visuals of what the package can do!

## ggplot basics
## every plot can be made from these three components: data, the coordinate system (ie what gets mapped), and the geoms (how to graphical represent the data)
## Syntax: ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPING>))

## tips and tricks
## think about the type of data and how many data  variables you are working with -- is it continuous, categorical, a combo of both? is it just one variable or three? this will help you settle on what type of geom you want to plot
## order matters! ggplot works by layering each geom on top of the other
## also aesthetics like color & size of text matters! make your plots accessible 


## example ----
library(tidyverse)
## load in data
surveys <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.)) # remove all NA's

## Let's look at two continuous variables: weight & hindfoot length
## Specific geom settings
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(aes(color = genus)) +
  geom_smooth(aes(color = genus))

## Universal geom settings
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_point() +
  geom_smooth()







## Visualize weight categories and the range of hindfoot lengths in each group
## Bonus from hw: 
sum_weight <- summary(surveys$weight)
surveys_wt_cat <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= sum_weight[[2]] ~ "small", 
    weight > sum_weight[[2]] & weight < sum_weight[[5]] ~ "medium",
    weight >= sum_weight[[5]] ~ "large"
  )) 

table(surveys_wt_cat$weight_cat)


## We have one categorical variable and one continuous variable - what type of plot is best?

ggplot(data = surveys_wt_cat, aes(x = weight_cat, y = hindfoot_length)) +
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) +
  geom_point(alpha = 0.1)


## What if I want to switch order of weight_cat? factor!
surveys_wt_cat$weight_cat <- factor(surveys_wt_cat$weight_cat, c("small", "medium", "large"))
ggplot(data = surveys_wt_cat, aes(x = weight_cat, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1) +
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) 

## example 2 ----

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))
head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)

head(yearly_counts)

ggplot(data = yearly_counts) + geom_line(aes(x = year, y = n))

ggplot(data = yearly_counts,mapping = aes(x = year, y= n)) +
  geom_line()

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line()


ggplot(data = yearly_counts,mapping = aes(x = year, y= n, colour = species_id)) +
  geom_line() + geom_point()


ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)


ggplot(data = yearly_counts[yearly_counts$species_id%in%c('BA', 'DM', 'DO', 'DS'),],
       mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() +
  facet_wrap(~ species_id)
scale_y_continuous(name = 'obs', breaks = seq(0, 600, 100))
theme_bw()

install.packages('ggthemes')
library(ggthemes)
install.packages('tigris')
library(tigris)
install.packages('sf')
library(sf)

ca_counties = tigris::counties(state = 'CA', class = 'sf')

ca_counties
ggplot(data=ca_counties) +
  geom_sf(aes(fill = -ALAND)) + theme_map() +
  scale_fill_continuous_tableau()
