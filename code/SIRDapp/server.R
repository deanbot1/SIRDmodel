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
    
  SIRDsim(phixsi=input$phixsi,txsi=input$txsi,xsi=input$xsi,hsc=input$hsc/100,I0=input$I0/100,d=input$d,MTT=input$MTT,phid=input$phid,autoscale=input$scaleflag)
    
  })
  
})
