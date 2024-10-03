3+4
3 + 4

# order of operations
(4 + 8) * 3^2

# scientific notation
2/1000000
4e3

# matematical functions
exp(3)
log(100)

# help files
?log

log(100, base = 10)
y <- 1
log(y)
log(base=10, x=100)


x
y
log(x)
rm(x)
rm(y)

# errors and warnings
log("word")
log(-40) # produces NaN
x <- 1
x = 2

# nested functions
sqrt(exp(4))

# comparison functions
x == 5
x != 5
x > 4
x < 3
x>=2

x <- x + 1
x
y <- x + 2
x + y

# object name conventions
numSamples <- 50
num_samples <- 50
numsamples <- 40

rm(numsamples)
rm(numSamples)

# clear environment
rm(list = ls())

# challenge
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg * 2.2
elephant2_lb > elephant1_lb

myelephants <- c(elephant1_lb,elephant2_lb)

which(myelephants == max(myelephants))
