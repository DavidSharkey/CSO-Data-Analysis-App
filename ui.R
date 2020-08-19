# Author: David Sharkey, 2020
# User Interface for CSO StatBank App


library(shinythemes) # a selection of different themes for the user interface: rstudio.github.io/shinythemes
library(csodata) # data from CSO StatBank: cran.r.project.org/web/packages/csodata/index.html
library(shinydashboard) # rstudio.github.io/shinydashboard/


ui <- dashboardPage( # rstudio.github.io/shinydashboard/get_started.html
  
     dashboardHeader(title = "CSO StatBank"),
     dashboardSidebar(
       
       sidebarMenu(              # rstudio.github.io/shinydashboard/get_started.html
         menuItem("Home", tabName = "home"),
         menuItem("Visualisations", tabName = "visualisations")
         
       )
       
     ),
    
     dashboardBody(
       
       tabItems(   # rstudio.github.io/shinydashboard/get_started.html
         
         tabItem(tabName = "home",
                 
                 fluidRow(
  
                    box(selectInput(inputId = "findData", label = "Find Data from StatBank", choices = NULL, selected = NULL, selectize = TRUE),
    
                        actionButton(inputId = "downloadData", label = "Download Data"), wdith = 10),
                    
                    box(DT::dataTableOutput("meta"), width = 6),
                    
                    box(selectInput(inputId = "summary", label = "Summary Statistics", choices = NULL, selected = NULL, selectize = TRUE),
                        
                        DT::dataTableOutput("sum"), width = 6),
   
                    box(DT::dataTableOutput("data"), width = 12) # shiny.rstudio.com/articles/datatables.html

                 )),  
         
         tabItem(tabName = "visualisations",
                 
                 fluidRow(
                   
                   
                 )
                 
                 
         )
                 
                 
    )
  
))
