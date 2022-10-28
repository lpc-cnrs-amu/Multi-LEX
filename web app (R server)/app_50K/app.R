
library(shiny)
library(shinydashboard) # dashboard ui
library(readr) # read tabulated separated file
library(fs) # file operations independant from operating system
library(DT) # data table display


# Define UI
ui <- dashboardPage(
  title = "Multilex",
  dashboardHeader(title = uiOutput("title_val")),
  dashboardSidebar(br(),
                   tags$h4('File reading options'),
                   hr(),
                   radioButtons("rbcol", label = "Columns",
                                choices = list("Sequences & Frequency" = 2,"All" = 1),
                                selected = 2,
                                width = "100%",
                                inline = FALSE),
                   hr(),
                   tags$h4('Interface'),
                   br(),
                   tags$ul(tags$li(tags$b('File reading options, columns'), ' : the initial display uses a 2-column table. Displaying "all" shows all the columns.'),
                           tags$li(tags$b('Show button'), ' : shows up to 5000 rows on a single page.'),
                           tags$li(tags$b('Copy button'), ' : copies what is displayed in the clipboard.'),
                           tags$li(tags$b('CSV, XLS, PDF buttons'), ' : generates a file from a selection.'),
                           tags$li(tags$b('Generic search box'), ' : searches entire rows for a particular term whatever its within-row position (e.g. "verb", "adj", "sun").'),
                           tags$li(tags$b('Column headers'), ' : click on a header to sort the row selection (alaphabetical, numerical).'),
                           tags$li(tags$b('Specific column-based filter boxes'), ' : filters rows on a particular term in a specific position (e.g. "the" in the 1st position filter box).')),
                   tags$style(HTML("hr {border-top: 1px solid #000000;}")),
                   tags$style(HTML("h4 {margin-left: 15px; color:#FEDA72;}")),
                   tags$style(HTML("ul {margin-right: 5px;font-size:0.8em}"))

  ),
  dashboardBody(
    fluidRow(column(12, DT::dataTableOutput("dt"))),
    tags$head(tags$link(rel="shortcut icon", href="favicon.ico"))
  )

)






# Define server logic required to draw a histogram ----
server <- function(input, output, session) {

  observe({

    # get URL parameter
    query <- parseQueryString(session$clientData$url_search)

    # set lang
    if (!is.null(query$lang)) {
      lang_val <- query$lang
    } else {
      lang_val <- "FRE"
    }

    # set n ngram
    if (!is.null(query$n)) {
      n_val <- query$n
    } else {
      n_val <- "4"
    }


    # set length of the dqtqset
    rbrow = 50000
    rbrow_val = "50k"
    #rbrow == 1000000
    #rbrow_val = "million"


    # read file
    filename <- paste0(lang_val, n_val, "_", rbrow_val, ".csv.gz")

    # show the modal view
    showModal(modalDialog(paste("Reading", filename), footer=NULL))

    if (input$rbcol == "2"){
      # read only 2 columns and assign types explicitly
      data <- read_tsv(path("..", "data", filename), col_names = TRUE, col_types = cols_only("NGRAM" = col_character(), "FPM" = col_double()))
    } else {
      #read all columns and assign types implicitly (all column types will be imputed from the first 1000 rows on the input)
      data <- read_tsv(path("..", "data", filename), col_names = TRUE, col_types = NULL)
    }

    # remove the modal view
    removeModal()

    # Set variables according to URL GET information
    if (lang_val == "FRE"){
      title_val = paste0("FRENCH ", n_val, "-GRAMS")
    } else if (lang_val == "ENG"){
      title_val = paste0("ENGLISH ", n_val, "-GRAMS")
    } else {
      title_val = paste0("FRENCH ", n_val, "-GRAMS")
    }

    # Set texts in UI
    output$title_val <- renderUI({ h3(title_val) })

    # shuffle grams
    d <- data[sample(nrow(data)), , drop=FALSE]

    # output data table
    output$dt <- DT::renderDataTable({ d }, filter="top", selection="multiple", escape=FALSE,
                                     extensions = c("Buttons"),
                                     options = list(dom = 'Bfrtip',
                                                    buttons = c('pageLength','copy', 'csv', 'excel', 'pdf'),
                                                    lengthMenu = list(c(100, 1000, 10000, -1), c('100', '1000', '10000', 'all')),
                                                    pageLength = 100,
                                                    scrollX = TRUE)) # render table

  })





}

shinyApp(ui, server)

