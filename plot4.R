# Defining file path
dataFile <- "C:/Users/obevny/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt"

# Reading the data, treating "?" as NA
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings="?")

# Convert Date column to Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset data for the required dates
subSetData <- subset(data, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

# Convert Date-Time format correctly
subSetData$Datetime <- as.POSIXct(paste(subSetData$Date, subSetData$Time), format="%Y-%m-%d %H:%M:%S")

# Convert necessary columns to numeric, handling NAs
subSetData$Global_active_power <- as.numeric(subSetData$Global_active_power)
subSetData$Global_reactive_power <- as.numeric(subSetData$Global_reactive_power)
subSetData$Voltage <- as.numeric(subSetData$Voltage)
subSetData$Sub_metering_1 <- as.numeric(subSetData$Sub_metering_1)
subSetData$Sub_metering_2 <- as.numeric(subSetData$Sub_metering_2)
subSetData$Sub_metering_3 <- as.numeric(subSetData$Sub_metering_3)

# Create 2x2 plotting layout
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) 

with(subSetData, {
  # Plot 1: Global Active Power
  plot(Datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  
  # Plot 2: Voltage
  plot(Datetime, Voltage, type="l", ylab="Voltage (volt)", xlab="")
  
  # Plot 3: Energy Submetering
  plot(Datetime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
  lines(Datetime, Sub_metering_2, col="red")
  lines(Datetime, Sub_metering_3, col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # Plot 4: Global Reactive Power
  plot(Datetime, Global_reactive_power, type="l", ylab="Global Reactive Power (kilowatts)", xlab="")
})

dev.off()
