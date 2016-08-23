get_all_coauthors = function(my_id, me) {
    all_publications = get_all_publications(my_id)

    # make the author list a character vector
    all_authors = sapply(all_publications$author, as.character)
    # split it over ", "
    all_authors = unlist(sapply(all_authors, strsplit, ", "))
    names(all_authors) = NULL
    
    # remove "..." and yourself, whether or name is capitalized or not
    all_authors = all_authors[!(all_authors %in% c("..."))]

    me <- paste(toupper(substr(me, 1, 1)), substr(me, 2, nchar(me)), sep="")
    all_authors = all_authors[-grep(me, all_authors)]
    me <- toupper(me)
    all_authors = all_authors[-grep(me, all_authors)]

#    me <- tolower(me)
#    all_authors = all_authors[-grep(me, all_authors)]
    
    # make a data frame with authors by decreasing number of appearance
    all_authors = data.frame(name=factor(all_authors, 
                                         levels=names(sort(table(all_authors),decreasing=TRUE))))
    return(all_authors)
}

