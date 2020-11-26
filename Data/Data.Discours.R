### DATA ACQUISITION
# Boris Johnson's speech of March 16th

library(rvest)
library(tidyverse)
gov.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-16-march-2020")
boris16mars <- gov.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris16mars

# Macron speech of March 12th
library(rvest)
simple <- read_html("https://franceintheus.org/spip.php?article9654")

macron12mars =simple %>% html_nodes("div.texte") %>% html_text()
macron12mars
