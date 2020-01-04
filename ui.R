#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Chicago Police Data Crime Data"),


sidebarLayout(
    sidebarPanel(
       
        selectInput(inputId = "Cat1",
                    label = "Category:",
                    choices = primary,
                    selected = 'HOMICIDE'),
        selectInput(inputId = "Cat2",
                    label = "Sub-Category:",
                    choices = secondary,
                    selected = NULL),
        selectInput(inputId = "w",
                    label = "Week",
                    choices = weeks,
                    selected = '2019-01'),
        
            hr(),
            helpText("Data from Chicago Police Department.")
        ),
       

        # Show a plot of the generated distribution
       mainPanel(
            plotOutput('bar'),
            plotOutput('map')
        )
    )
))


