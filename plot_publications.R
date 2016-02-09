plot_publications = function(all_publications,lastname) {
    
    #Plot number of papers published per year and output the file
    outfile<-paste('scholar_papers_peryear_',lastname,'_',authorid,'.png',sep="")
    png(outfile,width=800,height=300,res=150,bg="transparent")
    plot.pub <- ggplot(data=all_publications,aes(all_publications$year))+
        geom_histogram(breaks=seq(min(all_publications$year),max(all_publications$year,by=1)),col="white")+#,aes(fill=..count..))+
        theme_classic()+
        labs(title="Publications per year",x="Year of publication",y="Google Scholar papers")+
        #scale_fill_gradient("Count", low = "dark blue", high = "white") #this changes the color scheme of the histogram gradient
        #plot.background = theme_rect(fill = "transparent",colour = NA)
        geom_density() #add a trendline
    print(plot.pub)
    dev.off()
    #ggsave(outfile,plot=plot.pub)
    
    #Plot the number of citations per year and output the file 
    outfile<-paste('scholar_citations_peryear_',lastname,'_',authorid,'.png',sep="")
    png(outfile,width=800,height=300,res=150,bg="transparent")
    plot.cite <- ggplot(all_publications,aes(x=year,y=cites))+
        geom_bar(stat='identity')+
        theme_classic()+
        labs(title="Citations per year",x="Year of citation",y="Google Scholar cites")
    print(plot.cite)
    dev.off()
    
    #Plot # of citations as a function of year the articles were published (bars)
    #Overplot line with publications per year
    #####PLOT CITATIONS PER YEAR WITH A DOT FOR EACH ARTICLE (onen same as pubs over time plot? stacked bars?)
    

}