# Week 2 Homework ----

## Given code ----
set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

### Remove NA ----
hw2_noNA <- hw2[!is.na(hw2)]
hw2_noNA

### Select values ----
prob1 <- hw2_noNA[hw2_noNA >= 14 & hw2_noNA <= 38]
prob1

### Vector math ----
times3 <- prob1 * 3
times3

plus10 <- times3 + 10
plus10

n <- length(plus10)
final <- c(plus10[seq(from = 1,to = n,by = 2)])
final

?seq()

  