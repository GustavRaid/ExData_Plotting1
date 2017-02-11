#plot4.R


# Exploratory Data Analysis
# Peer-graded Assignment: Course Project 1


#setwd("C:/Users/Adam/Downloads")

# Download the file

file1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipf <- "household_power_consumption.zip"
download.file(file1, method = "wininet", destfile = zipf)
# read the file, identifying the NAs
unzip(zipfile = zipf)
txtf <- "household_power_consumption.txt"
df <- read.csv2(txtf, na.strings = "?", stringsAsFactors = FALSE)
# get rid of unnecessary rows to shrink the memory footprint
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007",]
gdata <- data.frame(datetime=as.POSIXct(paste(df$Date,df$Time), format = "%d/%m/%Y %T"), 
                    Global_active_power=as.numeric(df$Global_active_power), 
                    Global_reactive_power=as.numeric(df$Global_reactive_power),
                    Voltage = as.numeric(df$Voltage),
                    Global_intensity=as.numeric(df$Global_intensity),
                    Sub_metering_1=as.numeric(df$Sub_metering_1),
                    Sub_metering_2=as.numeric(df$Sub_metering_2),
                    Sub_metering_3=as.numeric(df$Sub_metering_3),
                    stringsAsFactors = FALSE)

png(file="plot4.png") 
par(mfrow=c(2,2))

plot( gdata$datetime,gdata$Global_active_power, 
      type ="l", 
      ylab = "Global Active Power (kilowatts)", 
      xlab = NA)

with(gdata, plot(datetime,Voltage, type = "l"))

plot(gdata$datetime,gdata$Sub_metering_1, 
     type = "n", xlab = NA,
     ylab = "Energy sub metering")

points(gdata$datetime,gdata$Sub_metering_1, type="l")
points(gdata$datetime,gdata$Sub_metering_2, type="l", col="red")
points(gdata$datetime,gdata$Sub_metering_3, type="l", col="blue")

legend("topright", legend=names(gdata)[6:8], col= c("black","red","blue"),
       lwd = 1, bty = "n")

with(gdata, plot(datetime, Global_reactive_power, type = "l"))
dev.off()