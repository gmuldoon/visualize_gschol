get_all_abstracts = function(my_id) {
    all_publications = get_all_publications(my_id)
    all_abstracts = sapply(all_publications$pubid, get_abstract, my_id=my_id)
    return(all_abstracts)
}