## Plot 1 of Week 1 Project 1

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

## Plot histogram on global active power variable
hist(subData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## save plot to png file with height and width of 480 pixels
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

