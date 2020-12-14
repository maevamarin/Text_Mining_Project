#############################################
## The following loads the needed packages ##
#############################################

# load the required packages
packages <- c(
  "here", "readr",# for the project's organization
  "tidyverse", "lubridate", # for wrangling
  "modelr", "broom",
  "dplyr",# for modeling
  "ggrepel", "gghighlight", "patchwork", "maps", # for plotting
  "knitr", "kableExtra", "bookdown", "rmarkdown", # for the report
  "randomForest","janitor","caret","pdftools","rvest","wordcloud2","tidytext","tokenizers","quanteda","sentimentr",
  "stringr","lexicon","RColorBrewer","tm","printr","ggplot2","quanteda.textmodels","topicmodels","text2vec", "DT")


purrr::walk(packages, library, character.only = TRUE)


# load the required dictionnary

get_sentiments("nrc")     # load the sentiment library "nrc"
get_sentiments("afinn")
library(lexicon)

lexicon::hash_sentiment_jockers_rinker
lexicon::hash_valence_shifters


boris.sentences.text1 <- data.frame(unlist(boris.text[1])) # create a data frame for each lots of sequnces
boris.sentences.text2 <- data.frame(unlist(boris.text[2]))
boris.sentences.text3 <- data.frame(unlist(boris.text[3]))
boris.sentences.text4 <- data.frame(unlist(boris.text[4]))
boris.sentences.text5 <- data.frame(unlist(boris.text[5]))
boris.sentences.text6 <- data.frame(unlist(boris.text[6]))
boris.sentences.text7 <- data.frame(unlist(boris.text[7]))

b.stc.txt1 <- boris.sentences.text1 %>% filter(unlist.boris.text.1..!=".") # cleaning the sentences
b.stc.txt2 <- boris.sentences.text2 %>% filter(unlist.boris.text.2..!=".") 
b.stc.txt3 <- boris.sentences.text3 %>% filter(unlist.boris.text.3..!=".") 
b.stc.txt4 <- boris.sentences.text4 %>% filter(unlist.boris.text.4..!=".") 
b.stc.txt5 <- boris.sentences.text5 %>% filter(unlist.boris.text.5..!=".") 
b.stc.txt6 <- boris.sentences.text6 %>% filter(unlist.boris.text.6..!=".") 
b.stc.txt7 <- boris.sentences.text7 %>% filter(unlist.boris.text.7..!=".") 
length(b.stc.txt1$unlist.boris.text.1..)

identical(b.stc.txt1, b.stc.txt2)

xB1<-rep("Boris Johnson - Text 1",21) 
xB2<-rep("Boris Johnson - Text 2",49)
xB3<-rep("Boris Johnson - Text 3",42)
xB4<-rep("Boris Johnson - Text 4",51)
xB5<-rep("Boris Johnson - Text 5",45)
xB6<-rep("Boris Johnson - Text 6",42)
xB7<-rep("Boris Johnson - Text 7",33)

b.stc.txt1cbind<-cbind(xB1,b.stc.txt1)
b.stc.txt2cbind<-cbind(xB2,b.stc.txt2)
b.stc.txt3cbind<-cbind(xB3,b.stc.txt3)
b.stc.txt4cbind<-cbind(xB4,b.stc.txt4)
b.stc.txt5cbind<-cbind(xB5,b.stc.txt5)
b.stc.txt6cbind<-cbind(xB6,b.stb.stc.txt6)
b.stc.txt7cbind<-cbind(xB7,b.stc.txt7)
library(dplyr)


# Data frame creation for the sentences set of the speeches of both the Politicians:

a<-rename(b.stc.txt1cbind,sentence_doc = unlist.boris.text.1..) # renaming the first column 
b<-rename(b.stc.txt2cbind,sentence_doc = unlist.boris.text.2..)
c<-rename(b.stc.txt3cbind,sentence_doc = unlist.boris.text.3..)
d<-rename(b.stc.txt4cbind,sentence_doc = unlist.boris.text.4..)
e<-rename(b.stc.txt5cbind,sentence_doc = unlist.boris.text.5..)
f<-rename(b.stc.txt6cbind,sentence_doc = unlist.boris.text.6..)
g<-rename(b.stc.txt7cbind,sentence_doc = unlist.boris.text.7..)

aa<-rename(a,Document =xB1) # renaming the second column
bb<-rename(b,Document =xB2)
cc<-rename(c,Document =xB3)
dd<-rename(d,Document =xB4) 
ee<-rename(e,Document =xB5)
ff<-rename(f,Document =xB6)
gg<-rename(g,Document =xB7)


borisfinal <-rbind(aa,bb,cc,dd,ee,ff,gg) # binding all together


## Macron
macron.sentences.text1 <- data.frame(unlist(macron.text[1])) # create a data frame for each lots of sequnces
macron.sentences.text2 <- data.frame(unlist(macron.text[2]))
macron.sentences.text3 <- data.frame(unlist(macron.text[3]))

m<-length(macron.sentences.text2$unlist.macron.text.2..)
o<-length(macron.sentences.text3$unlist.macron.text.3..)

xM1<-rep("Emmanuel Macron - Text 1",185)                    # create the vector of document names
xM2<-rep("Emmanuel Macron - Text 2",m)
xM3<-rep("Emmanuel Macron - Text 3",o)

m.stc.txt1cbind<-cbind( xM1, macron.sentences.text1)        # binding vector of document names with the tables of sentences
m.stc.txt2cbind<-cbind( xM2, macron.sentences.text2)
m.stc.txt3cbind<-cbind( xM3, macron.sentences.text3)

h<-rename(m.stc.txt1cbind,sentence_doc = unlist.macron.text.1..) # renaming the first column 
i<-rename(m.stc.txt2cbind,sentence_doc = unlist.macron.text.2..)
j<-rename(m.stc.txt3cbind,sentence_doc = unlist.macron.text.3..)

hh<-rename(h,Document =xM1) # renaming the second column
ii<-rename(i,Document =xM2)
jj<-rename(j,Document =xM3)

macronfinal <-rbind(hh,ii,jj) # binding all together

totalcorpus <- rbind(borisfinal,macronfinal)




# automatically create a bib database for R packages
write_bib(.packages(), here::here("packages.bib"))

######################################################
## The following sets a few option for nice reports ##
######################################################

# general options
options(
  digits = 3,
  str = strOptions(strict.width = "cut"),
  width = 69,
  tibble.width = 69,
  cli.unicode = FALSE
)

# ggplot options
theme_set(theme_light())

# knitr options
opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
  dpi = 300,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618,
  fig.show = "hold",
  message = FALSE,
  echo = TRUE,
  warning = FALSE
)

######################################################
## The following sets a few option for nice reports ##
######################################################

pval_star <- function (p, cutoffs = c(0.05, 0.01, 0.001)) {
  stopifnot(length(cutoffs) == 3)
  if (length(p) > 1) {
    sapply(p, pval_star, cutoffs = cutoffs)
  }
  else {
    ifelse(p > cutoffs[1], "", ifelse(p > cutoffs[2], 
                                      " *", 
                                      ifelse(p > cutoffs[3], 
                                             " **", 
                                             " ***")))
  }
}
