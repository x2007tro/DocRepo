##
# This creates a tabpanel set for commands
output$cmd_tbset <- renderUI({
  
  ##
  # render tabset
  cmds <- cmds()
  do.call(tabsetPanel, c(id = "cmd_tab", lapply(1:length(cmds), function(i){
    tab_name <- names(cmds)[i]
    fs <- cmds[[i]]
    curr_cat <- ""
    
    ##
    # render tabpanel
    tabPanel(
      tab_name,
      
      shypka.ddiv(tags$h4("Commands")),
      
      tags$div(class = "float_left", shypka.ddiv(tags$h5(class="title_block", "Category"), color = "green")),
      tags$div(class = "float_left", shypka.ddiv(tags$h5(class="title_block", "Name"))),
      tags$div(class = "float_left", shypka.ddiv(tags$h5(class="title_block", "Command"))),
      tags$div(class = "float_left", shypka.ddiv(tags$h5(class="title_block", "Comments"))),
      tags$div(class = "float_left", shypka.ddiv(tags$h5(class="title_block", "Reference"))),
      
      # render file name
      lapply(1:length(fs), function(j){
        
        fluidRow(
          column(
            12,
            tags$div(class = "float_left", textInput(paste0("showcmd_", tab_name, "_cat_", j), value = fs[[j]]$category, label = NULL)),
            tags$div(class = "float_left", textInput(paste0("showcmd_", tab_name, "_nm_", j), value = fs[[j]]$name, label = NULL)),
            tags$div(class = "float_left", textInput(paste0("showcmd_", tab_name, "_cmd_", j), value = fs[[j]]$command, label = NULL)),
            tags$div(class = "float_left", textInput(paste0("showcmd_", tab_name, "_cmt_", j), value = fs[[j]]$comment, label = NULL)),
            tags$div(class = "float_left", textInput(paste0("showcmd_", tab_name, "_ref_", j), value = fs[[j]]$reference, label = NULL))
          )
        )
        
      })
    )
    
  })))
    
})


