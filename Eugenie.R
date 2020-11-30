knitr::opts_chunk
update.packages()
## 1.1 WITH TIDYTEXT
library(tidyverse)
library(tidytext)
library(tokenizers)
library(wordcloud)
library(tibble)
library(knitr)

# execute code if the date is later than a specified day

```{r}
do_it = Sys.Date() > '2018-02-14'
```
#creste a tibble object containing the dat

boris <- tibble(txt = boris16mars)

boris %>%
  unnest_tokens(word, txt) %>%
  tokens() %>%
  tokens_tolower() %>%
  

# Now we make a tokenization using unnest_tokens:
boris.tb <- unnest_tokens(boris.tb)

# Warning! the word "word" is specific to stop_words: it's its column name: check the name of the column by writing it in the console to verify if it is written with or without s. Here it is without s. Be careful as well with the capital 

# Lowering capitals into normal characters (uniformization)
crude_tok <- anti_join(crude_tok, stop_words, by = "word")

#Computation of the length of the documents
table(crude_tok$Document)
?table

# Computation of the word frequencies (TF) 
crude.fr <- crude_tok %>% 
  group_by(Document) %>%
  count(word, sort =TRUE) %>%
  ungroup()
crude.fr

# Visualization of the frequencies of words by documents, by selecting the 15 most frequent
library(ggplot2)
index <- top_n(crude.fr,15)
crude.fr %>% 
  filter (word %in% index$word) %>% 
  ggplot(aes(x= word, y = n )) +
  geom_col() +
  coord_flip() +
  facet_wrap(~Document, ncol = 2)

# Investigating the 15 most frequent words by documents
index <- crude.fr %>% group_by(Document) %>% top_n(1)
crude.fr %>% filter(word %in% index$word) %>%
  ggplot(aes(word,n)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~Document,ncol = 2)
index$word
?top_n

# Using TF-IDF
crude.tfidf <- bind_tf_idf(tbl= crude.fr, term = word, document= Document, n= n)
crude.tfidf %>% View()
index <- crude.tfidf %>%
  group_by(Document) %>%
  top_n()
crude.tfidf %>%
  filter(word %in% index$word) %>%
  ggplot(aes(word, tf_idf)) +
  geom_col() +
  coord_flip() + facet_wrap(~Document, ncol = 2)

# Create now a cloud with frequencies of words
wordcloud(words = crude.fr$word, freq= crude.fr$n)

crude.fr2 <- aggregate(n~word, FUN = sum, data= crude.fr)
wordcloud(words = crude.fr2$word, freq = crude.fr2$n)

# 1.2 With tm 
library(tm)
crude.cp <- VCorpus(VectorSource(Reuter_crude$Text))
crude.cp
crude.cp <- tm_map(crude.cp, removePunctuation)
crude.cp <- tm_map(crude.cp, removeNumbers)
crude.cp <- tm_map(crude.cp, removeWords, stopwords("english"))
crude.cp <- tm_map(crude.cp, content_transformer(tolower))
crude.cp <- tm_map(crude.cp, stripWhitespace)
crude.cp <- tm_map(crude.cp, removeWords,"reuter")
inspect(crude.cp[[2]])
?tm_map
?VCorpus
crude.dtm <- DocumentTermMatrix(crude.cp)
inspect(crude.dtm)
?DocumentTermMatrix

crude.cp %>% DocumentTermMatrix(control= list(weighting = weightTfIdf)) %>%
  tidy()

## 1.3 With quanteda
library(quanteda)
crude.cp <- corpus(Reuter_crude$Text)
summary(crude.cp)

crude.tk <- tokens(crude.cp, remove_numbers=TRUE, remove_punct = TRUE, remove_separators = TRUE)
crude.tk
crude.tk %>% dfm() %>% dfm_tfidf() %>% textplot_wordcloud()
crude.tk %>% dfm() %>% textstat_frequency() %>% head(20) %>% textplot_wordcloud()

### 2 TF - IDF
# to computa a la mano

### 3 Zip's law
crude.dfm <- crude.tk %>% dfm()
crude.freq <- textstat_frequency(crude.dfm)
head(crude.freq, 20)
plot(frequency~rank, data=crude.freq, pch=20) 
text(frequency~rank, data=crude.freq[1:4,], label=feature, pos=4)
(mod.zipf <- lm(log(frequency)~log(rank), data=crude.freq))

crude.cp <- corpus(Reuter_crude$Text)
crude.dfm <- dfm(crude.cp,
                 stem=FALSE,
                 tolower=TRUE,
                 remove=c("reuter",stopwords("english")),
                 remove_punct=TRUE,
                 remove_number=TRUE,
                 remove_symbols=TRUE)
crude.div <- textstat_lexdiv(crude.dfm, measure = "I")
crude.div %>% 
  ggplot(aes(x=reorder(document, I), y=I))+geom_point()+coord_flip()+
  xlab("Text") + ylab("Yule's index")
