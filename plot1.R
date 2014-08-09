#==========================================================================
#
# Exploratory Data Analysis
# Month 4 of Coursera series on Data Science
#
# Week 1 project (peer assessment)
#
# Plot 1 : Histogram of global active power
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
#==========================================================================

#==========================================================================
# Plot 1 : Histogram of global active power
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
#
# To be very thorough, the following regular expression will extract
# only those date strings such that:
#
#   grepl("^0*[12]{1}/0*2/2007",tempdf$Date)
#
#   Start of string, optional '0', one of either '1' or '2',
#   slash, optional '0', '2', slash, '2007'
#
# Alternatively, you can convert the date strings into date objects (below).
# Then check the number of matching entries against what you found.
#
#   temp.df$Date <- as.Date( temp.df$Date, "%d/%m/%Y" )
#   sum( temp.df$Date >= "2007-02-01" & temp.df$Date <= "2007-02-02" )
#

classes = c(rep("character",2), rep("numeric",7))

temp.df <- read.table(filename, sep=";", colClasses=classes, header=TRUE, na.strings="?" )

df <- subset( temp.df, (Date == "1/2/2007" | Date == "2/2/2007"))
rm(temp.df)

#--------------------------------------------------------------------------
#
# Rather than reading all data and then subsetting to discard all dates
# except 2007-02-01 and 2007-02-02, you can instead filter the data while
# reading it.  Someone on the discussion forum suggested using the
# read.csv.sql() function in the 'sqldf' library.

# library(sqldf)   # contains read.csv.sql()
# 
# # read file and select rows with string ("2/1/2007" OR "2/2/2007")
# sql.string = 'select * from file where (Date = "2/1/2007" OR Date = "2/2/2007")'
# df <- read.csv.sql(filename, sep=";", colClasses = classes, header=TRUE, sql = sql.string)
# 
# # Note: read.csv.sql() does not support na.strings.

#--------------------------------------------------------------------------
# 2. Plot the data
#--------------------------------------------------------------------------

outfilename = "plot1.png"
title = "Global Active Power"
xlabel = "Global Active Power (kilowatts)"

# Send output to PNG image
png( filename = outfilename, width = 480, height = 480 )

hist( df$Global_active_power, xlab = xlabel, main = title, col = "red" )

dev.off()  # close the file
