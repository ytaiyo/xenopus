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

# Define UI
ui <- fluidPage(
  titlePanel("Xenopus incubation time calculatior"),
  sidebarLayout(
    sidebarPanel(
      numericInput("iniStage", "Enter initial stage here:", value = 0),
      numericInput("nfStage", "Enter desired final stage here:", value = 35),
      numericInput("temp", "Enter temperature here:", value = 22)
    ),
    mainPanel(
      h4("Result"),
      verbatimTextOutput("result"),
      br(),
      h4("For both X. Tropicalis and X. Laevis")
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

# Define Server
server <- function(input, output) {
  calculate_time <- function(iniStage, temp, nfStage) {
    if (nfStage <= 40) {
      f1 <- function(time) {
        -137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * nfStage -
          ((-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage) +
             abs(-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage)) / 2 - time
      }
    } else if (nfStage > 40 & iniStage >= 40) {
      f1 <- function(time) {
        (81.97 * exp(-0.09745 * temp)) * (nfStage - iniStage) - time
      }
    } else {
      f1 <- function(time) {
        -137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * 40 -
          ((-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage) +
             abs(-137.4 * exp(-0.1460 * temp) + (21.54 * exp(-0.1192 * temp)) * iniStage)) / 2 +
          (81.97 * exp(-0.09745 * temp)) * (nfStage - 40) - time
      }
    }
    
    time <- round((uniroot.all(f1, c(0, 120))), digits = 1)
    return(time)
  }
  
  output$result <- renderText({
    time <- calculate_time(input$iniStage, input$temp, input$nfStage)
    paste("Calculated time:", time, "hours")
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)

