#==========================================================================
#
# Exploratory Data Analysis
# Month 4 of Coursera series on Data Science
#
# Week 1 project (peer assessment)
#
# Plot 3 : Plot day/time versus energy sub metering
#
#--------------------------------------------------------------------------
#
# Input data:
#
# Electric power consumption data (below) obtained from UC Irvine Machine
# Learning Repository.
#
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# ...which unzips to one text file, "household_power_consumption.txt".
#
#--------------------------------------------------------------------------
#
# Discard all data except for the dates 2007-02-01 and 2007-02-01.
#
# There are multiple solutions (below).  I chose the first.
#
#   1. Since there are only two dates, you can simply look for two matching
#      strings (1/2/2007 and 2/2/2007).  In this case, you must inspect
#      the data file to see that there are no leading zeroes for the day
#      or month.
#
#   2. Use a regular expression with grep:  "^0*[12]{1}/0*2/2007"
#      This will include optional leading zeroes.
#
#   3. Convert the date strings to date objects, as suggested in the
#      assignment.  This would be most convenient if you needed to compare
#      more complex ranges of dates.
#
#   4. Use read.csv.sql() in the 'sqldf' package.  This allows you to
#      filter the data while reading it, rather than subsetting afterward.
#
# Please refer to 'plot1.R' for R source code to show the alternate
# methods described above.
#
#==========================================================================

#==========================================================================
# Plot 3 : Plot day/time versus energy sub metering
#==========================================================================

#--------------------------------------------------------------------------
# 1. Read the data
#--------------------------------------------------------------------------

filename <- "household_power_consumption.txt"

#--------------------------------------------------------------------------

# Based on the data description (and inspection of the data):
#
# Column 1 = Date (character string)
# Column 2 = Time (character string)
# Columns 3 to 9 = numeric data
#
# The 1st row of data contains the column headers.
# The semicolon (';') character separates the data items.
#
# "We will only be using data from the dates 2007-02-01 and 2007-02-02."
#
# The simplest approach is to read all data and then discard everything except
# for the dates 2007-02-01 and 2007-02-01.
#
# Please refer to plot1.R for information on alterative methods.
#

classes = c(rep("character",2), rep("numeric",7))

temp.df <- read.table(filename, sep=";", colClasses=classes, header=TRUE, na.strings="?" )

df <- subset( temp.df, (Date == "1/2/2007" | Date == "2/2/2007"))
rm(temp.df)

#--------------------------------------------------------------------------
# 2. Combine date and time
#--------------------------------------------------------------------------

# install.packages("lubridate")
library(lubridate)  # works with any standard date format
time <- dmy_hms( paste(df$Date, df$Time) )

#--------------------------------------------------------------------------
# 3. Plot the data
#--------------------------------------------------------------------------

outfilename = "plot3.png"
title = ""
xlabel = ""
ylabel = "Energy sub metering"

# Send output to PNG image
png( filename = outfilename, width = 480, height = 480 )

var1 <- "Sub_metering_1"
var2 <- "Sub_metering_2"
var3 <- "Sub_metering_3"
plot( time, df[,var1], type = "l", xlab = xlabel, ylab = ylabel, col = "black" )
points( time, df[,var2], type = "l", col = "red" )
points( time, df[,var3], type = "l", col = "blue" )
legend( "topright", col = c("black", "red", "blue"), legend = c(var1, var2, var3), lty = 1 )

dev.off()  # close the file
