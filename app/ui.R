
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Visualize Google Scholar Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        textInput("lastname", "Author Last Name:", "Einstein"),
        textInput("authorid", "Google Scholar ID:","qc6CJjYAAAAJ"),
        #textInput("lastname", "Author Last Name:", "Thirumalai"),
        #textInput("authorid", "Google Scholar ID:","HluYWesAAAAJ"),
    
        sliderInput("minfreq", "Min word frequency:",
                    min = 1, max = 100, value = 5),
        # Slider input for number of words change
        sliderInput("maxwords", "Max words:",
                    min = 10, max = 500, value = 100) ,
        
    actionButton("go", "Make wordcloud!")
    ),

    mainPanel(
        # Wordcloud image rendered
        imageOutput("wc")
    )
  )
))
