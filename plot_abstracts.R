plot_abstracts = function(authorid,lastname,important,outdir){

### Create a wordcloud with the top words from the author's paper abstracts. 
outfile<-paste(outdir,lastname,'_abstract_wordcloud_',authorid,'.png',sep="")
png(outfile,bg="transparent",res=300,height=6,width=6,units='in')
wc<-wordcloud(names(important), important, random.color=FALSE, random.order=TRUE,
          color=brewer.pal(9, "Reds"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
#not entirely sure why i have to do this twice, but i do.
wc<-wordcloud(names(important), important, random.color=FALSE, random.order=TRUE,
          color=brewer.pal(9, "Reds"), min.freq=1, max.words=length(important), scale=c(3, 0.3))
print(wc)
dev.off




}