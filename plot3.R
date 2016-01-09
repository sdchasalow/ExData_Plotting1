# Scott D Chasalow
# 08 Jan 2016

# Coursera Data Sciences Specialization, Course 4: Exploratory Data Analysis

# Week 1 project: plot 3

# Data are here, in a zipped ";"-delimited tabular (plain-text) format
# "ExData_Plotting1\\exdata-data-household_power_consumption.zip"

subdir <- "ExData_Plotting1"

###
#############################################################################
#  Read in data from zip file if necessary.
#############################################################################
###

if ( !exists("sdata", where = 1) ) {

   con <- unz( file.path(subdir, "exdata-data-household_power_consumption.zip"),
      "household_power_consumption.txt" )
   open(con)
   data <- read.table( con, sep = ";", header = TRUE, stringsAsFactors = FALSE,
      na.strings = "?" )
   close(con)
   remove( list = "con" )

   data$Time <- paste( data$Date, data$Time )
   data$Time <- strptime( data$Time, format = "%d/%m/%Y %H:%M:%S" )

   data$Date <- as.Date( data$Date, format = "%d/%m/%Y" )

   sdata <- subset( data, Date == "2007-02-01" | Date == "2007-02-02" )

}

###
#############################################################################
#  Create plot 3.
#############################################################################
###

png( file.path(subdir, "plot3.png"), width = 480, height = 480 )

with( sdata[ order(sdata$Time), ], {
   plot( range(Time),
      range(Sub_metering_1, Sub_metering_2, Sub_metering_3, na.rm = TRUE),
      xlab = "", ylab = "Energy sub metering", type = "n" )
   lines( Time, Sub_metering_1, col = "black" )
   lines( Time, Sub_metering_2, col = "red" )
   lines( Time, Sub_metering_3, col = "blue" )
   legend( x = "topright", lty = 1, col = c("black", "red", "blue"),
      legend = paste("Sub_metering", 1:3, sep = "_") )
   } )

dev.off()

