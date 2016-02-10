visualize_gschol = function(authorid,lastname) {
#Ex: visualize_gschol("2-g4_DkAAAAJ","Dalziel")
outdir = "./figs/"
if (!dir.exists(outdir)){
    dir.create(outdir)
}
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
source('./plot_publications.R',local=TRUE)
source('./plot_authors.R',local=TRUE)
source('./plot_journals.R',local=TRUE)
source('./plot_abstracts.R',local=TRUE)

#Edit to take more than one my_id
#Check if the authorid has changed since last time this was run this session    
idchange <- FALSE
if (exists("my_id")){
    if (my_id != authorid){
        idchange <- TRUE}}

# If all_publications doesn't exist or there's been an id change, redo the extraction    
if (!exists("all_publications") | idchange){
    my_id <- authorid
    
    # Extract publication info 
    all_publications = get_all_publications(my_id)

    dim(all_publications)
    table(all_publications$year)
    summary(all_publications$cites)
    
    # Make a neat data frame of all authors from previously extracted data
    all_authors = get_all_coauthors(my_id, lastname)
    # Data frame of only those coauthors who appear more than once.
    main_authors = all_authors[all_authors$name %in% names(which(table(all_authors$name)>0)), ]
    
    #Extract all the abstract info for this profile and make it plain text
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
        return(res)})
    
    matrix_terms_freq = Reduce("rbind", matrix_terms_freq)
    colnames(matrix_terms_freq) = all_words
    # deduce the term frequencies
    words_freq = apply(matrix_terms_freq, 2, sum)
    # keep only the most frequent and after a bit of cleaning up (not shown) make the word cloud
    important = words_freq[words_freq > 10]

    important[[1]]<- 0 #this is a hack to get rid of the word "abstract" which is always highest
}

#Plot publications and citations over time
plot_publications(all_publications,lastname,outdir)

#Plot some stuff about the authors
plot_authors(main_authors,outdir)

#Plot stuff to do with journals
plot_journals(all_publications,outdir)

#####PLOT H INDEX OVER TIME
#####PLOT histogram of journals

plot_abstracts(authorid,lastname,important,outdir)
#####DO A WORD CLOUD FROM TITLES

assign("all_publications",all_publications,.GlobalEnv) 
assign("my_id",my_id,.GlobalEnv)
assign("important",important,.GlobalEnv)
}
