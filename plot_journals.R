
plot_journals = function(all_publications,outdir) {
    if (length(all_publications$journal) >= 25){
        npubs <- 25}#plot the N publications with the highest citation count
    else{ npubs = length(all_publications$journal)}
    all_publications <- na.omit(all_publications)
    
    #Plot the papers per journal and output the file 
    outfile<-paste(outdir,lastname,'_cites_perjournal_',authorid,'.png',sep="")
    if (file.exists(outfile)){ file.rename(outfile,paste(outfile,'~',sep=""))}
    png(outfile,width=1000,height=600,res=150,bg="transparent")
    dat <- cbind(reorder(all_publications$journal,-all_publications$cites)[1:npubs],sort(all_publications$cite,decreasing=TRUE)[1:npubs])
    plot.cite <- ggplot(data.frame(dat),aes(x=reorder(all_publications$journal,-all_publications$cites)[1:npubs],y=dat[,2],fill=dat[,2]))+
        geom_bar(stat='identity')+
        theme_classic()+
        theme(axis.text.x = element_text(angle=35, hjust=1,size=6),axis.text.y = element_text(size=6),legend.position="none")+
        labs(title="Top Journals for citations",x="",y="No. cites")
    print(plot.cite)
    dev.off()
    

    #Bar plot of journals over time

}