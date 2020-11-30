### DATA ACQUISITION
# Boris Johnson's speech of March 16th

library(rvest)
library(tidyverse)
library(tm)
library(XML)
library(RCurl)
library(corpus)


gov.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-16-march-2020")
boris16mars <- gov.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()

gov2.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-12-march-2020")
boris12mars <- gov2.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris12mars

gov3.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-18-march-2020")
boris18mars <- gov3.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris18mars

gov4.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-9-march-2020")
boris9mars <- gov4.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris9mars

gov5.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-19-march-2020")
boris19mars <- gov5.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris19mars

gov6.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-20-march-2020")
boris20mars <- gov6.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris20mars

gov7.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-22-march-2020")
boris22mars <- gov7.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris22mars

BORIS<-corpus(c(boris9mars,boris12mars,boris16mars,boris18mars,boris19mars,boris20mars,boris22mars))
BORIS

save(BORIS, boris9mars,boris12mars,boris16mars,boris18mars,boris19mars,boris20mars,boris22mars,file = "data.RData")

# Macron speech of March 12th
library(rvest)
simple <- read_html("https://franceintheus.org/spip.php?article9654")

macron12mars =simple %>% html_nodes("div.texte") %>% html_text()
macron12mars
