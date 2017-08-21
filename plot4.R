## Plot 4 of Week 1 Project 1

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power_consumption.zip")
unzip("power_consumption.zip", exdir = ".")

## Load data into R
powerData <- read.table("household_power_consumption.txt", header = TRUE , sep = ";", stringsAsFactors = FALSE, na.strings = "?", dec = ".")
View(powerData)
lapply(powerData, class)

## Convert the date variable to dat class
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")
lapply(powerData, class)

## Subset data to include only data we need (2/1/07 - 2/2/07)
subData <- subset(powerData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
View(subData)

## Create new variable to store the Date & Time variables as Date/Time class
datetime <- paste(as.Date(subData$Date), subData$Time)
subData$datetime <- as.POSIXct(datetime)
View(subData)
lapply(subData, class)

## Set up plot window with par command to show 4 graphs in 2X2 format. 
par(mfrow = c(2,2), mar = c(5,4,2,1))

# Plot line graph showing relationship between Global Active Power and time.
plot(Global_active_power ~ datetime, data = subData, type = "l", ylab = "Global Active Power", xlab = "")

# Plot line chart showing relationship between Voltage and time.
plot(Voltage ~ datetime, data = subData, type = "l", ylab = "Voltage", xlab = "datetime")

## Plot line graph showing all three sub metering variables on the same graph, color code the lines, and include a legend.
plot(Sub_metering_1 ~ datetime, data = subData, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, data = subData, type = "l", col = "red")
lines(Sub_metering_3 ~ datetime, data = subData, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot line graph showing relationship between Global Reactive Power and time.
plot(Global_reactive_power ~ datetime, data = subData, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

## save plot to png file with height and width of 480 pixels
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()



