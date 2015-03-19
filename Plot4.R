## Read file
data <- read.table("household_power_consumption.txt", header=T, sep=";")

## Clean data
## Convert Time to formal time data using strptime
data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S") 

## Convert Date to formal date data using as.Date
data$Date <- as.Date(data$Date, "%d/%m/%Y") 

## Select Feb 1-2, 2007 data
df <- data[ data$Date=="2007-02-01" | data$Date=="2007-02-02", ]
head(df)

## Convert all non-date or -time variables to numeric
df[ , 3:9]<- sapply(df[ , 3:9], function (x) {
    as.numeric(as.character(x))
})

# Create Plots 1-4 in one frame view
## Create png file 
png("plot4.png")
## Set frame to fit 4 plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma = c(0, 0, 2, 0))
## Create plots
with(df, {  
    plot(Time, Global_active_power, type="l", ylab="Global Active Power", xlab="")
    plot(Time, Voltage, type="l", ylab="Voltage", xlab="datetime")
    plot(Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black")
    lines(df$Time, df$Sub_metering_2, col="red")
    lines(df$Time, df$Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty=c(1,1),
           lwd=c(1, 1, 1),
           col=c("black","red","blue"))
    plot(Time, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})
## Close connection to complete the png file
dev.off()
