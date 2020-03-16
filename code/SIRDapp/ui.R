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
  titlePanel("Infection Simulator: Flattening the Curve"),
  p("Disclaimer: this simulation tutorial as parameterized does not reflect any known transmissible disease. It exists only to illustrate the potential impact of safe behavior, and delay therof, on mortality count from a fictitious disease in a hypothetical population of 10000 individuals."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      checkboxInput("scaleflag",
                    "Auto-scale Y axis (scarier)",
                    value=TRUE),
      
      h3("Levers--factors we can change:"),
         sliderInput("txsi",
                   "Days to wait before acting safer",
                   min = 0,
                   max = 30,
                   value = 0),     
        
         sliderInput("phixsi",
                   "Acting safer impact on disease transmission efficiency",
                   min = 0,
                   max = 1,
                   value = .25),
      hr(),
      
      h3("Givens--factors out of our immediate control:"),


      
      sliderInput("I0",
                  "Initially infected (%pop)",
                  min=0,
                  max=10,
                  value = 1),
      
      sliderInput("xsi",
                  "Baseline infection transmission efficiency (1/day)",
                  min = 0,
                  max = 5,
                  value = 1.8,
                  step = .1),
      
      sliderInput("MTT",
                  "mean infection duration (days)",
                  min=1,
                  max=21,
                  value=7), 
      
      sliderInput("d",
                  "Death rate among infected (1/day)",
                  min=0,
                  max=0.1,
                  value=0.05),
      
      sliderInput("hsc",
                  "Healthcare system capacity (%pop)",
                  min=0,
                  max=100,
                  value = 10),    
      
      sliderInput("phid",
                  "How much more likely infected people are to die if they can't get hospital beds",
                  min=1,
                  max=10,
                  step=0.1,
                  value=2)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("SIRDPlot"),
       p("------Dashed line represents healthcare system capacity"),
       h3("Scenarios to try:"),
       p("What happens to the death total if we wait 3 days before acting safer (top slider)? Is there a big difference? Then try 7 days."),
       p("How much safer do we have to act (how far do we need to move the second slider to the left) to offset a 3 day delay in acting safer?"),
       p("Try changing the key parameters of this fictitious disease ('givens') and see how that affects the answers above.")
    )
  )
))
