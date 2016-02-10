plot_journals = function(all_publications,outdir) {
    
    npubs<-25 #plot the N publications with the highest citation count
    all_publications <- na.omit(all_publications)
    
    #Plot the papers per journal and output the file 
    outfile<-paste(outdir,lastname,'_cites_perjournal_',authorid,'.png',sep="")
    png(outfile,width=800,height=800,res=150,bg="transparent")
    dat <- cbind(reorder(all_publications$journal,-all_publications$cites)[1:npubs],sort(all_publications$cite,decreasing=TRUE)[1:npubs])
    plot.cite <- ggplot(data.frame(dat),aes(x=reorder(all_publications$journal,-all_publications$cites)[1:npubs],y=dat[,2],fill=dat[,2]))+
        geom_bar(stat='identity')+
        theme_classic()+
        theme(axis.text.x = element_text(angle=20, hjust=1,size=5),axis.text.y = element_text(size=5),legend.position="none")+
        labs(title="Citations per journal",x="",y="No. cites")
    print(plot.cite)
    dev.off()
    

    #Bar plot of journals over time
}