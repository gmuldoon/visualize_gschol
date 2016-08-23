library(rvest)
library(dplyr)

pg <- html("https://scholar.google.com/citations?user=8hsKpfMAAAAJ&hl=en")

data.frame(year=pg %>% html_nodes("td.gsc_a_y") %>% html_text(),
           cited_by=pg %>% html_nodes("td.gsc_a_c") %>% html_text(),
           title=pg %>% html_nodes("td.gsc_a_t") %>% html_text())