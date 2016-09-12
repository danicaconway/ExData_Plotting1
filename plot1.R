## Danica Conway
## 9/11/2016
## Project 1, Graph 1, for Exploratory Data Analysis course on Coursera.com

## load the required libraries 
library(data.table)

## download the data zip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, mode="wb")

## unzip the file
unzip(temp, "household_power_consumption.txt")
unlink(temp)

## read the data in
power_consumption <- read.table("household_power_consumption.txt", sep=";", header=T)

## convert the Date column to datatype = date
power_consumption[,1]<-as.Date(power_consumption[,1], "%d/%m/%Y")

## subset the data to only include Feb 1 and 2 of 2007
power_subset<-subset(power_consumption, Date %between% c("2007-02-01", "2007-02-02"))

 ## convert Global_active_power column from factor to numeric
power_subset$Global_active_power<-as.numeric(paste(power_subset$Global_active_power))

## start the png file, specifying size in pixels
png(filename="plot1.png", width=480, height=480, units="px")

## plot the histogram
hist(power_subset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",
ylab="Frequency",main="Global Active Power")
dev.off()