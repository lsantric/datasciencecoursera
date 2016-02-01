library(shiny)

shinyServer(
  function(input, output) {
    output$calculator <- renderPrint ({
      Height = input$Height
      Weight = input$Weight
      Age = input$Age
      Sex = input$Sex
      if (Sex == 1) {
        665.09 + (9.56 * Weight) + (1.84 * Height) - (4.67 * Age)
      } else {
        66.47 + (13.75 * Weight) + (5.0 * Height) - (6.75 * Age)
      }
      
      })
  }
)