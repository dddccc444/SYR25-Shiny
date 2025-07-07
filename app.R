#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "x",
                      label = "which attribute on x-axis",
                      choices = colnames(tbCan)),
          
          selectInput(inputId = "y",
                      label = "which attribute on y-axis",
                      choices = colnames(tbCan))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      colIndexX <- which(input$x == colnames(tbCan))
      colIndexY <- which(input$y == colnames(tbCan))
      
      xX    <- tbCan[, colIndexX]
      yY    <- tbCan[, colIndexY]
      
      titleString <- paste("Scatter Plot for ", input$x, "by", input$y)
      
      ggplot(data= tbCan, aes(x= xX, y= yY)) +
        geom_line() +
        geom_point() +
        labs(title= titleString, x= input$x, y= input$y)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
