# Defining file path
dataFile <- "C:/Users/obevny/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt"

# Reading the data, treating "?" as NA
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings="?")

# Convert Date column to Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset data for the required dates
subSetData <- subset(data, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

# Combining Date and Time into a POSIXlt datetime object
datetime <- strptime(paste(subSetData$Date, subSetData$Time), format="%Y-%m-%d %H:%M:%S")

# Converting Global_active_power to numeric, handling NAs
globalActivePower <- as.numeric(subSetData$Global_active_power)

# Creating and saving the line plot
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

