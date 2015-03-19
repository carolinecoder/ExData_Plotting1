## Read file
data <- read.table("household_power_consumption.txt", header=T, sep=";")

## Clean data
## Convert Time to formal time data using strptime
data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S") 
head(data)

## Convert Date to formal date data using as.Date
data$Date <- as.Date(data$Date, "%d/%m/%Y") 
head(data)

## Select Feb 1-2, 2007 data
df <- data[ data$Date=="2007-02-01" | data$Date=="2007-02-02", ]

## Convert all non-date or -time variables to numeric
df[ , 3:9]<- sapply(df[ , 3:9], function (x) {
    as.numeric(as.character(x))
})

## Create Plot 3
## Adjust margins to make sure the x-axis label does not show
par(mar=c(2, 4, 2, 2))
## Create initial (properly-labeled) plot of Time as functon of Sub_metering_1 
## and then add in other 2 variables on same graph
with(df, plot(Time, Sub_metering_1, type="l", ylab="Energy sub metering", col="black")) 
lines(df$Time, df$Sub_metering_2, col="red")
lines(df$Time, df$Sub_metering_3, col="blue")
## Add a legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1),
       lwd=c(2, 2, 2),
       col=c("black", "red","blue")
       )

## Copy Plot 2 to PNG 
dev.copy(png, file = "plot3.png") 

## Close the PNG device
dev.off() 
