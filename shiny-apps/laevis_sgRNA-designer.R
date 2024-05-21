# Install required packages if not already installed
if (!require(shiny)) {
  install.packages("shiny")
}
if (!require(DT)) {
  install.packages("DT")
}

# Load required libraries
library(shiny)
library(DT)

# UI
ui <- fluidPage(
  titlePanel("X.Laevis gRNA designer"),
  sidebarLayout(
    sidebarPanel(
      p("This tool finds perfect gRNA matches between the Xenopus Laevis L and S genome."),
      p("Download L and S genome gRNA lists of your gene of interest from crisprscan.org as .tsv files and upload them here."),
      p("Look up the bounds of the gRNA search in the L genome (typically the first couple of exons, not including the first one)."),
      fileInput("file1", "Upload L gRNAs (.tsv file)"),
      numericInput("lowerBound", "Lower Bound on L genome:", 41941000),
      numericInput("upperBound", "Upper Bound on L genome:", 41947500),
      fileInput("file2", "Upload S gRNAs (.tsv file)"),
      actionButton("submitBtn", "Submit"),
      br(),
      p(" "),
      p("Made by Taiyo Yamamoto")
    ),
    mainPanel(
      DTOutput("resultTable")
    )
  )
)

# Server
server <- function(input, output) {
  
  # Read TSV files and filter rows
  observeEvent(input$submitBtn, {
    req(input$file1, input$file2)
    
    # Read file 1
    df1 <- read.table(input$file1$datapath, sep = "\t", header = TRUE, stringsAsFactors = FALSE)
    
    df1_filtered <- df1[df1$start >= input$lowerBound & df1$start <= input$upperBound, ]
    
    # Read file 2
    df2 <- read.table(input$file2$datapath, sep = "\t", header = TRUE, stringsAsFactors = FALSE)
    
    # Filter rows with the same gRNA
    filteredRows <- merge(df1_filtered, df2, by = "sgrna_seq")
    
    # Sort by score_crisprscan in descending order
    filteredRows <- filteredRows[order(filteredRows$score_crisprscan.x, decreasing = TRUE), ]
    
    # Rename columns
    colnames(filteredRows)[colnames(filteredRows) == 'seq.x'] <- 'seq'
    colnames(filteredRows)[colnames(filteredRows) == 'start.x'] <- 'start'
    colnames(filteredRows)[colnames(filteredRows) == 'score_crisprscan.x'] <- 'score_crisprscan'
    colnames(filteredRows)[colnames(filteredRows) == 'offtarget_number_all.x'] <- 'offtarget_number_all'
    colnames(filteredRows)[colnames(filteredRows) == 'offtarget_number_seed.x'] <- 'offtarget_number_seed'
    colnames(filteredRows)[colnames(filteredRows) == 'offtarget_cfd_score.x'] <- 'offtarget_cfd_score'
    
    # Display filtered rows in table
    output$resultTable <- renderDT({
      datatable(filteredRows[, c("seq", "start", "sgrna_seq", "score_crisprscan", "offtarget_number_all", "offtarget_number_seed", "offtarget_cfd_score")], options = list(pageLength = 25))
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)
