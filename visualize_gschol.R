visualize_gschol = function(authorid,lastname) {
setwd('/Users/gail/Documents/Personal/Projects/Side Projects/Google Scholar')

#Load up required libraries. These will in turn automatically install dependencies
library(scholar)
library(ggplot2)
library(XML)
library(tm)
library(wordcloud)
#library(extrafont)
#font_import()
#loadfonts()

source('./get_all_publications.R',local=TRUE)
source('./get_all_coauthors.R',local=TRUE)
source('./get_all_abstracts.R',local=TRUE)
source('./get_abstract.R',local=TRUE)
source('./plot_publications.R',local=TRUE)

### Only do the analysis if the authorid has changed.
#EDIT TO TAKE MORE THAN ONE my_id
if (my_id != authorid){
    #my_id = "8hsKpfMAAAAJ" gail muldoon
    #my_id ="KR8wAHEAAAAJ" #lucas beem
    #my_id="2-g4_DkAAAAJ" #ian dalziel
    #my_id="HluYWesAAAAJ" #kaustubh thirumalai
    #my_id ="vouGfd8AAAAJ" #terry quinn
    my_id <- authorid
    
    # Extract publication info 
    all_publications = get_all_publications(my_id)
    #str(all_publications)
    dim(all_publications)
    table(all_publications$year)
    summary(all_publications$cites)
    
    #Plot publications and citations over time
    plot_publications(all_publications,lastname)
    
    # Make a neat data frame of all authors from previously extracted data
    all_authors = get_all_coauthors(my_id, lastname)
    # Data frame of only those coauthors who appear more than once.
    main_authors = all_authors[all_authors$name %in% names(which(table(all_authors$name)>1)), ]
    
    #Plot some stuff about the authors
    #plot_authors(main_authors)

#####PLOT H INDEX OVER TIME (other line?)
#####PLOT histogram of journals


    all_abstracts = get_all_abstracts(my_id)
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
}

### Create a wordcloud with the top words from the author's paper abstracts. 
outfile<-paste('scholar_abstract_wordcloud_',lastname,'_',authorid,'.png',sep="")
png(outfile,bg="transparent",res=300,height=4,width=4,units='in')
wordcloud(names(important), important, random.color=FALSE, random.order=TRUE,
          color=brewer.pal(12, "Reds"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
#not entirely sure why i have to do this twice, but i do.
wordcloud(names(important), important, random.color=FALSE, random.order=TRUE,
          color=brewer.pal(12, "Reds"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
dev.off
#####DO A WORD CLOUD FROM TITLES
}
