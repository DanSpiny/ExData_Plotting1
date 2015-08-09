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

#plot 4
hh_powerc[, datetime := dmy_hms(paste(Date, Time, sep = " "))]

old_par <- par(mfrow = c(2,2))

with(hh_powerc, {
    plot(datetime, as.numeric(Global_active_power), xlab = "",
         ylab = "Global Active Power", type = "l")
    plot(datetime, as.numeric(Voltage), ylab = "Voltage", type = "l")
    plot(datetime, Sub_metering_1, ylab = "Energy sub metering", type = "n")
    points(datetime, as.numeric(Sub_metering_1), col = "black", type = "l")
    points(datetime, as.numeric(Sub_metering_2),col = "red", type = "l")
    points(datetime, as.numeric(Sub_metering_3),col = "blue", type = "l")
    legend("topright", lty = 1, col = c("black", "red", "blue"), cex = 0.5,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(datetime, as.numeric(Global_reactive_power), type = "l",
         ylab = "Global_reactive_power")
}
)
dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()

par(old_par)