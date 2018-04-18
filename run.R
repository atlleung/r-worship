#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

my_packages = c("shiny", "httr", "jsonlite")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))

library(shiny)
# library(tidyverse)
library(httr)
library(jsonlite)

# Run the application
port <- Sys.getenv('PORT')
print(port)
if(is.na(as.numeric(port))){port <- 8888}

shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)
