#Installing and loading Shiny package: 
#install.packages("shiny")
library(shiny)


# Define UI for app that draws a histogram ----
ui <- fluidPage(

  # App title ----
  titlePanel("App1"),

  #Sidebar layout with input and output definitions
  numericInput(inputId = "Samples",
                   label = "Number of Patients_Samples :",
                   min = 1,
                   max = 1000,
                   value = 200),
   #Input: Slider for the mean)
      sliderInput(inputId = "mean",
                  label = "Mean",
                  min = 1,
                  max = 1000,
                  value = 500),
      #Input:Slider for the SD----
      sliderInput(inputId = "SD",
                  label = "Standard Deviation",
                  min = 1,
                  max = 1000,
                  value = 100),
      plotOutput(outputId = "histogram"))

 # Its output type is an histogram
  server<-function(input,output){
  output$histogram<-renderPlot({
    hist(rnorm(input$Samples, input$mean, input$SD))
  })}
  
shinyApp(ui=ui,server=server)
