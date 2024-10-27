# Conditional statements ---- 
## ifelse: run a test, if true do this, if false do this other thing
## case_when: basically multiple ifelse statements
# can be helpful to write "psuedo-code" first which basically is writing out what steps you want to take & then do the actual coding
# great way to classify and reclassify data

## Load library and data ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

## ifelse() ----
# from base R
# ifelse(test, what to do if yes/true, what to do if no/false)
## if yes or no are too short, their elements are recycled
## missing values in test give missing values in the result
## ifelse() strips attributes: this is important when working with Dates and factors
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)
surveys$record_id
unique(surveys$hindfoot_cat)



## case_when() ----
# GREAT helpfile with examples!
# from tidyverse so have to use within mutate()
# useful if you have multiple tests
## each case evaluated sequentially & first match determines corresponding value in the output vector
## if no cases match then values go into the "else" category

# case_when() equivalent of what we wrote in the ifelse function
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", #hindfoot length over the mean I want to be
    #reclassifed as big
    TRUE ~ "small" #"else" part
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()


surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small")) %>% 
      select(hindfoot_length, hindfoot_cat) %>%
      head(10)
  

# but there is one BIG difference - what is it?? (hint: NAs)



# if no "else" category specified, then the output will be NA


# lots of other ways to specify cases in case_when and ifelse
surveys %>%
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1", 
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>%
  group_by(favorites) %>%
  tally()

#Joins & Pivots----
library(tidyverse)
tail <- read.csv('data/tail_length.csv')
surveys <- read.csv('data/portal_data_joined.csv')

dim(tail)
dim(surveys)
head(tail)

## Joins----
surveys_inner <- inner_join(x = surveys, y = tail)

dim(surveys_inner)
head(surveys_inner)

all(surveys$record_id %in% tail$record_id)
all(tail$record_id %in% surveys$record_id)

surveys_left <- left_join(x = surveys, y = tail)
dim(surveys_left)

surveys_right <- right_join(x = surveys, y = tail)
dim(surveys_right)

surveys_full <- full_join(surveys, tail)
dim(surveys_full)

## Pivots----
surveys_mz <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarize(mean_weight = mean(weight))

surveys_mz

surveys_mz %>% 
  pivot_wider(id_cols = 'genus', names_from = 'plot_id', 
              values_from = 'mean_weight')
