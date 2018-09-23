##
# This creates a tabpanel set for docs handling
output$doc_tbset <- renderUI({
  
  ##
  # render tabset
  docs <- docs()
  do.call(tabsetPanel, c(id = "doc_tab", lapply(1:length(docs), function(i){
    tab_name <- names(docs)[i]
    fs <- docs[[i]]
    
    ##
    # render tabpanel
    tabPanel(
      tab_name,
      
      shypka.ddiv(tags$h4("Documents")),
      
      # render file name
      lapply(1:length(fs), function(j){
        
        fluidRow(
          column(
            12,
            tags$div(class = "float_left", textInput(paste0("showdoc_", tab_name, j), value = basename(fs[j]), label = NULL)),
            tags$div(class = "float_left", downloadButton(paste0("getdoc_", tab_name, j)))
          )
        )
        
      })
    )
    
  })))
    
})

##
# Handle download functions
observe({
  docs <- docs()
  lapply(1:length(docs), function(i){
    tab_name <- names(docs)[i]
    fs <- docs[[i]]
    lapply(1:length(fs), function(j){
      
      output[[paste0("getdoc_", tab_name, j)]] <- downloadHandler(
        
        filename = function() {
          basename(fs[j])
        },
        
        content = function(file) {
          file.copy(fs[j], file)
        }
      )
      
    })
  })
})

