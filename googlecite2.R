visualize_gscholar = function(authorid,lastname) {
setwd('/Users/gail/Documents/Personal/Projects/Side Projects/Google Scholar')

#Load up required libraries. These will in turn automatically install dependencies
library(scholar)
library(ggplot2)
library(XML)
library(tm)
library(wordcloud)

source('./get_all_publications.R',local=TRUE)
source('./get_all_coauthors.R',local=TRUE)
source('./get_all_abstracts.R',local=TRUE)
source('./get_abstract.R',local=TRUE)


#EDIT TO TAKE MORE THAN ONE my_id
#my_id = "8hsKpfMAAAAJ"
#my_id ="KR8wAHEAAAAJ"
#my_id="2-g4_DkAAAAJ"
#my_id="HluYWesAAAAJ" #kaustubh
my_id ="vouGfd8AAAAJ" #terry quinn
all_publications = get_all_publications(my_id)
dim(all_publications)

table(all_publications$year)
#####PLOT PUBLICATIONS PER YEAR OVER TIME (line?)
#####PLOT CITATIONS PER YEAR WITH A DOT FOR EACH ARTICLE (onen same as pubs over time plot? stacked bars?)
#####PLOT H INDEX OVER TIME (other line?)
#####PLOT histogram of journals

summary(all_publications$cites)

all_authors = get_all_coauthors(my_id, me="Quinn")

main_authors = all_authors[all_authors$name %in% names(which(table(all_authors$name)>1)), ]

#should be a plot of coauthor frequency
p = ggplot(main_authors, aes(x=name)) + geom_bar(fill=brewer.pal(3, "Set2")[2]) +
    xlab("co-author") + theme_bw() + theme(axis.text.x = element_text(angle=90, hjust=1))
print(p)




all_abstracts = get_all_abstracts(my_id)

# transform the abstracts into "plan text documents"
all_abstracts = lapply(all_abstracts, PlainTextDocument)
# find term frequencies within each abstract
terms_freq = lapply(all_abstracts, termFreq, 
                    control=list(removePunctuation=TRUE, stopwords=TRUE, removeNumbers=TRUE))
# finally obtain the abstract/term frequency matrix
all_words = unique(unlist(lapply(terms_freq, names)))
matrix_terms_freq = lapply(terms_freq, function(astring) {
    res = rep(0, length(all_words))
    res[match(names(astring), all_words)] = astring
    return(res)
})
matrix_terms_freq = Reduce("rbind", matrix_terms_freq)
colnames(matrix_terms_freq) = all_words
# deduce the term frequencies
words_freq = apply(matrix_terms_freq, 2, sum)
# keep only the most frequent and after a bit of cleaning up (not shown) make the word cloud
important = words_freq[words_freq > 10]
important[[1]]<- 0 #this is a hack to get rid of the word "abstract" which is always highest
wordcloud(names(important), important, random.color=TRUE, random.order=TRUE,
          color=brewer.pal(12, "Set3"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
#####DO A WORD CLOUD FROM TITLES