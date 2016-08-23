source('http://biostat.jhsph.edu/~jleek/code/googleCite.r')

out=googleCite('https://scholar.google.com/citations?user=8hsKpfMAAAAJ&hl=en', pdfname='muldoon_wordcloud.pdf')
out=searchCite("Gail Muldoon",pdfname="muldoon_wordcloud.pdf",plotIt=TRUE)

gcSummary(out)
