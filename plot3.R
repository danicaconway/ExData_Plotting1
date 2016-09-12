## Danica Conway
## 9/11/2016
## Project 1, plot #3 code for Exploratory Data Analysis course on Coursera.com

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

## convert sub-metering columns from factor to numeric
power_subset$Sub_metering_1<-as.numeric(paste(power_subset$Sub_metering_1))
power_subset$Sub_metering_2<-as.numeric(paste(power_subset$Sub_metering_2))
power_subset$Sub_metering_3<-as.numeric(paste(power_subset$Sub_metering_3))

## merge date and time into one column
power_subset$NewDate<-with(power_subset, as.POSIXct(paste(Date,Time),formmat="%Y-%m-%d-%H:%M:%S")) 

## start the png file, specifying size in pixels
png(filename="plot3.png", width=480, height=480, units="px")

plot(power_subset$Sub_metering_1~power_subset$NewDate,col="black",type="l",xlab="",ylab="Energy sub metering")
lines(power_subset$Sub_metering_2~power_subset$NewDate, col="red")
lines(power_subset$Sub_metering_3~power_subset$NewDate, col="blue")

## add the legend box
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

dev.off()
 
 