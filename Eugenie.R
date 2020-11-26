### DATA ACQUISITION
# Boris Johnson's speech of March 16th

library(rvest)
library(tidyverse)
gov.html <- read_html("https://www.gov.uk/government/speeches/pm-statement-on-coronavirus-16-march-2020")
boris16mars <- gov.html %>% html_nodes(xpath="//*[@id='content']/div[3]/div[1]/div[1]/div[2]/div") %>% html_text()
boris16mars
