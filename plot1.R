library(downloader) #  wrapper for download.file() in order to avoid possible issues with https
library(data.table) #  data.table to deal with large data sets more effectivly
library(lubridate)  #  simplificator for date-time operations

if (!file.exists("data")) {
    dir.create("data")
}

download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
         "data/household_power_consumption.zip", mode = "wb")
unzip("data/household_power_consumption.zip", exdir = "data")

list.files("data")

hh_powerc <- fread("data/household_power_consumption.txt", head = TRUE, na.strings = "?",
                   colClasses = "character")

hh_powerc <- hh_powerc[hh_powerc$Dat %in% c("1/2/2007", "2/2/2007"),]

#plot 1
hist(as.numeric(hh_powerc$Global_active_power), col = "red", main ="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
dev.off()