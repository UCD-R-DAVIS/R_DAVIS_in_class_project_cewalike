## Create Survey Data----

surveys <- read.csv("data/portal_data_joined.csv")

### Selecting Data----
surveys_base <- surveys[c("species_id", "weight", "plot_type")]
surveys_base <- head(surveys_base, n=5000)

### Columns to factors---- 
surveys_base$species_id <- factor(surveys_base$species_id)
surveys_base$plot_type <- factor(surveys_base$plot_type)

surveys_base <- na.omit(surveys_base)
surveys_base

### Challenge Question----
challenge_base <- subset(surveys_base, weight > 150)
