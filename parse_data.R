library(data.table)
library(rvest)
library(tidyverse)
library(xml2)
library(ows4R)
library(XML)
# https://www.ilmatieteenlaitos.fi/latauspalvelun-pikaohje
# https://www.ilmatieteenlaitos.fi/kysymyksia-avoimesta-datasta



str_url_fmi <- 'https://opendata.fmi.fi/wfs?request=GetCapabilities&'
str_url_fmi <- 'http://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::forecast::hirlam::surface::point::multipointcoverage&place=helsinki&'
str_url_fmi <- 'http://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&place=Helsinki&parameters=ws_10min,t2m&starttime=2022-09-23T10:00:00Z&endtime=2022-09-23T14:00:00Z&'
# https://urbandatapalette.com/post/2021-03-xml-dataframe-r/
d <- read_xml(x = str_url_fmi)
l <- as_list(d)
View(l)

fun_get_values <- function(x,n) {
  result <- matrix(NA, ncol = 2, nrow = n)
  
  for(i in 1:n) {
    result[i,1] <- unlist(l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[i]$point$MeasurementTVP$time)
    result[i,2] <- unlist(l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[i]$point$MeasurementTVP$value)
  }
  dt_result <- as.data.table(result)
  setnames(dt_result, c('TIME_OF_MEASURE', 'VALUE_OF_MEASURE'))
  #dt_result[, TIME_OF_MEASURE := as.Date(TIME_OF_MEASURE)]
  return(dt_result)
}

dt_data <- fun_get_values(l, 25)
