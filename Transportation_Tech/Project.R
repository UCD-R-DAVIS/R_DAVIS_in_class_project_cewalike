# Analyze Ridership and Traffic Count Data from 2016-2019 ---------------------

library(tidyverse)
library(ggplot2)
library(dplyr)
setwd('./Transportation_Tech/Data')

## Load ridership data ----

#traffic16 <- read.csv("Transportation_Tech/Data/AADT_Arlington_2016.csv")
#traffic17 <- read.csv("Transportation_Tech/Data/AADT_Arlington_2017.csv")
#traffic18 <- read.csv("Transportation_Tech/Data/AADT_Arlington_2018.csv")
#traffic19 <- read.csv("Transportation_Tech/Data/AADT_Arlington_2019.csv")

ridership <- read.csv("2019_historical_rail-rideship_May-weekday-avg_OrangeLine.csv")
head(ridership)

# Filter ridership data
# Use stations West Falls Church-VT/UVA, Dunn Loring-Merrifield, 
# Vienna/Fairfax-GMU from 2016-2019
myYears <- ridership %>%
  filter(X <= 64 & X >= 62) %>% 
  select(Station | X2016...:X2019....)
  
# Relabel years
colnames(myYears)[2:5]<- c(2016, 2017, 2018, 2019)

# Transpose table and relabel columns
t_ViennaFairfax <- t(myYears)
colnames(t_ViennaFairfax)<- t_ViennaFairfax[1, 1:3]
t_ViennaFairfax <- t_ViennaFairfax[-c(1),]

#Relabel year column and convert to numeric
dfViennaFairfax <- as.data.frame(t_ViennaFairfax)
OLine <- rownames_to_column(dfViennaFairfax, var = "Year")

OLine$`West Falls Church-VT/UVA` <- as.numeric(gsub(",","",OLine$`West Falls Church-VT/UVA`))
OLine$`Dunn Loring-Merrifield` <- as.numeric(gsub(",","",OLine$`Dunn Loring-Merrifield`))
OLine$`Vienna/Fairfax-GMU ` <- as.numeric(gsub(",","",OLine$`Vienna/Fairfax-GMU `))
OLine$Year <- as.numeric(OLine$Year)

Total <- rowSums(OLine[1:4 , c(2,3,4)], na.rm=TRUE)
OLine$Counts <- Total

## Load traffic data ----

# Get the files names
files = list.files(pattern = "^[AADT]")

# First apply read.csv, then rbind
trafficFiles = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

# Filter traffic counts for just I-66
I66Counts <- trafficFiles %>%
  filter(Route.Number == '66' & Start.Label == "Fairfax County Line" 
         & End.Label == "Westmoreland St") %>%
  select(Data.Date, Route.Label, AADT)
I66Counts$Data.Date <- as.numeric(I66Counts$Data.Date)

# Match col names
colnames(I66Counts)<- c("Year", "Group", "Counts")
OLine <- OLine[,-c(2,3,4)]
OLine$Group <- paste("Orange Line")


plotData <- rbind(OLine, I66Counts)

# Create plot of traffic counts and ridership ---------
## Trend over time for each ----
ggplot(plotData, mapping = aes(color = Group)) +
  geom_point(OLine, mapping = aes(x = Year, y = Counts)) +
  geom_smooth(OLine, mapping = aes(x = Year, y = Counts), color = "coral", method = "loess") +
  geom_point(I66Counts, mapping = aes(x = Year, y = Counts)) +
  geom_smooth(I66Counts, mapping = aes(x = Year, y = Counts), color = "deepskyblue", method = "loess") +
  theme_classic()  +
  scale_colour_manual(values=c("I-66 EB"="deepskyblue", "Orange Line"="coral")) +
  xlab("Year") +
  ylab("Number of Travelers") 

## Stacked bar graph to show share of travelers ----
ggplot(plotData, mapping = aes(x = Year, y = Counts, fill = Group))+
  geom_bar(position = "stack", stat = "identity") +
  geom_text(aes(label = Counts)) +
  theme_classic()  +
  scale_fill_manual(values=c("I-66 EB"="deepskyblue", "Orange Line"="coral")) +
  xlab("Year") +
  ylab("Number of Travelers") 

## Change between years -----
OLineDiff <- OLine %>%
  mutate(Difference = c(0, Counts[2]-Counts[1], Counts[3]-Counts[2], Counts[4]-Counts[3]))
I66CountsDiff <- I66Counts %>%
  mutate(Difference = c(0, Counts[2]-Counts[1], Counts[3]-Counts[2], Counts[4]-Counts[3]))

ggplot(plotData, mapping = aes(color = Group)) +
  geom_point(OLineDiff, mapping = aes(x = Year, y = Difference)) +
  geom_smooth(OLineDiff, mapping = aes(x = Year, y = Difference), color = "coral", method = "loess") +
  geom_point(I66CountsDiff, mapping = aes(x = Year, y = Difference)) +
  geom_smooth(I66CountsDiff, mapping = aes(x = Year, y = Difference), color = "deepskyblue", method = "loess") +
  theme_classic()  +
  scale_colour_manual(values=c("I-66 EB"="deepskyblue", "Orange Line"="coral")) +
  xlab("Year") +
  ylab("Change in Number of Travelers") 
