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
    
    updateSelectizeInput(session, inputId = "summary", choices = c(colnames(getDataNames())))
    
    
    getDataId <- function(){
    
        selectedData <- input$findData # name of dataset
        tocData <- cso_get_toc()  # extract table of contents
        titleData <- tocData$title # list of dataset names
        indexData <- which(titleData == selectedData) # matches name of dataset to ID and returns index https://stackoverflow.com/questions/45631665/get-index-of-a-specific-element-in-vector-using-operator
    
        idData <- tocData$id   
        id <- idData[indexData] # id of selected dataset  
    
    
  }
    
    
    # https://shiny.rstudio.com/articles/reactivity-overview.html#:~:text=In%20a%20simple%20Shiny%20application,accessible%20through%20the%20output%20object.&text=In%20an%20app%20with%20the,plot%20will%20automatically%20re%2Dexecute.
    getData <- eventReactive(input$downloadData, { # https://shiny.programmingpedia.net/en/tutorial/10787/reactive--reactivevalue-and-eventreactive--observe-and-observeevent-in-shiny
      
      
      id <- getDataId()
      values <- reactiveValues()  # shiny.rstudio.com/reference/shiny/0.11/reativeValues.html
      values <- cso_get_data(id)
      
    })
    
    
   output$data <- DT::renderDataTable({  # shiny.rstudio.com/articles/datatables.html
         
    
       DT::datatable(getData()) # https://shiny.rstudio.com/gallery/datatables-options.html and https://shiny.rstudio.com/articles/datatables.html
      
      
    })
   
   
   output$meta <- DT::renderDataTable({
     
       id <- getDataId()
       meta <- cso_get_meta(id) # get meta data
     
       # Make table of meta-data
       row_names <- c("Title", "Source", "Units", "Date Last Modified", "Variables", "Statistics") #
       data <- c(meta$Title, meta$Source, meta$Units, meta$Date_last_modified, meta$Variables, meta$Statistics)
       DT::datatable(cbind(row_names, data))
     
    })
   
   

}