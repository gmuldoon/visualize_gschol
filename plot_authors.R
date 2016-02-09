plot_authors = function(all_authors, main_authors) {

    main_authors <- data.frame(main_authors)
    outfile<-paste('scholar_maincoauthor_freq_',lastname,'_',authorid,'.png',sep="")
    png(outfile,width=800,height=300,res=150,bg="transparent")
    p <- ggplot(main_authors,aes(x=main_authors)) + geom_bar(data=main_authors,stat="count") +
        theme_classic() + theme(axis.text.x = element_text(angle=45, hjust=1))+
        scale_y_continuous(labels = function (x) floor(x))+
        coord_fixed(0.15)+
        labs(title="Co-authors",x="Coauthor",y="No. papers")
    print(p)
    dev.off()
    
    #Make word cloud of co-authors
    #Bar plot of co-authors over time?

}

#####PLOT histogram of journals

#Histogram of journals
#Bar plot of journals over time