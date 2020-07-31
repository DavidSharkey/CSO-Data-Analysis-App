# Author: David Sharkey, 2020
# Server for CSO StatBank App

library(shiny)
library(csodata) # data from SCO StatBank: cran.r-project.org/web/packages/csodata/index.html

server <- function(session, input, output){

  
    # fill selectInput with list of available datasets
    updateSelectizeInput(session, inputId = "findData", choices = getDataNames())


    getDataNames <- function(){
    
        tocData <- cso_get_toc()   # details regarding data: csodata reference
        listData <- tocData$title  # get list of all datasets available 
    
    }  
  
  

}