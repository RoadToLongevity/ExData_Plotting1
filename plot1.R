#### Code for reading in data ####

# required packages
library(lubridate)

# read in data
#if(!(exists("unzipped"))){
unzipped <- unzip("exdata-data-household_power_consumption.zip")
#}
#if(!(exists("power_consump_all"))){
power_consump_all <- read.table(unzipped, header = TRUE, sep = ";")
#}

# set date and time columns to have data type date with lubridate
power_consump_all$Date <- dmy(power_consump_all$Date)
power_consump_all$Time <- hms(power_consump_all$Time)

# subset data to rows with dates 2007-02-01 and 2007-02-02
power_consump <- power_consump_all[
  power_consump_all$Date == ymd("2007-02-01")
  | power_consump_all$Date == ymd("2007-02-02"),]


#### Code for plotting data ####

# set Global_active_power to numeric instead of factor
power_consump$Global_active_power <- as.numeric(levels(power_consump$Global_active_power))[
  power_consump$Global_active_power]

# plot histogram
hist(power_consump$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# copy graphic to png 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()