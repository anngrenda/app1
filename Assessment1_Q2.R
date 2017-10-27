library(shiny)

# Define UI ----
ui <- fluidPage(
  
  titlePanel("Patient Data"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("patient_data", "Choose CSV File",accept = c("patient_data_assess1.csv")),
      tags$hr(),
      
      checkboxInput("header", "Header", TRUE),
      selectInput("var", "Variable:", c("age"="Age", "height"="Height", "weight"="Weight", "bmi"="BMI")),
      radioButtons("radio_buttons",h3 ("Colour Selection"),c("Blue"="blue","Red"="red","Yellow"="yellow", "Grey"="grey"))
    ),
    
    mainPanel(
      tableOutput("contents"),
      plotOutput("variables")
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  
  output$contents <- renderTable({
    infile <- input$patient_data
    if (is.null(infile))
      return(NULL)
    c<- read.csv(infile$datapath, header = input$header)
  })
  
  
  output$variables<- renderPlot({
    (req(input$patient_data))
    infile<- input$patient_data
    data<- read.csv(infile$datapath, header=input$header)
    var<- input$var
    col<- input$radio_buttons
    boxplot(data[,var], col=col, main=paste("Variable:",var))
  })}

# Run the app ----
shinyApp(ui = ui, server = server)
