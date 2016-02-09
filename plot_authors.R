plot_authors = function(main_authors) {

    main_authors_df <- data.frame(main_authors)
    outfile<-paste(outdir,lastname,'_maincoauthor_freq_',authorid,'.png',sep="")
    png(outfile,width=800,height=500,res=150,bg="transparent")
    p <- ggplot(main_authors_df,aes(x=main_authors)) + geom_bar(data=main_authors_df,stat="count") +
        theme_classic() + theme(axis.text.x = element_text(angle=45, hjust=1))+
        scale_y_continuous(labels = function (x) floor(x))+
        #coord_fixed(0.15)+
        geom_text(aes(label=dat[,2]), vjust=-0.25)+
        labs(title="Co-authors",x="Coauthor",y="No. papers")
    print(p)
    dev.off()
    
    #Make word cloud of co-authors
    #Bar plot of co-authors over time?

}
