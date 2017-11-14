#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(DT)
lifeExpectDF<-readRDS("lifeExpec")

# Define UI for application that draws a histogram
shinyUI(
  bootstrapPage(
    navbarPage("Life Expectency",
      tabPanel("Map",
        leafletOutput("map", width = "100%", height = 900),
        absolutePanel(top = 90, right = 30,
           selectInput("year",choices  = sort(lifeExpectDF$year,decreasing = TRUE),label = "year"),
           selectInput("region",choices  = c("All",unique(as.character(lifeExpectDF$region))[3:length(unique(as.character(lifeExpectDF$region)))]),selected =NULL,label = "Region",selectize = TRUE),
           sliderInput(inputId="lifeSlider",label = "Life Expectency",min = as.integer(min(lifeExpectDF$lifeExpec,na.rm = TRUE)),
            max = as.integer(max(lifeExpectDF$lifeExpec,na.rm = TRUE)),value = as.integer(range(lifeExpectDF$lifeExpec,na.rm = TRUE))))
        ),
      tabPanel("Data",br(),  DT::dataTableOutput("mytable")),
      tabPanel("Documentation",
        fluidPage( 
          mainPanel(
        div(h3("About"),"This is jsut a simple app for plotting life expectency depending on the year selected, you can also specify the region and the range of interest.")
        ,div(h3("Data"),"Data is downloaded from world bank using the 'WDI' package, it conatins the life expetency from year 1960 to 2015 for most countries all over the world.")
        ,div(h3("How to use it"),"Just select any year and the map will show up(it might take longer time if you didn't select the region).")
        )
      )
      )      
  ))
)

  