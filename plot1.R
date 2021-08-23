# Plot 1 

# Getting & Cleaning
  # Getting
if(!file.exists("data.zip")){
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "data.zip", method="auto")
unzip("data.zip")}
data <- read.csv("household_power_consumption.txt", sep=";")

  # Making Date class "Date" with lubridate
library(lubridate)
data$Date <- dmy(data$Date)

  # Isolating necessary dates 2007-02-01 and 2007-02-02
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

  # Making Time class "POSIX"
data$Time <- strptime(data$Time, format="%H:%M:%S")
data[1:1440,"Time"] <- format(data[1:1440,"Time"], "2007-02-01 %H:%M:%S")
data[1441:2880,"Time"] <- format(data[1441:2880,"Time"], "2007-02-02 %H:%M:%S")

  # Reassigning classes
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Plotting
png(filename = "plot1.png")
hist(data$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
