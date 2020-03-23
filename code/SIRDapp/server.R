#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

source("SIRDfuns.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$SIRDPlot <- renderPlot({
    
  SIRDsim(popsize=input$Npop,phixsi=input$phixsi,txsi=input$txsi,xsi=input$xsi,hsc=input$hsc/100,I0=input$I0/input$Npop,d=input$d,kr=input$RR,phid=input$phid,autoscale=input$scaleflag,logscale=input$logscale)
    
  })
  
})
