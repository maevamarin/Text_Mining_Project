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
  "stringr","lexicon","RColorBrewer","tm","printr","ggplot2","quanteda.textmodels","topicmodels","text2vec", "DT","ranger","wordcloud")


purrr::walk(packages, library, character.only = TRUE)


# load the required dictionnary

get_sentiments("nrc")     # load the sentiment library "nrc"
get_sentiments("afinn")
library(lexicon)

lexicon::hash_sentiment_jockers_rinker
lexicon::hash_valence_shifters


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
  warning = FALSE,
  cache =TRUE
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

