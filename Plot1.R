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

## Create Plot 1
## Include a title, relabel the x-axis, and set color of histogram to red,
hist(df$Global_active_power, main= "Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")

## Copy Plot 1 to PNG 
dev.copy(png, file = "plot1.png") 

## Close the PNG device
dev.off() 


