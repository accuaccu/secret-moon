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
df_l <- as_tibble(l) %>%
  unnest_longer()
?unnest_longer
a <- xmlTreeParse(d)

dt_n <- data.table(date_time = 
                     c(
                       l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[1]$point$MeasurementTVP$time,
                       l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[2]$point$MeasurementTVP$time
                     ),
                   measure =
                     c(
                       l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[1]$point$MeasurementTVP$value,
                       l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[2]$point$MeasurementTVP$value
                     ))
l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[2]$point$MeasurementTVP$time


unnest_longer(l)
# Tuulen nopeus ja lampotila ajanhetkella jotain paikassa Raahe
str_url <- 'http://opendata.fmi.fi/wfs/fin?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&place=Raahe&parameters=ws_10min,t2m&'
d <- read_xml(x = str_url)
a <- xmlTreeParse(d)

l <- xml2::as_list(d)
l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries$point



b <- a$doc$children$FeatureCollection

v <- a$doc$children$FeatureCollection[[1]]


u <- v[[1]]
u[[5]]



df_d_a$PointTimeSeriesObservation

cat(df_d_a$PointTimeSeriesObservation)
xmlto

k <- xml2::read_xml(x = str_url)

l <- xml2::as_list(k)
l$FeatureCollection$member$PointTimeSeriesObservation$phenomenonTime$TimePeriod$beginPosition
l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries$point$MeasurementTVP$value
xml2::xml_contents(k)

xml_attr(k, attr = 'wml2:value')

