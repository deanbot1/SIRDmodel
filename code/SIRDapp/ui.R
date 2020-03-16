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
  titlePanel("Infection Simulator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h3("Levers--factors we can change:"),
         sliderInput("txsi",
                   "Days to wait before acting safer",
                   min = 0,
                   max = 30,
                   value = 0),     
        
         sliderInput("phixsi",
                   "Acting safer's impact on disease transmission efficiency",
                   min = 0,
                   max = 1,
                   value = .25),
      hr(),
      
      h3("Givens--factors out of our immediate control:"),

      sliderInput("hsc",
                  "Healthcare system capacity (%pop)",
                  min=0,
                  max=100,
                  value = 10),
      
      sliderInput("I0",
                  "Initially infected (%pop)",
                  min=0,
                  max=10,
                  value = 1),
      sliderInput("MTT",
                  "mean infection duration (days)",
                  min=1,
                  max=21,
                  value=7), 
      
      sliderInput("d",
                  "Death rate among infected (1/day)",
                  min=0,
                  max=0.1,
                  value=0.08),
      
      sliderInput("phid",
                  "How much more likely infected people are to die if they can't get hospital beds",
                  min=1,
                  max=10,
                  step=0.1,
                  value=2)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("SIRDPlot")
    )
  )
))
