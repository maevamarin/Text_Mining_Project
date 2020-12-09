library(rvest)
simple <- read_html("https://franceintheus.org/spip.php?article9654")

r =simple %>% html_nodes("div.texte") %>% html_text()
r
