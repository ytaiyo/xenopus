# Install required packages if not already installed
if (!require(shiny)) {
  install.packages("shiny")
}
if (!require(rootSolve)) {
  install.packages("rootSolve")
}

# Load required libraries
library(shiny)
library(rootSolve)

# Define the UI
ui <- fluidPage(
  titlePanel("NF-Stage Incubation Calculator"),
  
  # Main layout with a sidebar and main panel
  sidebarLayout(
    sidebarPanel(
      numericInput("iniStage", "Initial NF-Stage:", value = 0),
      numericInput("nfStage", "Desired Final NF-Stage:", value = 35),
      numericInput("time", "Hours until Final NF-Stage:", value = 48)
    ),
    
    mainPanel(
      h4("Result"),
      div(style = "font-size: 18px;", 
          verbatimTextOutput("output")),
      br(),
      h4("For both X. Tropicalis and X. Laevis"),
      br(),
      h4("Inaccurate for stages 40+"),
      h4("Recommended incubation temperature ranges"),
      h5("X. Tropicalis: 20-28°C"),
      h5("X. Laevis: 14-22°C"),
    )
  ),
  
  # Explanation text below the main layout
  fluidRow(
    column(width = 12,
           h4("Background:"),
           p(a("Google doc", href = "https://docs.google.com/document/d/1hgQUWO2XMmLkNYLLH7CPkMmxlMuVqj-LPx0SfMHwP9Q/edit?usp=sharing"), " for more information."),
           br(),
           p("Made by Taiyo Yamamoto")
    )
  )
)

# Define the server
server <- function(input, output) {
  output$output <- renderPrint({
    # Get the user inputs
    iniStage <- input$iniStage
    nfStage <- input$nfStage
    time <- input$time
    
    # Perform the calculation based on the provided logic
    if (nfStage <= 40) {
      f1 <- function(temp) {
        -137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * nfStage -
          ((-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage) +
             abs(-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage)) / 2 - time
      }
    } else if (nfStage > 40 & iniStage >= 40) {
      f1 <- function(temp) {
        (81.97 * exp(-0.09745 * temp)) * (nfStage - iniStage) - time
      }
    } else {
      f1 <- function(temp) {
        -137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * 40 -
          ((-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage) +
             abs(-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage)) / 2 +
          (81.97 * exp(-0.09745 * temp)) * (nfStage - 40) - time
      }
    }
    
    # Calculate the temperature using uniroot.all from the rootSolve package
    temperature <- round((uniroot.all(f1, c(0, 50))), digits = 1)
    
    # Create the output text
    result <- paste("Incubate at", temperature, "°C")
    return(result)
  })
}

# Run the Shiny app
shinyApp(ui, server)
