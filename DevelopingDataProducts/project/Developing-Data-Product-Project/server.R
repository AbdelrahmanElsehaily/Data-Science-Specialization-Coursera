  #
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(sp)
library(maps)
library(maptools)
library(leaflet)
library(countrycode)
library(plyr)
library(dplyr)
library(DT)
#user region,year,scaleof(life-expectency)
lifeExpectDF<-readRDS("lifeExpec")

shinyServer(function(input, output) {
  
  world <- map("world", fill=TRUE, plot=FALSE)
  world_map <- map2SpatialPolygons(world, sub(":.*$", "", world$names))
  countryCodes=countrycode(names(world_map), 'country.name',"iso3c")
  bins <- c( 20, 40,50, 60, 65, 70,75,80,Inf)
  pal <- colorBin("YlOrRd", domain = lifeExpectDF$lifeExpect,bins = bins)
  
  lifedata=lifeExpectDF[lifeExpectDF$year==2015,]
  world_data= world_map[!is.na(countryCodes)&(countryCodes%in%lifedata$iso3c),]
  filter_codes=data.frame("iso3c"=countryCodes[!is.na(countryCodes)&(countryCodes%in%lifedata$iso3c)])
  lifedata=join(filter_codes,lifedata)
  world_data <- SpatialPolygonsDataFrame(world_data,lifedata,FALSE)
  world_map2=world_data
  filteredData<-reactive({
    lifedata=lifeExpectDF%>%filter(as.integer(lifeExpec)>input$lifeSlider[1] & as.integer(lifeExpec)<input$lifeSlider[2])
    if (!is.null(input$year)){
        lifedata=lifedata%>%filter(year==input$year)
    }
    if (input$region!="All"){
      lifedata=lifedata%>%filter(region==input$region)
    }  
    world_data= world_map[!is.na(countryCodes)&(countryCodes%in%lifedata$iso3c),]
    filter_codes=data.frame("iso3c"=countryCodes[!is.na(countryCodes)&(countryCodes%in%lifedata$iso3c)])
    lifedata=join(filter_codes,lifedata)
    world_data <- SpatialPolygonsDataFrame(world_data,lifedata,FALSE)
    world_data
  })
  
  
  output$map<-renderLeaflet({
      leaflet(world_map2) %>% 
    addTiles() %>%addPolygons(fillColor = ~pal(lifeExpec),
                                    weight = 2,
                                    opacity = 1,
                                    color = "white",
                                    fillOpacity = 0.7,
                                    label = ~paste0(  "<strong>",country,"</strong><br/>" ,lifeExpec,"years") %>% lapply(htmltools::HTML),
                                    labelOptions = labelOptions(
                                      style = list("font-weight" = "normal"),
                                      textsize = "15px",
                                      direction = "auto"))%>%setView( -25,20, 2)
  })
  
  observe({
    
    
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addPolygons(fillColor = ~pal(lifeExpec),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  fillOpacity = 0.7,
                  label = ~paste0(  "<strong>",country,"</strong><br/>" ,lifeExpec,"years") %>% lapply(htmltools::HTML),
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal"),
                    textsize = "15px",
                    direction = "auto")
                  )
  })
  
  output$mytable = DT::renderDataTable(
    lifeExpectDF, options = list(
      pageLength = 20)
  )
  
  
})
