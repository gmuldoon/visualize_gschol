plot_authors = function(main_authors) {
    name<-as.factor(main_authors)
    ggplot(data=main_authors,aes(table(name)))
    
    #Plot histogram of co-authors
    p = ggplot(main_authors) + geom_bar(fill=brewer.pal(3, "Set2")[2]) +
        xlab("co-author") + theme_bw() + theme(axis.text.x = element_text(angle=90, hjust=1))
    print(p)
    
    #Make word cloud of co-authors
    
    # Bar plot of co-authors over time? (one line per coauthor, each line labeled)

}

#####PLOT histogram of journals

#Histogram of journals
#Bar plot of journals over time