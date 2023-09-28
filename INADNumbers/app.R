#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

setwd("C:/Users/mhayden/Documents/Projects/ToddShiny/INADNumbers")
data <- read.csv("West Brook_104_Sampling Report.csv" , header=TRUE)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("INAD Fish Numbers"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
     
            selectInput("sTream",
                        "Stream", 
                        choices = unique(data$Stream), 
                        selected = "Mitchell" ),
        selectInput("sAmpleNumber",
                    "SampleNumber", 
                    choices =unique(data$SampleNumber), 
                    selected = "104" )
    ),

        # Show a plot of the generated distribution
        mainPanel(
           #plotOutput("distPlot"),
           tableOutput("table")
           
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
    

   
    output$table <- renderTable({ data %>% filter(Stream == input$sTream,
                                                  SampleNumber == input$sAmpleNumber) %>% 
                                           select(Stream, Species , Count) })
}

# Run the application 
shinyApp(ui = ui, server = server)
