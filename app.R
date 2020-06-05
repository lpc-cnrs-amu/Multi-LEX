

# load libraries
library(shiny)
library(shinydashboard)
#library(shinycssloaders)
library(shinyWidgets) #pickerInput

library(readr)
library(fs) # file operations independant from operating system
library(DT) # data table display


# init variable 
data <- NULL

### Read files (hundreds of MB): read filename.csv and assign content to data (global variable)
read_assign <- function(lang_selected, filename, nbrow, nbcol){
  # lang_selected: either "FRA" or "ENG" (csv files are in /data/LANG)
  # filename: the file to read
  # nbrow:  the number of lines to read in csv file
  # ncol: the number of columns to read (3 or all)
  
  # show a modal view while reading
  showModal(modalDialog(paste("Reading", filename), footer=NULL))
  nbrow_tmp <- 10000
  
  # set the number of lines to read
  if (nbrow == "10000"){
    nbrow_tmp <- 10000
  } else if (nbrow == "1e+05"){
    nbrow_tmp <- 100000
  } else if (nbrow == "1e+06"){
    nbrow_tmp <- 1000000
  } else if (nbrow == "1"){
    nbrow_tmp <- Inf
  } else {
    nbrow_tmp <- 10000
  }
  
  if (nbcol == "3"){
    # read only 3 columns and assign types explicitly
    read_csv(path("data", lang_selected, filename, ext = "csv.gz"), 
             col_names = TRUE, 
             col_types = cols_only(
               "gram" = col_character(),
               "sum_match_count" = col_double(),
               "freq_match_count" = col_double()),
             n_max = nbrow_tmp) -> x 
  } else {
    #read all columns and assign types implicitly (all column types will be imputed from the first 1000 rows on the input)
    read_csv(path("data", lang_selected, filename, ext = "csv.gz"), col_names = TRUE, col_types = NULL, n_max = nbrow_tmp) -> x
  }
  

  # assign the global variable data 
  data <<- x
  
  # remove the modal view
  removeModal()
}





ui <- dashboardPage(
  
  dashboardHeader(title = "Million Phrases"),
  
  dashboardSidebar(
    
    sidebarMenu(
      id = "sidebarmenu",
      menuItem("About", tabName = "about", icon = icon("info-circle"), selected = TRUE),
      menuItem("French", tabName = "french", icon = icon("globe"), startExpanded = TRUE, 
               menuItem('4grams', tabName = 'fr_4grams_noun234', icon = icon('table')),
               menuItem('4grams (NOUN first)', tabName = 'fr_4grams_noun1', icon = icon('table'))
      ),
      menuItem("English", tabName = "english", icon = icon("globe"), startExpanded = TRUE,
               menuItem('4grams', tabName = 'en_4grams_noun234', icon = icon('table'))
      ),
      menuItem("Download full files", tabName = "download", icon = icon("info-circle"))
      
    )
  ),
  dashboardBody(
    tabItems(
      
      # First tab content
      tabItem(tabName = "about",
              h2("Million Phrases Multilingual Database", align="center"),
              HTML("Millions of phrases (part of sentences) extracted from Google NGRAM database, in French and English")
      ),
      
      
      tabItem(tabName = "fr_4grams_noun234",


              # Panel titles
              fluidRow(h3('French 4grams (not starting with _NOUN_ tag)')),
              fluidRow(h4('Select the amount of data to read, and press Read button')),
              tags$style(type='text/css', "h2 { margin-left: 10px}"),
              tags$style(type='text/css', "h4 { margin-left: 15px; color: #DC143C;}"),
              
              # Selection criteria, variable filter, read button
              fluidRow(
                
                # number of lines
                column(3, radioButtons("fr_4grams_noun234_rbrow", label = "Number of phrases", 
                                        choices = list("10,000" = 10000,"100,000" = 100000,"1,000,000" = 1000000,"full" = 1), selected = 10000,width = "100%", inline = FALSE)),
                
                # number of columns
                column(3, radioButtons("fr_4grams_noun234_rbcol", label = "Number of variables", 
                                        choices = list("3" = 3,"All" = 23), selected = 3,width = "100%", inline = FALSE)),
                
                # filter columns
                column(5, pickerInput("fr_4grams_noun234_selectinput","Filter variables (click in the box)", choices=NULL, options = list('actions-box' = TRUE), multiple = T))
              ),
              
              fluidRow(column(9, actionButton("fr_4grams_noun234_button", "Apply selection/filter criteria and Read data")),
                       column(2, actionButton("fr_4grams_noun234_resetbutton", "Reset"))),
              
              tags$style(type='text/css', "#fr_4grams_noun234_button { width:100%; margin-bottom: 25px; color: #fff; background-color: #337ab7; border-color: #2e6da4}"),
              tags$style(type='text/css', "#fr_4grams_noun234_resetbutton { width:100%; margin-bottom: 25px; color: #fff; background-color: #f44336}"),
              
              hr(), tags$style(HTML("hr {border-top: 1px solid #000000;}")),
              
              fluidRow(column(12, DT::dataTableOutput("fr_4grams_noun234_dt")))
              
      ),
      tabItem(tabName = "fr_4grams_noun1",
              
              # Panel titles
              fluidRow(h3('French 4grams (starting with _NOUN_ tag)')),
              fluidRow(h4('Select the amount of data to read, and press Read button')),
              tags$style(type='text/css', "h2 { margin-left: 10px}"),
              tags$style(type='text/css', "h4 { margin-left: 15px; color: #DC143C;}"),
              
              # Selection criteria, variable filter, read button
              fluidRow(
                
                # number of lines
                column(3, radioButtons("fr_4grams_noun1_rbrow", label = "Number of phrases", 
                                       choices = list("10,000" = 10000,"100,000" = 100000,"1,000,000" = 1000000,"full" = 1), selected = 10000,width = "100%", inline = FALSE)),
                
                # number of columns
                column(3, radioButtons("fr_4grams_noun1_rbcol", label = "Number of variables", 
                                       choices = list("3" = 3,"All" = 23), selected = 3,width = "100%", inline = FALSE)),
                
                # filter columns
                column(5, pickerInput("fr_4grams_noun1_selectinput","Filter variables (click in the box)", choices=NULL, options = list('actions-box' = TRUE), multiple = T))
              ),
              
              fluidRow(column(9, actionButton("fr_4grams_noun1_button", "Apply selection/filter criteria and Read data")),
                       column(2, actionButton("fr_4grams_noun1_resetbutton", "Reset"))),
              
              tags$style(type='text/css', "#fr_4grams_noun1_button { width:100%; margin-bottom: 25px; color: #fff; background-color: #337ab7; border-color: #2e6da4}"),
              tags$style(type='text/css', "#fr_4grams_noun1_resetbutton { width:100%; margin-bottom: 25px; color: #fff; background-color: #f44336}"),
              
              hr(),
              
              fluidRow(column(12, DT::dataTableOutput("fr_4grams_noun1_dt")))
      
      ),
      
      
      # Second tab content
      tabItem(tabName = "en_4grams_noun234",
              h2('English 4grams (not starting with _NOUN_ tag)'),
              h3('To come')
      ),
      
      tabItem(tabName = "download",
              h2("Dowlnload the full tables"),
              hr(),
              h4("French datafiles"),
              fluidRow(downloadButton("fr_4grams_noun234_download", "Download French 4grams, _NOUN_ tag not in the first position ")),
              fluidRow(downloadButton("fr_4grams_noun1_download", "Download French 4grams, _NOUN_ tag in the first position ")),
              hr(),
              h4("English datafiles")
      )
      
      
    )
  )
)

server <- function(input, output, session) { 
  
  
  
  ####################
  ### Manage tabs behaviour
  ####################

  observe({
    if (input$sidebarmenu == "fr_4grams_noun234"){

      # read file and assign data
      read_assign("FRA", "FRA_4gram_noun234", 10000, 3)
      
      # permute gram
      d <- data[sample(nrow(data)), , drop=FALSE]
      
      # output data table
      output$fr_4grams_noun234_dt <- DT::renderDataTable({ d }, filter="top", selection="multiple", escape=FALSE,
                                                         extensions = c("Buttons"), 
                                                         options = list(dom = 'Bfrtip', 
                                                                        buttons = c('copy', 'csv', 'excel', 'pdf', 'print','pageLength'), 
                                                                        lengthMenu = list(c(50, 100, 500, 1000, 5000), c('50', '100', '500', '1000', '5000')), pageLength = 50) ) # render table

      #update radio buttons to the initial state
      updateRadioButtons(session, "fr_4grams_noun234_rbrow", selected = "10000")
      updateRadioButtons(session, "fr_4grams_noun234_rbcol", selected = "3")
      
      # update variable selection
      updatePickerInput(session, "fr_4grams_noun234_selectinput", choices = names(d))

    } 
    else if (input$sidebarmenu == 'fr_4grams_noun1'){ 
      
      # read file and assign data
      read_assign("FRA", "FRA_4gram_noun1", 10000, 3)
      
      # permute gram
      d <- data[sample(nrow(data)), , drop=FALSE]
      
      # output data table
      output$fr_4grams_noun1_dt <- DT::renderDataTable({ d },  
                                                       extensions = c("Buttons"), 
                                                       options = list(dom = 'Bfrtip', 
                                                                      buttons = c('copy', 'csv', 'excel', 'pdf', 'print','pageLength'), 
                                                                      lengthMenu = list(c(50, 100, 500, 1000, 5000), c('50', '100', '500', '1000', '5000')), pageLength = 50) ) # render table
      
      #update radio buttons to the initial state
      updateRadioButtons(session, "fr_4grams_noun1_rbrow", selected = "10000")
      updateRadioButtons(session, "fr_4grams_noun1_rbcol", selected = "3")
      
      # update variable selection
      updatePickerInput(session, "fr_4grams_noun1_selectinput", choices = names(d))
      
    } else if (input$sidebarmenu == 'en_4grams_noun234'){
      # TODO
    }
    
    
    
  })
  
  
  ####################
  ### fr_4grams_noun234
  ####################
  
  # click on fr_4grams_noun234_button
  observeEvent(input$fr_4grams_noun234_button, {
    
    # read file and assign data
    read_assign("FRA", "FRA_4gram_noun234", input$fr_4grams_noun234_rbrow, input$fr_4grams_noun234_rbcol)
    
    # column selection
    columns = names(data)
    if (!is.null(input$fr_4grams_noun234_selectinput)) {
      columns = input$fr_4grams_noun234_selectinput
    }
    data <- data[, columns, drop=FALSE] 
    
    # permute gram
    d <- data[sample(nrow(data)),, drop=FALSE]
    
    # output data table
    #output$fr_4grams_noun234_dt <- DT::renderDataTable({ d }, options = list(pageLength = 50) )
    output$fr_4grams_noun234_dt <- DT::renderDataTable({ d },  
                                                       extensions = c("Buttons"), 
                                                       options = list(dom = 'Bfrtip', 
                                                                      buttons = c('copy', 'csv', 'excel', 'pdf', 'print','pageLength'), 
                                                                      lengthMenu = list(c(50, 100, 500, 1000, 5000), c('50', '100', '500', '1000', '5000')), pageLength = 50) ) # render table
    
    # update variable selection
    updatePickerInput(session, "fr_4grams_noun234_selectinput", choices = names(d))
    
  })
  
  # click on fr_4grams_noun234_button
  observeEvent(input$fr_4grams_noun234_resetbutton, {
    
    # read file and assign data
    read_assign("FRA", "FRA_4gram_noun234", 10000, 3)
    
    # permute gram
    d <- data[sample(nrow(data)), , drop=FALSE]
    
    # output data table
    #output$fr_4grams_noun234_dt <- DT::renderDataTable({ d }, options = list(pageLength = 50) ) # render table
    output$fr_4grams_noun234_dt <- DT::renderDataTable({ d },  
                                                       extensions = c("Buttons"), 
                                                       options = list(dom = 'Bfrtip', 
                                                                      buttons = c('copy', 'csv', 'excel', 'pdf', 'print','pageLength'), 
                                                                      lengthMenu = list(c(50, 100, 500, 1000, 5000), c('50', '100', '500', '1000', '5000')), pageLength = 50) ) # render table
    
    #update radio buttons to the initial state
    updateRadioButtons(session, "fr_4grams_noun234_rbrow", selected = "10000")
    updateRadioButtons(session, "fr_4grams_noun234_rbcol", selected = "3")
    
    # update variable selection
    updatePickerInput(session, "fr_4grams_noun234_selectinput", choices = names(d))
    
  })
  
  
  ####################
  ### fr_4grams_noun1
  ####################
  
    # click on fr_4grams_noun1_button
  observeEvent(input$fr_4grams_noun1_button, {
    
    # read file and assign data
    read_assign("FRA", "FRA_4gram_noun1", input$fr_4grams_noun1_rbrow, input$fr_4grams_noun1_rbcol)
    
    # column selection
    columns = names(data)
    if (!is.null(input$fr_4grams_noun1_selectinput)) {
      columns = input$fr_4grams_noun1_selectinput
    }
    data <- data[, columns, drop=FALSE] 
    
    # permute gram
    d <- data[sample(nrow(data)),, drop=FALSE]
    
    # output data table
    output$fr_4grams_noun1_dt <- DT::renderDataTable({ d },  
                                                     extensions = c("Buttons"), 
                                                     options = list(dom = 'Bfrtip', 
                                                                    buttons = c('copy', 'csv', 'excel', 'pdf', 'print','pageLength'), 
                                                                    lengthMenu = list(c(50, 100, 500, 1000, 5000), c('50', '100', '500', '1000', '5000')), pageLength = 50) ) # render table
    
    # update variable selection
    updatePickerInput(session, "fr_4grams_noun1_selectinput", choices = names(d))
    
  })
  
  # click on fr_4grams_noun1_button
  observeEvent(input$fr_4grams_noun1_resetbutton, {
    
    # read file and assign data
    read_assign("FRA", "FRA_4gram_noun1", 10000, 3)
    
    # permute gram
    d <- data[sample(nrow(data)), , drop=FALSE]
    
    # output data table
    output$fr_4grams_noun1_dt <- DT::renderDataTable({ d },  
                                                     extensions = c("Buttons"), 
                                                     options = list(dom = 'Bfrtip', 
                                                                    buttons = c('copy', 'csv', 'excel', 'pdf', 'print','pageLength'), 
                                                                    lengthMenu = list(c(50, 100, 500, 1000, 5000), c('50', '100', '500', '1000', '5000')), pageLength = 50) ) # render table
    
    #update radio buttons to the initial state
    updateRadioButtons(session, "fr_4grams_noun1_rbrow", selected = "10000")
    updateRadioButtons(session, "fr_4grams_noun1_rbcol", selected = "3")
    
    # update variable selection
    updatePickerInput(session, "fr_4grams_noun1_selectinput", choices = names(d))
    
  })
  

  
  ####################
  ### download
  ####################

  output$fr_4grams_noun234_download <- downloadHandler( 
    filename = "fr_4grams_noun234.csv.gz",
    content = function(file) { file.copy(path("data", "FRA", "FRA_4gram_noun234.csv", ext="gz"), file) },
    contentType = "application/zip")
  
  output$fr_4grams_noun1_download <- downloadHandler( 
    filename = "fr_4grams_noun1.csv.gz",
    content = function(file) { file.copy(path("data", "FRA", "FRA_4gram_noun1.csv", ext="gz"), file) },
    contentType = "application/zip")
  
  

  
}

shinyApp(ui, server)