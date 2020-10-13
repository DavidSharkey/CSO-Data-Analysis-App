# Author: David Sharkey, 2020
# User Interface for CSO StatBank App


library(shinythemes) 
library(csodata) 
library(shinydashboard) 
library(plotly)

ui <- dashboardPage( 
  
     dashboardHeader(title = "CSO StatBank"),
     dashboardSidebar(
       
       sidebarMenu(             
         menuItem("Home", tabName = "home"),
         menuItem("Visualisations", tabName = "visualisations")
         
       )
       
     ),
    
     dashboardBody(
       
       tabItems(   
         
         tabItem(tabName = "home",
                 
                 fluidRow(
  
                    box(selectInput(inputId = "findData", label = "Find Data from StatBank", choices = NULL, selected = NULL, selectize = TRUE),
    
                        actionButton(inputId = "downloadData", label = "Download Data"),
                    
                        DT::dataTableOutput("meta"), width = 6),
                    
                    box(selectInput(inputId = "summary", label = "Summary Statistics", choices = NULL, selected = NULL, selectize = TRUE),
                        
                        DT::dataTableOutput("sum"), width = 6),
   
                    box(DT::dataTableOutput("data"), width = 12) 

                 )),  
         
         tabItem(tabName = "visualisations",
                 
                 fluidRow(
                   
                   box(plotlyOutput("choropleth"))
                   
                 )
                 
                 
         )
                 
                 
    )
  
))
