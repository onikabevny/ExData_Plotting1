# Define file path
dataFile <- "C:/Users/obevny/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt"

# Reading the data, treating "?" as NA
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings="?")

# Converting Date column to Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset data for the required dates
subSetData <- subset(data, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

# Converting Global_active_power to numeric
globalActivePower <- as.numeric(subSetData$Global_active_power)

# Crreating and saving histogram
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", breaks=50)

