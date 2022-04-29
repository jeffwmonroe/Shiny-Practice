library(shiny)
library(DT)

ui <- fluidPage(
  sliderInput( inputId = "num",
                label= "Choose a number",
                value=25,
                min=1,
                max=100),
  textOutput( outputId = "simpleText"),
  checkboxGroupInput( "cbox", "This is a chebox group", choices = c("A","B","B", "C","D") ), 
  DT::dataTableOutput("mytable" )
 # sprintf("Hello World")
)

server <- function ( input, output ) {
  output$simpleText <- renderText({"Hello World"})
  output$mytable <- renderDataTable({df},
                                    options = list(searching=FALSE, pageLength=1, paging=FALSE))
}

shinyApp( ui=ui, server = server)

#rsconnect::deployApp('D:/Coding/Shiny Practice')
