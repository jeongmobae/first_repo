fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip")

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.string="?", colClasses=c(rep("character", 2), rep("numeric", 7)))    
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

data1 <- subset(data, data$Date == "2007-02-01")
data2 <- subset(data, data$Date == "2007-02-02")
mergedData <- rbind(data1, data2)

png(file="plot1.png", width=480, height=480)
with(mergedData, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power"))
dev.off()