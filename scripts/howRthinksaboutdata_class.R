# How R thinks about data ----

## Vectors ----
weight_g <- c(50,60,65,82)


animals <- c("mouse", "rat", "dog")


### Inspection ----
length(weight_g)
str(weight_g)

### Change vectors ----
weight_g <- c(weight_g, 90)
weight_g

# Challenge ----
num_char <- c(1, 2, 3, "a") #chooses lowest common denominator which is string
num_logical <- c(1, 2, 3, TRUE) #true is in its number form 1
char_logical <- c("a", "b", "c", TRUE) #everything is a character
tricky <- c(1, 2, 3, "4") #everything is a character

## Subsetting ----
animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals[c(2,3)]

### Conditional subsetting ----
weight_g <- c(21, 34, 39, 54, 55)
weight_g > 50
weight_g[weight_g > 50]

## Symbols ----
#%in% = within
animals %in% c("rat", "cat", "dog", "duck", "goat") #comparing between "buckets"
animals == c("rat", "cat", "dog", "duck", "goat") #pairwise comparison
