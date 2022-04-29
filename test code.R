library(shiny)
library(DT)
mymtcars = mtcars
mymtcars$id = 1:nrow(mtcars)
runApp(
  list(ui = pageWithSidebar(
    headerPanel('Examples of DataTables'),
    sidebarPanel(
      checkboxGroupInput('show_vars', 'Columns to show:', names(mymtcars),
                         selected = names(mymtcars))
      ,textInput("collection_txt",label="Foo")
    ),
    mainPanel(
      DT::dataTableOutput("mytable")
    )
  )
  , server = function(input, output, session) {
    rowSelect <- reactive({
      paste(sort(unique(input[["rows"]])),sep=',')
    })
    observe({
      updateTextInput(session, "collection_txt", value = rowSelect() ,label = "Foo:" )
    })
    output$mytable = DT::renderDataTable({
      addCheckboxButtons <- paste0('<input type="checkbox" name="row', mymtcars$id, '" value="', mymtcars$id, '">',"")
      addCheckboxButtons[3] <- NA
      #Display table with checkbox buttons
      DT::datatable(cbind(Pick=addCheckboxButtons, mymtcars[, input$show_vars, drop=FALSE]),
                    options = list(orderClasses = TRUE,
                                   lengthMenu = c(5, 25, 50),
                                   pageLength = 25, 
                                   callback = JS("function(table) {
    table.on('change.dt', 'tr td input:checkbox', function() {
          setTimeout(function () {
          Shiny.onInputChange('rows', $(this).add('tr td input:checkbox:checked').parent().siblings(':last-child').map(function() {
          return $(this).text();
          }).get())
          }, 10); 
          });
          }")),escape = FALSE,
                    
      )
    } 
    )
  }
  )
)


df <- data.frame ( Cat1=c( "Normal", NA, NA, "Expense", NA), 
                   Cat2= c( NA, "Income", "COGS", NA, "A"), 
                   Item = c("X","X","X","X","X"))
datatable(df)
