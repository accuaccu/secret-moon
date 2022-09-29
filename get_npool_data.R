# Get day-ahead market price from Nordpool
library(webshot)
library(tesseract)
library(rvest)

# Define VAR
url_npool <- 'https://www.nordpoolgroup.com/en/Market-data1/#/nordic/table'
str_today <- Sys.Date()
dir_temp_image <- './image_tmp'

# Get snapshot from URL with 5 second delay and zoom = 2 due to tesseract being unambigious otherwise
webshot(url_npool, file = paste0(dir_temp_image,'/npool.png'), delay = 5, selector = ".table-wrapper", zoom = 2)

# Extract text
str_text <- ocr(image = paste0(dir_temp_image,'/npool.png'))
cat(str_text, '\n')

# Tabulate