# Author: David Sharkey, 2020
# User Interface for CSO StatBank App


library(shinythemes) 
library(csodata) 
library(shinydashboard) 
library(plotly)
library(shinycssloaders) # https://github.com/daattali/shinycssloaders

ui <- dashboardPage( 
  
     dashboardHeader(title = "CSO StatBank"),
     dashboardSidebar(
       
       sidebarMenu(             
         menuItem("Home", tabName = "home"),
         menuItem("Statistics/Visualisations", tabName = "visualisations"),
         menuItem("About", tabName = "about")
         
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
                        
                        shinycssloaders::withSpinner(DT::dataTableOutput("sum")), width = 6), # https://github.com/daattali/shinycssloaders
   
                    box(shinycssloaders::withSpinner(DT::dataTableOutput("data")), width = 12) 

                 )),  
         
         tabItem(tabName = "visualisations",
                 
                 fluidRow(
                   
                   
                   #box(plotlyOutput("choropleth"))
                   box(
                     
                     selectInput("x_var", "Choose X variable", choices = NULL, selected = NULL, selectize = TRUE),
                     
                     selectInput("y_var", "Choose y variable", choices = NULL, selected = NULL, selectize = TRUE),
                     
                     plotlyOutput("bar_chart"), width = 12)
                   
                 )),
         
         
         tabItem(tabName = "about",
                 
                 fluidRow(
                   
                 ))
         
         
         
         
                 
                 
    )
  
))
