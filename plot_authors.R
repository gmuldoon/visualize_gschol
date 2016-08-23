

plot_authors = function(main_authors,outdir) {
    if (length(main_authors) >= 25){
        nauthor <- 25}
    else{ nauthor = length(main_authors)}
#     top_nauthors <- sort(main_authors)
#     df.top_authors <- data.frame(top_authors)
#     outfile<-paste(outdir,lastname,'_coauthor_freq_',authorid,'.png',sep="")
#     png(outfile,width=1000,height=800,res=150,bg="transparent")
#     p <- ggplot(df.top_authors,aes(x=top_authors)) + geom_bar(stat="count") +
#         theme_classic() + theme(axis.text.x = element_text(angle=45, hjust=1,size=5))+
#         scale_y_continuous(labels = function (x) floor(x))+
#         #coord_fixed(0.15)+
#         #geom_text(aes(label=main_authors, vjust=-0.25))+
#         labs(title="",x="Co-author",y="No. papers")
#     print(p)
#     dev.off()    
    
    top_authors <- table(main_authors)[1:nauthor]
    df.main_authors <- as.data.frame.table(top_authors)
    
    outfile<-paste(outdir,lastname,'_coauthor_freq_',authorid,'.png',sep="")
    if (file.exists(outfile)){ file.rename(outfile,paste(outfile,'~',sep=""))}
    png(outfile,width=1000,height=800,res=150,bg="transparent")
    p <- ggplot(data=df.main_authors,aes(x=df.main_authors[,1],y=df.main_authors[,2])) + geom_bar(stat="identity") +
        theme_classic() + theme(axis.text.x = element_text(angle=20, hjust=1,size=7))+
        scale_y_continuous(labels = function (x) floor(x))+
        #coord_fixed(0.15)+
        geom_text(aes(label=df.main_authors[,2]), vjust=-0.25)+
        labs(title="Top Collaborators",x="Coauthor",y="No. collaborations")
    print(p)
    dev.off()
    
    #Make word cloud of co-authors
    #Bar plot of co-authors over time?

}

