setwd("~/MyDigilife/Labs/Cousera/R/DataProducts/Project")
mydata <- read.csv("Closed_Pothole_Cases.csv")
mydata <- mydata[!is.na(mydata$LOCATION_ZIPCODE), ]
mydata$OPEN_DATE <- as.Date(mydata$OPEN_DT, "%m/%d/%Y")
mydata$CLOSED_DATE <- as.Date(mydata$CLOSED_DT, "%m/%d/%Y")

mydata1$CASE_OPEN <- mydata$CLOSED_DATE - mydata$OPEN_DATE


library(ggplot2)


potholes.per.zip <- aggregate(CASE_ENQUIRY_ID ~ LOCATION_ZIPCODE, data=mydata, FUN=length)
potholes.per.zip$LOCATION_ZIPCODE <- as.factor(potholes.per.zip$LOCATION_ZIPCODE)