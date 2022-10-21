# a few examples on how to search the NGRAM database

# library
library(tidyverse) # a package of libraries, useful for stringr

#----------
# read a file
filename <- "ENG2_50k.csv.gz"
data <- read.delim(filename)

#----------
# search for "as" in GRAM1
gram_tmp <- "as"
var_tmp <- "GRAM1"
ind_in1 <-  str_which(data[,var_tmp], gram_tmp, negate = FALSE) # index
data_selected1 <- data[ind_in1,] # results
head(data_selected1)

#----------
# search far "verb" and "adv" in POS1 and POS2
ind_in2 <-  intersect(
  str_which(data$POS1, "verb", negate = FALSE),
  str_which(data$POS2, "adv", negate = FALSE)
  )# index
data_selected2 <- data[ind_in2,] # results
head(data_selected2)

#----------
# filter by ZFI
# plot an histogram
hist(data$ZFI, 1000)
# select forms on ZFI, from 4 to 5
ind_in3 <- data$ZFI < 5 & data$ZFI > 4 # index
data_selected3 <- data[ind_in3,] # results
hist(data_selected3$ZFI, 100) # plot histogram


