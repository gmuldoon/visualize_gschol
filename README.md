#visualize_gscholar
##Gail Muldoon

This set of scripts is an extension of work developed and shared at http://tuxette.nathalievilla.org/?p=1682 which was originally inspired by the googleCite.R script (on github and at http://biostat.jhsph.edu/~jleek/code/googleCite.r) and this post: http://rogiersbart.blogspot.fr/2015/05/put-google-scholar-citations-on-your.html. See the latter post for information on how to automatically update this information on a website.

#####To Use:
######1. Install R or Rstudio.
######2. On an R command line in the directory with the set of scripts:
~~~
setwd('/path/to/visualize_gscholar')
source('./visualize_gscholar.R',local=TRUE)
visualize_gscholar("authorid","lastname")   
~~~
######where authorid is the personal identifier in a Google Scholar profile url (for Richard Feynman: B7vSqZsAAAAJ) and lastname is the last name of the scholar (for Richard Feynman: Feynman)   
######3. Plots will be output to the same directory where the scripts are run.
######4. Plots and filenames are customizable from the plot_*.R scripts. The output directory is customizable from visualize_gschol.R. 