# Parse FMI windspeed-time data, single location
fun_get_values <- function(x,n) {
  
  result <- matrix(NA, ncol = 2, nrow = n)
  
  # Iterate over the measurement time-series
  for(i in 1:n) {
    result[i,1] <- unlist(l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[i]$point$MeasurementTVP$time)
    result[i,2] <- unlist(l$FeatureCollection$member$PointTimeSeriesObservation$result$MeasurementTimeseries[i]$point$MeasurementTVP$value)
  }

  # Convert into data.table and set column names
  dt_result <- as.data.table(result)
  setnames(dt_result, c('TIME_OF_MEASURE', 'VALUE_OF_MEASURE'))

  # Define data type as POSIXct
  dt_result[, TIME_OF_MEASURE := as.POSIXct(TIME_OF_MEASURE, format = '%Y-%m-%dT%H:%M:%S')]
  
  return(dt_result)

}