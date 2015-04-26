#setwd("~/MyDigilife/Labs/Cousera/R/DataProducts/Project")
library(ggplot2)
library(leaflet)

library(shiny)
potholes <- read.csv("Closed_Pothole_Cases.csv")
#potholes <- potholes[!is.na(mydata$LOCATION_ZIPCODE), ]
potholes$OPEN_DATE <- as.Date(potholes$OPEN_DT, "%m/%d/%Y")
potholes$CLOSED_DATE <- as.Date(potholes$CLOSED_DT, "%m/%d/%Y")
potholes$CASE_OPEN <- potholes$CLOSED_DATE - potholes$OPEN_DATE

shinyServer(function(input, output, session) {
  
  # Create the map
  map <- createLeafletMap(session, "map")
  
  output$pothole.table <- renderDataTable({
    potholes
  })
  
  cases <- reactive({
    age <- input$age
    potholes[potholes$CASE_OPEN >= input$ageSlider[1] & potholes$CASE_OPEN <= input$ageSlider[2], ]    
  })

    output$reported.by <- renderPlot({
      aggr <- aggregate(CASE_ENQUIRY_ID ~ Source, data=cases(), FUN=length)
      par(las=2)
      par(mar=c(10,3,1,1))
      print(plot(aggr, ylab="Count", xlab=""))
    }) 
    
  # session$onFlushed is necessary to work around a bug in the Shiny/Leaflet
  # integration; without it, the addCircle commands arrive in the browser
  # before the map is created.
  session$onFlushed(once=TRUE, function() {
    # Clear existing circles before drawing
    map$clearShapes()
    paintObs <- observe({

      try(
        #map$addCircle(zips$LATITUDE, zips$LONGITUDE)
        map$addCircle(cases()$LATITUDE, cases()$LONGITUDE)
      )
    })
    session$onSessionEnded(paintObs$suspend)
  })
  
})