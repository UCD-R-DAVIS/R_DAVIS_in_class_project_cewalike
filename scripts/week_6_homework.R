#Week 6 homework

library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#First calculates mean life expectancy on each continent.
gapminder %>%
  filter(complete.cases(.)) %>% # remove all NA's
  group_by(continent, year) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  #Then create a plot that shows how life expectancy 
  #has changed over time in each continent.
  ggplot(data = ., aes(x = year, y = mean_lifeExp)) +
  geom_point(aes(color = continent)) +
  geom_smooth(aes(color = continent))

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
#What do you think the scale_x_log10() line of code is achieving? 
  #This function changes the scale of the x axis.
#What about the geom_smooth() line of code?
  #The geom_smooth function is fitting a linear regression model to the data.
  #Represented by a dashed, black line. 

#Create a boxplot that shows the life expectancy 
#for Brazil, China, El Salvador, Niger, and the United States, 
ggplot(gapminder[gapminder$country %in% c('Brazil', 'China', 'El Salvador', 'Niger', 'United States'),], 
       aes(x = country, y = lifeExp)) +
  #with the data points in the background using geom_jitter.
  geom_jitter(alpha = 0.1) +
  geom_boxplot(aes(color = country), alpha = 0.5) +
  #Label the X and Y axis with “Country” and “Life Expectancy”
  labs(x = "Country", y = "Life Expectancy") +
  theme(axis.title = element_text(size = 12,
                                  color = "black",
                                  face = "bold")) +
  #title the plot “Life Expectancy of Five Countries”.
  ggtitle("Life Expectancy of Five Countries") +
  theme( plot.title = element_text(hjust = 0.5, size = 15, face = "bold") )

