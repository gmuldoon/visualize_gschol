source('http://biostat.jhsph.edu/~jleek/code/googleCite.r')
setwd('/Users/gail/Documents/Personal/Projects/Side Projects/Google Scholar')
library(devtools)
source_gist(6424430)
#install.packages('wordcloud')
#install.packages('tm')
#install.packages('sendmailR')
#install.packages('RColorBrewer')

source('./googleCite.R',local=TRUE)
out=googleCite('https://scholar.google.com/citations?user=8hsKpfMAAAAJ&hl=en', pdfname='muldoon_wordcloud.pdf')
out=searchCite("Gail Muldoon",pdfname="muldoon_wordcloud.pdf",plotIt=TRUE)

gcSummary(out)
