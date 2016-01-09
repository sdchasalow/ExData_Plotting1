# Scott D Chasalow
# 07 Jan 2016

# Coursera Data Sciences Specialization, Course 4: Exploratory Data Analysis

# Week 1 project: plot 1

# Data are here, in a zipped ";"-delimited tabular (plain-text) format
# "ExData_Plotting1\\exdata-data-household_power_consumption.zip"

subdir <- "ExData_Plotting1"

###
#############################################################################
#  Read in data from zip file.
#############################################################################
###

# This works, but generates a warning about "closing unused connection".
if (FALSE) {
   data <- read.table( unz(
      file.path(subdir, "exdata-data-household_power_consumption.zip"),
      "household_power_consumption.txt"
      ), sep = ";" )
}

# This avoids the warning message:
con <- unz( file.path(subdir, "exdata-data-household_power_consumption.zip"),
   "household_power_consumption.txt" )
open(con)
data <- read.table( con, sep = ";", header = TRUE, stringsAsFactors = FALSE,
   na.strings = "?" )
close(con)
remove( list = "con" )

###
#############################################################################
#  Convert Date and Time columns to Date and POSIXlt classes, respectively.
#############################################################################
###

data$Time <- paste( data$Date, data$Time )
data$Time <- strptime( data$Time, format = "%d/%m/%Y %H:%M:%S" )

data$Date <- as.Date( data$Date, format = "%d/%m/%Y" )

###
#############################################################################
#  Create dataframe subset with data for only 2007-02-01 and 2007-02-02.
#############################################################################
###

sdata <- subset( data, Date == "2007-02-01" | Date == "2007-02-02" )

###
#############################################################################
#  Create plot 1.
#############################################################################
###

png( file.path(subdir, "plot1.png"), width = 480, height = 480 )

hist( sdata$Global_active_power, col = "red",
   xlab = "Global Active Power (kilowatts)", main = "Global Active Power" )

dev.off()

