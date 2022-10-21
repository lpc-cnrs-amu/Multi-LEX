<b>Multi-LEX</b>: a database of multi-word frequencies for French and English
----
Marjorie ARMANDO, Jonathan GRAINGER, Stephane DUFAU
<i>Laboratoire de psychologie cognitive (UMR7290), CNRS & Aix-Marseille University, France</i>


- Where are the files?
English files are available here: https://zenodo.org/record/7214223 (DOI 10.5281/zenodo.7214223)
French files: https://zenodo.org/record/7214248 (DOI 10.5281/zenodo.7214248)


- What's in it?
Frequencies of pairs of words like "grey computer" found in millions of books (sourced from Google Books), but also triplets like "a nice picture" up to 5-word sequences like "the lamp on the desk". Those are called N-grams (here N goes from 2 to 5).

English and French files are composed of this kind of information:

    NGRAM GRAM1 GRAM2 POS1 POS2 OCCURRENCE      FPM      ZFI    POS_PC<br>
1   to be    to    be  prt verb   47783417 3.113632 7.255341 100.00000<br>
2   it is    it    is pron verb   36860809 3.000920 7.104395 100.00000<br>
3  it was    it   was pron verb   35600591 2.985812 7.084163 100.00000<br>
4  do not    do   not verb  adv   27042969 2.866409 6.924258 100.00000<br>
5 did not   did   not verb  adv   25077663 2.833642 6.880376  99.99747<br>
6  he was    he   was pron verb   22821299 2.792695 6.825539 100.00000<br>

Namely, the NGRAM, the first GRAM, the second GRAM (up to the fifth GRAM for the 5-GRAM file), the part-of-speech (POS, grammatical category) of GRAM1, the POS of GRAM2, the number of occurrences found in Google Books over a certain period of times, the Frequency Per Million (a standard measure in lexicography, and ZFI, a standardized frequency index (a bit more exotic). POS_PC stands for the usage percentage of the pair of POS (POS1, POS2) associated to the pair of words (GRAM1, GRAM2). 100% mean that all the "to be" pair found in Google Books were classified as (PRT, VERB).

- What's in this repository?
Code to manipulate the files, both with standard R code and a Shiny app.
The app is visible at:
https://analytics.huma-num.fr/popr-ngram/


The files are associated with a scientific article. The abstract is:

Written word frequency is a key variable used in many psycholinguistic studies and is central in explaining visual word recognition. Indeed, methodological advances on single word frequency estimates have helped to uncover novel language-related cognitive processes, fostering new ideas and studies. In an attempt to support and promote research on a related emerging topic, visual multi-word recognition, we extracted from the exhaustive Google Ngram datasets a selection of millions of multi-word sequences and computed their associated frequency estimate. Such sequences are presented with Part-of-Speech information for each individual word. An online behavioral investigation making use of the French 4-gram lexicon in a grammatical decision task was carried out. The results show an item-level frequency effect of word sequences. Moreover, the proposed datasets were found useful during the stimulus selection phase, allowing more precise control of the multi-word characteristics.

---

Application is live at https://analytics.huma-num.fr/popr-ngram/

