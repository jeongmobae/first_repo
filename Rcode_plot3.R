fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip")

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.string="?", colClasses=c(rep("character", 2), rep("numeric", 7)))    
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

data1 <- subset(data, data$Date == "2007-02-01")
data2 <- subset(data, data$Date == "2007-02-02")
mergedData <- rbind(data1, data2)

png(file="plot3.png", width=480, height=480)
with(mergedData, {
    plot(DateTime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
})
dev.off()