library(data.table)
library(rvest)
library(tidyverse)
library(xml2)
library(ows4R)
library(XML)
# https://www.ilmatieteenlaitos.fi/latauspalvelun-pikaohje
# https://www.ilmatieteenlaitos.fi/kysymyksia-avoimesta-datasta

source('./utility-fun/fun_parse_ws.R')



str_url_fmi <- 'https://opendata.fmi.fi/wfs?request=GetCapabilities&'
str_url_fmi <- 'http://opendata.fmi.fi/wfs/fin?service=WFS&version=2.0.0&request=GetFeature&storedquery_id=fmi::observations::weather::timevaluepair&place=Raahe&'
str_url_fmi <- 'http://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::forecast::hirlam::surface::point::multipointcoverage&place=helsinki&'
str_url_fmi <- 'http://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&place=Helsinki&parameters=ws_10min,t2m&starttime=2022-09-23T10:00:00Z&endtime=2022-09-29T10:00:00Z&'

fun_query <- function(parameter, start_date, end_date, time_step) {
    
}


# Wind
str_url_fmi_wind <- 'http://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&place=Helsinki&parameters=windspeedms&timestep=10&starttime=2022-10-10T10:00:00Z&endtime=2022-10-10T10:20:00Z&'
# Temperature
str_url_fmi_temp <- 'http://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&place=Helsinki&parameters=temperature&timestep=10&starttime=2022-10-10T10:00:00Z&endtime=2022-10-10T10:20:00Z&'
# https://urbandatapalette.com/post/2021-03-xml-dataframe-r/
dt_data <- fun_get_values(str_url_fmi_temp, 3)

cbind(
    fun_get_values(str_url_fmi_wind, 3),
    fun_get_values(str_url_fmi_temp, 3)
)

xml_tree <- read_xml(str_url_fmi_temp)
l_tree <- as_list(xml_tree)
View(l_tree)
