#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
outdir = "./figs/"
if (!dir.exists(outdir)){
    dir.create(outdir)
}

library(shiny)
library(scholar)
library(ggplot2)
library(XML)
library(tm)
library(wordcloud)

source('get_all_publications.R',local=TRUE)
source('get_all_coauthors.R',local=TRUE)
source('get_all_abstracts.R',local=TRUE)
source('get_abstract.R',local=TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #execute when the go button is pressed
    observeEvent(input$go,{
    ## If all_publications doesn't exist or there's been an id change, redo the extraction    
    #if (!exists("all_publications") | idchange){
    my_id <- input$authorid
    
    # Extract publication info 
    all_publications = get_all_publications(my_id)
    
    #dim(all_publications)
    table(all_publications$year)
    #summary(all_publications$cites)
    
    # Make a neat data frame of all authors from previously extracted data
    all_authors = get_all_coauthors(my_id, input$lastname)
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
    # keep only the most frequent (appear more than 10 times)
    important = words_freq[words_freq > 1]
    ####************DO***********#######
    important[order(-important)][[1]]<- 0 #this is a hack to get rid of the word "abstract" which is always highest should be an if statement to make sure getting rid of "abstract" only
    #}
    
    #Plot publications and citations over time
    #plot_publications(all_publications,input$lastname,outdir)
    
#    output$plot_pub <- renderImage({
#        list(src=plot_publications$plot.pub,alt="Publications",height=600)
#    })
    
#    output$plot_cite <- renderImage({
#        list(src=plot_publications$plot.cite,alt="Citations",height=600)
#    })
    
    #Plot some stuff about the authors
    #plot_authors(main_authors,outdir)

#    output$plot_auth <- renderImage({
#        list(src=plot_authors$plot.authors,alt="Authors",height=600)
#    })
    
    #Plot stuff to do with journals
    #plot_journals(all_publications,outdir)
    
#    output$plot_journ <- renderImage({
#        list(src=plot_journals$plot.journ,alt="Journals",height=600)
#    })min.freq=input$minfreq, max.words=input$maxwords
    
    #Make a word cloud from abstracts
    #plot_abstracts(my_id,input$lastname,important,outdir)
    
    output$wc <- renderImage({
        outfile<-paste(outdir,lastname,'_abstract_wordcloud_',authorid,'.png',sep="")
        if (file.exists(outfile)){ file.rename(outfile,paste(outfile,'~',sep=""))}
        png(outfile,bg="transparent",res=300,height=6,width=6,units='in')
        wc<-wordcloud(names(important), important, random.color=FALSE, random.order=TRUE,
                      color=brewer.pal(9, "Reds"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
        #not entirely sure why i have to do this twice, but i do.
        wc<-wordcloud(names(important), important, random.color=FALSE, random.order=TRUE,
                      color=brewer.pal(9, "Reds"), min.freq=input$minfreq, max.words=input$maxwords, scale=c(3, 0.3))
        #print(wc)
        dev.off()
         list(src=outfile,alt="Abstract Wordcloud",height=600)
    })
    
    # plotCloud <- reactive ({
    #     #fname="wordcloud.png"
    #     par(mar=c(2,1,1,0.1))
    #     outfile<-paste(outdir,lastname,'_abstract_wordcloud_',authorid,'.png',sep="")
    #     if (file.exists(outfile)){ file.rename(outfile,paste(outfile,'~',sep=""))}
    #     png(outfile,bg="transparent",res=300,height=6,width=6,units='in')
    #     plotCloud <- wordcloud(names(important),
    #                            scale = c(5, 0.5),
    #                            min.freq=input$minfreq,
    #                            max.words=input$maxwords,
    #                            use.r.layout=FALSE,
    #                            colors=brewer.pal(5, "GnBu"))
    #     dev.off()
    #     
    #     filename <- paste(file_path_sans_ext(inFile$name),'-wordcloud.png',sep="")
    # })
    # #Show wordcloud
    # output$wordcloud <- renderImage({
    #     list(src=plotCloud(), alt="Plotting cloud...", height=600)
    # },
    # deleteFile = FALSE)
    
    #Save time when tinkering on the same profile by saving things globally
    #assign("all_publications",all_publications,.GlobalEnv) 
    #assign("my_id",my_id,.GlobalEnv)
    #assign("important",important,.GlobalEnv)
    
    'Go check your figs folder!'
  })
})
