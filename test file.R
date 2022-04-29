library(shiny)

ui <- fluidPage(
  sliderInput( inputId = "num",
                label= "Choose a number",
                value=25,
                min=1,
                max=100),
  plotOutput( outputId =  "simpleHist"),
  textOutput( outputId = "simpleText")
 # sprintf("Hello World")
)

server <- function ( input, output ) {
  output$simpleText <- renderText({"Hello World"})
  output$simpleHist <- renderPlot({ 
    title <- "Simple Title"
    vals <- input$num
    hist (rnorm(vals), main = title)})
}

shinyApp( ui=ui, server = server)
