# Author: David Sharkey, 2020
# Server for CSO StatBank App

library(shiny)
library(csodata) # data from SCO StatBank: cran.r-project.org/web/packages/csodata/index.html




server <- function(session, input, output){

  getDataNames <- function(){
    
      tocData <- cso_get_toc()   # details regarding data: csodata reference (https://cran.r-project.org/web/packages/csodata/csodata.pdf) and https://cran.r-project.org/web/packages/csodata/vignettes/quick_start_guide.html
      listData <- tocData$title  # get list of all datasets available 
    
  }   
  
    # fill selectInput with list of available datasets
    updateSelectizeInput(session, inputId = "findData", choices = getDataNames())

    
    
    getDataId <- function(){
    
        selectedData <- input$findData # name of dataset
        tocData <- cso_get_toc()
        titleData <- tocData$title # list of dataset names
        indexData <- which(titleData == selectedData) # matches name of dataset to ID and returns index https://stackoverflow.com/questions/45631665/get-index-of-a-specific-element-in-vector-using-operator
    
        idData <- tocData$id   
        id <- idData[indexData] # id of selected dataset  
    
    
    
  }
    
    
    
   output$data <- DT::renderDataTable({  # shiny.rstudio.com/articles/datatables.html
         
    
       id <- getDataId()
       DT::datatable(cso_get_data(id)) # https://shiny.rstudio.com/gallery/datatables-options.html and https://shiny.rstudio.com/articles/datatables.html
      
      
    })
   
   
   output$meta <- DT::renderDataTable({
     
       id <- getDataId()
       meta <- cso_get_meta(id)
     
       row_names <- c("Title", "Source", "Units", "Date Last Modified", "Variables", "Statistics") #
       data <- c(meta$Title, meta$Source, meta$Units, meta$Date_last_modified, meta$Variables, meta$Statistics)
       DT::datatable(cbind(row_names, data))
     
    })
    
  
  

}