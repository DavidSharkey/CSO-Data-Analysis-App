# Author: David Sharkey, 2020
# User Interface for CSO StatBank App


library(shinythemes) # a selection of different themes for the user interface: rstudio.github.io/shinythemes
library(csodata) # data from CSO StatBank: cran.r.project.org/web/packages/csodata/index.html



ui <- fluidPage(theme = shinytheme("sandstone"), # Sandstone theme from rstudio.github.io/shinythemes/
  
  
    selectInput(inputId = "findData", label = "Find Data from StatBank", choices = NULL, selected = NULL, selectize = TRUE),
    
    actionButton(inputId = "downloadData", label = "Download Data"),
    
    tableOutput("data"),
  
  
)