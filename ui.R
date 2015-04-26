library(shiny)
library(leaflet)

shinyUI(

  navbarPage("Boston potholes",
             tabPanel("Map",
                      mainPanel(
                        h4("Select a range (in days) of pothole fix request being open."),
                        sliderInput("ageSlider", "Case age:", min=0, max=1113, value=c(50,500)),
                        leafletMap(
                          "map", "100%", 500,
                          initialTileLayer = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                          initialTileLayerAttribution = HTML('Maps by <a href="http://www.mapbox.com/">Mapbox</a>'),
                          options=list(
                            center = c(42.3580,  -71.1213),
                            zoom = 11 ,
                            maxBounds = list(list(17, -180), list(59, 180))
                          )
                        ),
                        
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 100, left = "auto", right = 20, bottom = "auto",
                                      width = 300, height = "auto",
                                      h4('Cases for the potholes on the map were submitted by:'),
                                      plotOutput("reported.by")  
                        )
                      )
                    ),
             tabPanel("Data",
                        mainPanel(
                          h4('Boston closed potholes data'),
                          dataTableOutput('pothole.table')
                        )
             ),
             tabPanel(HTML("Help</a></li><li><a target=\"_blank\" href=\"http://xande.github.io/BostonPotholesSlides/#1\">Slides"),
                      mainPanel(
                        h4('Boston closed potholes data application'),
                        p('Boston city data portal (https://data.cityofboston.gov/) contains a big set of municipal data available for everyone to explore.'),
                        p('The purpose of this project is to explore Closed Pothole Data(https://data.cityofboston.gov/City-Services/Closed-Pothole-Cases/wivc-syw7). I wanted to see, where the most of potholes
                           were located. As this is a set of closed cases, the slider allows to filter pothole markers(cases)
                           by the "lifetime" (in days). '),
                        p('There are few ways to open pothole case, thus I also wanted to chart which tools where
                          used to open the cases displayed on the map.'),
                        p('"Data" tab allows to browse raw pothole cases data.')
                        
                      )
             )
  )
)