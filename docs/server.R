#Load libraries
library(shiny)
library(AppliedPredictiveModeling)
data("solubility")

# Define server logic required to draw a graph 
shinyServer(function(input, output) {
        
        #Open data 
        data(solubility)
        solubility <- solTrainY
        hydrophilicfactor <- solTrainX$HydrophilicFactor
        molecularweight <- solTrainX$MolWeight
        
        #Fit model
        model1 <- lm(solubility ~ molecularweight)
        model2 <- lm(solubility ~ hydrophilicfactor)
        
        #Predict with input
        model1pred <- reactive({ 
                MWinput <- input$sliderMW
                predict(model1, newdata = data.frame(molecularweight = MWinput))
                })
        model2pred <- reactive({
                HFinput <- input$sliderHF
                predict(model2, newdata = data.frame(hydrophilicfactor = HFinput))
        })
        
        output$plot1 <- renderPlot({
                MWInput <- input$sliderMW
                plot(molecularweight, solubility, 
                     xlab = "Molecular weight (dalton)",
                     ylab = "Solubility", 
                     pch = 16)
                points(MWInput, model1pred(), col="red", pch=16, cex=2)
        })
        
        output$pred1 <- renderText({
                model1pred()
        })
        
        output$plot2 <- renderPlot({
                HFInput <- input$sliderHF
                plot(hydrophilicfactor, solubility, 
                     xlab = "Molecular weight (dalton)",
                     ylab = "Solubility", 
                     pch = 16)
                points(HFInput, model2pred(), col="blue", pch=16, cex=2)
        })
        
        output$pred2 <- renderText({
                model2pred()
        })
  
})
