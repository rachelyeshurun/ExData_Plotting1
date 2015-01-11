#Course Project 1 for Exploratory Data Analysis (by Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD)
#This script creates a graphic in a png file
#Recrete Plot 4

library(data.table)
library(lubridate)

#First download and unzip files
if (!file.exists("./dataset.zip")) {
  dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(dataset_url, "dataset.zip")
  unzip("dataset.zip", exdir = "data")
}

dataFile = "./data/household_power_consumption.txt"

#We will only be using data from the dates 2007-02-01 and 2007-02-02
#So pull out only the lines from those 2 days in February.
# 2 days is 2*24*60 minutes = 2880 minutes. Or use this generic way:
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
#NAs are coded as '?'
dataSet <- fread(dataFile, skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))

#Now get the header row and set the column names
setnames(dataSet, colnames(fread(dataFile, nrows=0)))

#DT$DateTime <- as.POSIXct(paste(dataSet$V1, dataSet$V2), format="%d/%m/%Y %H:%M:%S")

#create a new column with the date and time combined - using lubridate
dataSet$Date_Time <- dmy_hms(paste(dataSet$Date, dataSet$Time))

#open the png device
png(file="plot4.png",width=480,height=480)

#Draw the plots down two columns (first left column, then the right)
par(mfcol=c(2,2))

#top left plot (same as plot 2)
plot(dataSet$Date_Time, dataSet$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="")
#bottom left plot (same as plot 3)
plot(dataSet$Date_Time, dataSet$Sub_metering_1, type="n", ylab="", xlab="")
points(dataSet$Date_Time, dataSet$Sub_metering_1, type="l", col="black")
points(dataSet$Date_Time, dataSet$Sub_metering_2, type="l", col="red")
points(dataSet$Date_Time, dataSet$Sub_metering_3, type="l", col="blue")
title(ylab = "Energy sub metering")
legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#top right plot
plot(dataSet$Date_Time, dataSet$Voltage, type="l", ylab = "Voltage", xlab="datetime")
#bottom right plot
plot(dataSet$Date_Time, dataSet$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab="datetime")
#shut the png device..
dev.off()


