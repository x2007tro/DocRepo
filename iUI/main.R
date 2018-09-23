##
# Source all ui files (no file for this app)
##
# ui_files <- c("fitness", "fileupload")
# lapply(ui_files, function(f){
#   source(paste0("./iUI/", f, ".R"), local = FALSE)
# })

##
# Shiny ui
##
mainUI <- fluidPage(theme = shinythemes::shinytheme("simplex"),
  
  # css style
  tags$head(
    includeCSS("stt_style.css")
  ),
  
  # main frame
  navbarPage(
    "Doc Repo",
    
    tabPanel(
      "Main",
      
      fluidRow(
        column(
          12,
          navlistPanel(
            
            widths = c(2,10),
            
            "Index",
            
            ## 
            # commands set
            tabPanel(
              "Commands",
              uiOutput("cmd_tbset")
            ),
            
            
            ## 
            # documents set
            tabPanel(
              "Documents",
              uiOutput("doc_tbset")
            )
            
          )
        )
      )
      
    )
  )
  
)
