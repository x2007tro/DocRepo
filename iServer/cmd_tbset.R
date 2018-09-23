##
# This creates a tabpanel set for commands
output$cmd_tbset <- renderUI({
  
  ##
  # render tabset
  if(is.null(input$file_u)) cmds <- cmds_fb() else cmds <- cmds()
  do.call(tabsetPanel, c(id = "cmd_tab", lapply(1:(length(cmds)+1), function(i){
    
    if(i == (length(cmds)+1)){
      tabPanel(
        "Upload",
        
        fluidRow(
          column(
            width = 12,
            
            #shypka.ddiv(tags$h3(class = "block_title", "Upload and Download"), color = "rgba(105,105,105,1)"),
            tags$br(),
            downloadButton(class = "btn-primary", "file_d", "Download Current List"),
            tags$br(), tags$br(),
            fileInput("file_u", "Upload New List",
                      multiple = FALSE,
                      accept = c(".xlsx", ".xls"))
          ) 
        )
        
      )
    } else {
      tab_name <- names(cmds)[i]
      fs <- cmds[[i]]
      
      tabPanel(
        tab_name,
        
        fluidRow(
          column(
            12,
            #shypka.ddiv(tags$h3(class = "block_title", "Commands"), color = "green"),
            tags$br(),
            DT::dataTableOutput(paste0("cmb_tbl", i))
          )
        )
        
      )
    }
    
  })))
    
})

##
# Handle download functions
observe({
  ##
  # render tabset
  if(is.null(input$file_u)) cmds <- cmds_fb() else cmds <- cmds()
  lapply(1:length(cmds), function(i){
    fs <- cmds[[i]]
    fs_tb <- dplyr::bind_rows(fs)
    colnames(fs_tb)
    
    output[[paste0("cmb_tbl", i)]] <- DT::renderDataTable({
      DT::datatable(
        fs_tb,
        options = list(
          pageLength = 20,
          orderClasses = TRUE,
          searching = TRUE,
          paging = TRUE
        ),
        editable = FALSE,
        selection = "none"
      ) %>% 
        DT::formatStyle(
          'Category',
          fontWeight = "bold",
          color = "gray",
          backgroundColor = DT::styleEqual(
            unique(fs_tb$Category),
            RColorBrewer::brewer.pal(n = length(unique(fs_tb$Category)), name = "Set3")
          )
        ) %>% 
        DT::formatStyle(
          'Command',
          #fontWeight = "bold",
          color = "white",       # crimson
          backgroundColor = "#FA8072"
        )
    })
    
  })
})

##
# This handles commands upload
cmds <- reactive({
  
  req(input$file_u)
  file.copy(input$file_u$datapath, cmd_path, overwrite = TRUE)
  
  res <- ParseCmds(cmd_path, cmd_shts)
  return(res)
})

##
# This handles commands download
output$file_d <- downloadHandler(
  
  # This function returns a string which tells the client
  # browser what name to use when saving the file.
  filename = function() {
    "CommonCommandList.xlsx"
  },
  
  content = function(file) {
    file.copy(cmd_path, file)
  }
)