# Author: David Sharkey, 2020
# Server for CSO StatBank App

library(shiny)
library(csodata) 
library(tidyr)
library(plotly)
library(rjson)

server <- function(session, input, output){

  getDataNames <- function(){
    
      tocData <- cso_get_toc()   # details regarding data
      #listData <- tocData$title  # get list of all datasets available
      paste(tocData[,2], tocData[,3])
      
        }   
  
  
  
    # fill selectInput with list of available datasets
   updateSelectizeInput(session, inputId = "findData", choices = getDataNames())
    
    
    
  observe({ 
    
    updateSelectizeInput(session, inputId = "summary", choices = colnames(summary(getData())))
    
    
  })
    
    
    getDataId <- function(){
    
        #selectedData <- input$findData # name of dataset
        #print(selectedData)
        #tocData <- cso_get_toc()  # extract table of contents
        #titleData <- tocData$title # list of dataset names
        #indexData <- which(titleData == selectedData) # matches name of dataset to ID and returns index 
    
        #idData <- tocData$id   
        #id <- idData[indexData] # id of selected dataset  
    
      
        selectedData <- input$findData
        print(selectedData)
        ls <- nchar(selectedData)
        print(ls)
        ah <- substr(selectedData, ls - 4, ls)
        print(ah)
        
    
  }
    
    
    
    getData <- eventReactive(input$downloadData, { 
      
      
      id <- getDataId()
      values <- reactiveValues()  
      values <- cso_get_data(id)
      
    })
    
    
   output$data <- DT::renderDataTable({  
         
    
       DT::datatable(getData()) 
      
      
    })
   
   
   output$meta <- DT::renderDataTable({
     
       id <- getDataId()
       meta <- cso_get_meta(id) # get meta data
     
       # Make table of meta-data
       row_names <- list("Title", "Source", "Units", "Date Last Modified", "Variables", "Statistics") #
       data <- list(meta$Title, meta$Source, meta$Units, meta$Date_last_modified, meta$Variables, meta$Statistics)
       DT::datatable(cbind(row_names, data))
       
    })
   
   
   output$sum <- DT::renderDataTable({
     
      
      col <- input$summary
      index <- which(colnames(summary(getData())) == col)
      data <- summary(getData())
      stats_data <- a[,num]
      separate(data.frame(f),f, into = c("1", "2"), sep = ":")
      
      
     
   })
   
   
   output$choropleth <- renderPlotly({
     
#     plot_ly(type = "choropleth", locationmode = "country names", location = "Ireland")
     
   })
   
   
     
   }
   
   
   

