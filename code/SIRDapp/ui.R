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
  p("Disclaimer: this simulation tutorial as parameterized does not reflect any known transmissible disease. It exists only to illustrate the potential impact of safe behavior (ie social distancing), and delay therof, on mortality count from a fictitious disease in a hypothetical population."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      checkboxInput("scaleflag",
                    "Auto-scale Y axis (scarier)",
                    value=FALSE),
      
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
                   value = 0.5),
      hr(),
      
      h3("Givens--factors out of our immediate control:"),

      numericInput("Npop",
                   "Total population size (>99)",
                   min = 100,
                   max = 1e10,
                   value = 1.5e6),
      
      sliderInput("I0",
                  "Initially infected (#)",
                  min=0,
                  max=100,
                  value = 10,
                  step = 1),
      
      sliderInput("xsi",
                  "Baseline infection transmission efficiency (1/day)",
                  min = 0,
                  max = 10,
                  value = 4.1,
                  step = .1),
      
      sliderInput("RR",
                  "recovery rate (1/day)",
                  min=0,
                  max=10,
                  value=2,
                  step=0.1), 
      
      sliderInput("d",
                  "Death rate among infected (1/day)",
                  min=0,
                  max=0.01,
                  value=0.0007,
                  step=0.0001),
      
      sliderInput("hsc",
                  "Healthcare system capacity (%pop)",
                  min=0,
                  max=0.1,
                  value = 0.026,
                  step=0.001),    
      
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
       p("------ Horizontal dashed line represents healthcare system capacity"),
       p("------ Vertical dashed line represents start of safer behavior"),
       h3("Scenarios to try:"),
       p("What happens to the death total if we wait 3 days before acting safer (top slider)? Is there a big difference? Then try 7 days."),
       p("How much safer do we have to act (how far do we need to move the second slider to the left) to offset a 3 day delay in acting safer?"),
       p("Try changing the key parameters of this fictitious disease ('givens') and see how that affects the answers above."),
       h3("Model assumptions:"),
       p("Square brackets [ ] denote a slider parameter value"),
       p("1a.Population is well-mixed: no randomness."),
       p("1b.There are 4 fractions of the initial population: Susceptible, Infected, Recovered, Deceased"),
       p("1c.Closed system: no births, no incoming infections, no deaths outside of disease."),
       p("2.Initially there are zero Recovered or Deceased individuals, [Initially Infected]*[Population Size] Infected, and the remainder are Susceptible."),
       p("3.Infections propagate at a rate = [baseline infection transmission efficiency] * fraction Infected * fraction Susceptible"),
       p("4.Infections last about [mean infection duration] days before the infected person either recovers or dies"),
       p("5.Recovered patients cannot be infected again"),
       p("6.Infected persons die at a rate = [death rate among infected]*Infected as long as [health system capacity] has not been exceeded."),
       p("7.Once [health system capacity] has been exceeded, the death rate for the 'excess' infected gets multiplied by the factor: [How much more likely...]"),
       p("8.After [Days to wait before acting safer] days have passed, social distancing commences and the effective transmission rate is now multiplied by the fraction:[Acting safer impact on disease transmission efficiency]")
    )
  )
))
