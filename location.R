#install.packages("XML")
#install.packages("RCurl")
library(plyr)
library(XML)
library(RCurl)
library(rjson)
doc = xmlInternalTreeParse("history-03-06-2014.kml")
gxcode <- getNodeSet(doc,"//gx:coord")

longitude <-c()
latitude <-c()
altitude <- c()
for(i in 1:length(gxcode)){
  tmp <- strsplit(toString.XMLNode(gxcode[[i]]),"<gx:coord>")
  tmp <- strsplit(tmp[[1]][2],"</gx:coord>")
  geoData <- tmp[[1]][1]
  geoData <- strsplit(geoData," ")
  longitude <- c(longitude,geoData[[1]][1])
  latitude <- c(latitude,geoData[[1]][2])
  altitude <- c(altitude,geoData[[1]][3])
}
longitude <- sprintf("%.9f",as.numeric(longitude))
latitude <- sprintf("%.9f",as.numeric(latitude))
geoData <- data.frame(longitude,latitude,altitude)
write.table(geoData,"geoData.csv",sep=",")

#APIの利用制限に引っかかった
# dtail <- c()
# city <- c()
# for(i in 1:length(geoData$latitude)){
#   url <- paste("http://maps.googleapis.com/maps/api/geocode/json?latlng=",geoData$latitude[i],",",geoData$longitude[i],"&sensor=false",sep="")
#   mapd <- fromJSON(paste(readLines(url), collapse=""))
#   dtail <- c(dtail,mapd$results[[2]]$address_components[[3]]$long_name)
#   city <- c(city, mapd$results[[8]]$address_components[[1]]$long_name)
# }






longitude
sprintf("%.9f",as.numeric(longitude))
sprintf("%.9f",as.numeric(latitude))
