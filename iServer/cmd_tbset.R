##
# This creates a tabpanel set for commands
output$cmd_tbset <- renderUI({
  
  ##
  # render tabset
  cmds <- cmds()
  do.call(tabsetPanel, c(id = "cmd_tab", lapply(1:length(cmds), function(i){
    tab_name <- names(cmds)[i]
    fs <- cmds[[i]]
    
    tabPanel(
      tab_name,
      
      fluidRow(
        column(
          12,
          shypka.ddiv(tags$h3(class = "title_block", "Commands"), color = "green"),
          DT::dataTableOutput(paste0("cmb_tbl", i))
        )
      )
      
    )
    
  })))
    
})

##
# Handle download functions
observe({
  ##
  # render tabset
  cmds <- cmds()
  lapply(1:length(cmds), function(i){
    fs <- cmds[[i]]
    fs_tb <- dplyr::bind_rows(fs)
    
    output[[paste0("cmb_tbl", i)]] <- DT::renderDataTable({
      DT::datatable(
        fs_tb,
        options = list(
          pageLength = 20,
          orderClasses = TRUE,
          searching = TRUE,
          paging = TRUE
        )
      )
    })
    
  })
})


