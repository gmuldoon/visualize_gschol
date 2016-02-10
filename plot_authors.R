plot_authors = function(main_authors,outdir) {

    nauthor <- 25
    top_nauthors <- sort(main_authors)
    df.top_authors <- data.frame(top_authors)
    outfile<-paste(outdir,lastname,'_coauthor_freq_',authorid,'.png',sep="")
    png(outfile,width=1000,height=800,res=150,bg="transparent")
    p <- ggplot(df.top_authors,aes(x=top_authors)) + geom_bar(stat="count") +
        theme_classic() + theme(axis.text.x = element_text(angle=45, hjust=1,size=5))+
        scale_y_continuous(labels = function (x) floor(x))+
        #coord_fixed(0.15)+
        #geom_text(aes(label=main_authors, vjust=-0.25))+
        labs(title="",x="Co-author",y="No. papers")
    print(p)
    dev.off()    
    
    top_authors <- sort(main_authors)
    top_uauthors<-sort(unique(main_authors))
    df.main_authors <- data.frame(top_authors)
    
    outfile<-paste(outdir,lastname,'_coauthor_freq_',authorid,'.png',sep="")
    png(outfile,width=1000,height=800,res=150,bg="transparent")
    p <- ggplot(df.main_authors,aes(x=top_authors)) + geom_bar(stat="count") +
        theme_classic() + theme(axis.text.x = element_text(angle=90, hjust=1,size=2))+
        scale_y_continuous(labels = function (x) floor(x))+
        #coord_fixed(0.15)+
        #geom_text(aes(label=dat[,2]), vjust=-0.25)+
        labs(title="",x="Coauthor",y="No. collaborations")
    print(p)
    dev.off()
    
    #Make word cloud of co-authors
    #Bar plot of co-authors over time?

}
