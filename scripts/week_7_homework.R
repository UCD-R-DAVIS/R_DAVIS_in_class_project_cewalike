#Week 7 homework

library(tidyverse)
library(cowplot)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#filter for years 2002 & 2007
year_filter <- gapminder %>% 
  filter(year == 2002 | year == 2007) %>%
  pivot_wider(id_cols = c(continent, country), names_from = year, values_from = pop)

year_filter

#calculate population difference
year_diff <- year_tibble %>%
  mutate(pop_diff = year_filter[4] - year_filter[3]) 

year_diff


#Africa plot
Africa <- ggplot(data = year_diff[year_diff$continent %in% c('Africa'),], 
       mapping= aes(x= country, y= pop_diff$'2007')) +
  geom_col() +
  labs(x = "Country", y = "Life Change in Population Between 2002 and 2007") +
  theme(axis.title = element_text(size = 12, color = "black", face = "bold")) 

#America plot
Americas <- ggplot(data = year_diff[year_diff$continent %in% c('Americas'),], 
                 mapping= aes(x= country, y= pop_diff$'2007')) +
  geom_col() +
  labs(x = "Country", y = "Life Change in Population Between 2002 and 2007") +
  theme(axis.title = element_text(size = 12, color = "black", face = "bold")) 

#Asia plot
Asia <- ggplot(data = year_diff[year_diff$continent %in% c('Asia'),], 
                   mapping= aes(x= country, y= pop_diff$'2007')) +
  geom_col() +
  labs(x = "Country", y = "Life Change in Population Between 2002 and 2007") +
  theme(axis.title = element_text(size = 12, color = "black", face = "bold"))

#Europe plot
Europe <- ggplot(data = year_diff[year_diff$continent %in% c('Europe'),], 
                   mapping= aes(x= country, y= pop_diff$'2007')) +
  geom_col() +
  labs(x = "Country", y = "Life Change in Population Between 2002 and 2007") +
  theme(axis.title = element_text(size = 12, color = "black", face = "bold")) 
  
panel_plot <- plot_grid(Africa, Americas, Asia, Europe,
                        labels=c("Africa", "Americas", "Asia", "Europe"), 
                        ncol=2, nrow = 2)
panel_plot

