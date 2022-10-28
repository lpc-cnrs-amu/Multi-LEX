## **Multi-LEX**: a database of multi-word frequencies for French and English<br>

## Link to N-word-frequency
This repository is the front office (display and filter) of the following back office (data creation)repository https://github.com/lpc-cnrs-amu/N-word-frequency.

### Where can I download the files?
English files are available here: https://zenodo.org/record/7214223 (DOI 10.5281/zenodo.7214223)<br>
French files: https://zenodo.org/record/7214248 (DOI 10.5281/zenodo.7214248)

The size of the files ranges from 10MB to 300MB. 


### What's in it?
**Frequencies**. Actually, frequencies of pairs of words like *grey computer* found in millions of books (sourced from Google Books), but also triplets like *a nice picture* up to 5-word sequences like *the lamp on the desk*. Those are called N-grams (here N goes from 2 to 5).

For each size and each laguage, say French 3-GRAMS, the smaller file contains the most frequent NGRAMS (50,000 forms), the middle file contains 1 million NGRAMS including the 50k most frequent, and the bigger file a few millions (nearly all available NGRAMS.

English and French files are composed of this kind of information:

```
    NGRAM GRAM1 GRAM2 POS1 POS2 OCCURRENCE      FPM      ZFI    POS_PC
1   to be    to    be  prt verb   47783417 3.113632 7.255341 100.00000
2   it is    it    is pron verb   36860809 3.000920 7.104395 100.00000
3  it was    it   was pron verb   35600591 2.985812 7.084163 100.00000
4  do not    do   not verb  adv   27042969 2.866409 6.924258 100.00000
5 did not   did   not verb  adv   25077663 2.833642 6.880376  99.99747
6  he was    he   was pron verb   22821299 2.792695 6.825539 100.00000
```

Namely, the **NGRAM**, **the first GRAM**, **the second GRAM** (up to the fifth GRAM for the 5-GRAM file), **the part-of-speech** (POS, grammatical category) of GRAM1, **the POS of GRAM2**, **the number of occurrences** found in Google Books over a certain period of times, **the Frequency Per Million** (a standard measure in lexicography, and ZFI, a **standardized frequency index** (a bit more exotic). POS_PC stands for the **usage percentage** of the pair of POS (POS1, POS2) associated to the pair of words (GRAM1, GRAM2). 100% mean that all the "to be" pair found in Google Books were classified as (PRT, VERB).

### What's in this repository?
Code to manipulate the files, both with standard R code and a Shiny app.
The app is visible at:
https://analytics.huma-num.fr/popr-ngram/

### Example of R code
```
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
```

### Where  can I find more info?

The files are associated with a scientific article. 
The abstract is:

*Written word frequency is a key variable used in many psycholinguistic studies and is central in explaining visual word recognition. Indeed, methodological advances on single word frequency estimates have helped to uncover novel language-related cognitive processes, fostering new ideas and studies. In an attempt to support and promote research on a related emerging topic, visual multi-word recognition, we extracted from the exhaustive Google Ngram datasets a selection of millions of multi-word sequences and computed their associated frequency estimate. Such sequences are presented with Part-of-Speech information for each individual word. An online behavioral investigation making use of the French 4-gram lexicon in a grammatical decision task was carried out. The results show an item-level frequency effect of word sequences. Moreover, the proposed datasets were found useful during the stimulus selection phase, allowing more precise control of the multi-word characteristics.*

---

Application is live at https://analytics.huma-num.fr/popr-ngram/

### Is it possible the get the frequencies for another language?

Simple answer is yes, with more difficulties for some laguages. It took ages to get French and English forms even if we relied entirely on the Google N-gram database.

I express my gratitude to Google and the people that push forward the N-Gram project.


```
Marjorie ARMANDO, Jonathan GRAINGER, Stephane DUFAU
Laboratoire de psychologie cognitive (UMR7290), CNRS & Aix-Marseille University, France

Published in Behavior, Research, Methods
```
