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

#plot 3
hh_powerc[, datetime := dmy_hms(paste(Date, Time, sep = " "))]

with(hh_powerc, plot(datetime, Sub_metering_1, ylab = "Energy sub metering",
                     type = "n"))
with(hh_powerc, plot(datetime, Sub_metering_1, xlab = "",
                     ylab = "Energy sub metering", type = "n"))
with(hh_powerc, points(datetime, as.numeric(Sub_metering_1), col = "black",
                       type = "l"))
with(hh_powerc, points(datetime, as.numeric(Sub_metering_2),col = "red",
                       type = "l"))
with(hh_powerc, points(datetime, as.numeric(Sub_metering_3),col = "blue",
                       type = "l"))
legend("topright", lty = 1, col = c("black", "red", "blue"), cex = 0.7,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, filename = "plot3.png", width = 480, height = 480)
dev.off()