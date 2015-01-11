
#Course Project 1 for Exploratory Data Analysis (by Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD)
#This script creates a graphic in a png file
#Recreate Plot 1

library(data.table)

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

#open the png device
png(file="plot1.png",width=480,height=480)
#we only are drawing one plot
par(mfrow=c(1,1))
#To see frequency of Global active power values, draw a histogram
hist(dataSet$Global_active_power, xlab = "Global Active Power (kilowatts)" ,main = "Global Active Power", col="red")
#shut the png device..
dev.off()

