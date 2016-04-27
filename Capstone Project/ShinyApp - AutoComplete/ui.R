library(shinythemes)
library(shiny)
library(stringr)
library(markdown)
library(stylo)
library(data.table)

shinyUI(
  fluidPage(
    theme = shinytheme("united"),
    column(6,
      tags$div(
        textInput("text", 
                label = h3("Enter your text:"),
                value = ),
        tags$hr(),
        h4("Predicted next word:"),
        tags$span(style="color:red",
                  tags$strong(tags$h3(textOutput("wordPred")))),
        br(),
        tags$hr(),
        h4("Entered so far:"),
        tags$em(tags$h4(textOutput("inputWords")))
      )
    )
  )
)