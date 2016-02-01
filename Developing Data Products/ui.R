library(shiny)

shinyUI (
  pageWithSidebar (
    headerPanel ("Basal metabolic rate calculator"),
    
    sidebarPanel (
      numericInput('Height', 'Height [cm]', 175, min = 50, max= 250, step = 1),
      numericInput('Weight', 'Weight [kg]', 70, min = 20, max= 200, step = 1),
      numericInput('Age', 'Age', 20, min = 10, max= 100, step = 1),
      radioButtons("Sex", label = h3("Sex"),
                   choices = list("Female" = 1, "Male" = 2), 
                   selected = 1),
      submitButton('Submit')
      ),
    mainPanel (
      h3 ('Results'),
      h4 ('Calculated metabolic rate [kcal]:'),
      textOutput("calculator")
      )
    )

)