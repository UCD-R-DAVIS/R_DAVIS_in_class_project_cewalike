#Week 7 homework

library(tidyverse)
library(ggplot2)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#filter for years 2002 & 2007
year_filter <- gapminder %>% 
  filter((year == 2002 | year == 2007) & continent != "Oceania") %>%
  pivot_wider(id_cols = c(continent, country), names_from = year, values_from = pop)

year_filter

#calculate population difference
year_diff <- year_filter %>%
  mutate(pop_diff = year_filter[4] - year_filter[3]) %>%
  arrange(pop_diff)

year_diff


#plot panel
ggplot(year_diff, aes(x= country, y= pop_diff$'2007', fill = continent)) +
  geom_col() +
  facet_wrap(~ continent, scales = "free", as.table = F, axis.labels = "all_x") +
  labs(x = "Country", y = "Life Change in Population Between 2002 and 2007") +
  theme(axis.title = element_text(size = 12, color = "black")) +
  guides(fill = "none")

?facet_wrap  

