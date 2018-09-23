##
# Source server and ui components
##
require(shiny)
require(magrittr)
source("helper/shypka.R")
source("helper/cmd_parser.R")
source("global.R", local = FALSE)
source("iUI/main.R")
source("iServer/main.R")

##
# Launch shiny app
##
shinyApp(
  ui = mainUI,
  server = mainServer
)