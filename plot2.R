#plot2.R

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

png(file="plot2.png")
plot( gdata$datetime,gdata$Global_active_power, 
      type ="l", 
      ylab = "Global Active Power (kilowatts)", 
      xlab = NA)
dev.off()