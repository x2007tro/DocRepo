#
# Shiny server
#
mainServer <- function(input, output, session) {

  ##
  # Retrieve all source data
  ##
  source("./iServer/src_data.R", local = TRUE)
  
  ##
  # Command list rendering
  ##
  source("./iServer/cmd_tbset.R", local = TRUE)
  
  ##
  # Documents rendering
  ##
  source("./iServer/doc_tbset.R", local = TRUE)
  
}
