plot_publications = function(all_publications,lastname) {
    
    #Plot number of papers published per year and output the file
    outfile<-paste(outdir,lastname,'_papers_peryear_',authorid,'.png',sep="")
    png(outfile,width=800,height=300,res=150,bg="transparent")
    all_publications <- na.omit(all_publications)
    plot.pub <- ggplot(data=all_publications,aes(all_publications$year))+
        geom_histogram(breaks=seq(min(all_publications$year),max(all_publications$year,by=1)),col="white")+#,aes(fill=..count..))+
        theme_classic()+
        #scale_fill_gradient("Count", low = "dark blue", high = "white") #this changes the color scheme of the histogram gradient
        #plot.background = theme_rect(fill = "transparent",colour = NA)
        #geom_density()+ #add a trendline
        labs(title="Publications per year",x="Year of publication",y="No. papers")
    print(plot.pub)
    dev.off()
    #ggsave(outfile,plot=plot.pub)
    
    #Plot the number of citations per year and output the file 
    outfile<-paste(outdir,lastname,'_citations_peryear_',authorid,'.png',sep="")
    png(outfile,width=800,height=300,res=150,bg="transparent")
    plot.cite <- ggplot(all_publications,aes(x=year,y=cites))+
        geom_bar(stat='identity')+
        theme_classic()+
        labs(title="Citations per year",x="Year of citation",y="No. cites")
    print(plot.cite)
    dev.off()
    
    #Plot number of citations per year paper was published
    #
    
    #Plot the number of citations per paper per year and output file
#     outfile<-paste(outdir,lastname,'_citations_perpaper_peryear_',authorid,'.png',sep="")
#     png(outfile,width=800,height=300,res=150,bg="transparent")
#     plot.cite <- ggplot(all_publications,aes(x=year,y=cites))+
#         geom_bar(stat='identity',position="stack",data=all_publications$pid)+
#         theme_classic()+
#         labs(title="Citations per year",x="Year of citation",y="No. cites")
#     print(plot.cite)
#     dev.off()
    

    
    
    
    #Plot # of citations as a function of year the articles were published (bars)
    #Overplot line with publications per year
    #####PLOT CITATIONS PER YEAR WITH A DOT FOR EACH ARTICLE (onen same as pubs over time plot? stacked bars?)

}