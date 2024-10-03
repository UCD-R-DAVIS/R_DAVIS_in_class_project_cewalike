# working directory and file paths
getwd()
"C:/Fall-2024/R-Projects/R_DAVIS_in_class_project_cewalike"
setwd() #change working directory

d <- read.csv("./data/tail_length.csv")

# Best Practices
## treat raw data as read only
## treat generated output as disposable

dir.create("./lectures")
