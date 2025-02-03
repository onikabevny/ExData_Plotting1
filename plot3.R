# Defining the file path
dataFile <- "C:/Users/obevny/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt"

# Reading the data, treating "?" as NA
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings="?")

# Convert Date column to Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset data for the required dates
subSetData <- subset(data, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

# Combine Date and Time into a POSIXlt datetime object
datetime <- strptime(paste(subSetData$Date, subSetData$Time), format="%Y-%m-%d %H:%M:%S")

# Convert necessary columns to numeric, handling NAs
globalActivePower <- as.numeric(subSetData$Global_active_power)
subMetering1 <- as.numeric(subSetData$Sub_metering_1)
subMetering2 <- as.numeric(subSetData$Sub_metering_2)
subMetering3 <- as.numeric(subSetData$Sub_metering_3)

# Create and save the line plot
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
