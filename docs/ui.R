library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Solubility of compounds"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderMW",
                   "Molecular Weight",
                   min = 46,
                   max = 250,
                   value = 665),
       sliderInput("sliderHF",
                   "Hydrophilic Factor",
                   min = -0.985,
                   max = 13.483,
                   value = 1),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1"),
       plotOutput("plot2"),
      h4("Predicted solubility level from the model (Red Circle):"),
      textOutput("pred1"),
      textOutput("pred2"), 
      h6("A Quick Quide to Users: Enter the value of the molecular weight with
         the above slider then press on Submit button")
    )
  )
))
