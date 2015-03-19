## Read file
data <- read.table("household_power_consumption.txt", header=T, sep=";")
head(data)

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

## Plot 2
## Change margins t get rid of x-axis label
par(mar=c(2, 4, 2, 2))
## Create plot of Global Active Power as a function of Time
## Set type to "l" to connect points with a line, and relabel y-axis
with(df, plot(Time, Global_active_power, type="l", ylab="Global Active Power")) 

## Copy Plot 2 to PNG 
dev.copy(png, file = "plot2.png") 

## Close the PNG device
dev.off() 


