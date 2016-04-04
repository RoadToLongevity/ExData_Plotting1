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

# set sub metering 1 and 2 columns to numeric instead of factor
power_consump$Sub_metering_1 <- as.numeric(levels(power_consump$Sub_metering_1))[
  power_consump$Sub_metering_1]
power_consump$Sub_metering_2 <- as.numeric(levels(power_consump$Sub_metering_2))[
  power_consump$Sub_metering_2]

# create new column DateTime combining date and time
power_consump$DateTime <- power_consump$Date + power_consump$Time

# plot graph
with(power_consump, plot(DateTime, Sub_metering_1, type = "n",
                         ylab = "Energy Sub Metering"))
points(power_consump$DateTime, power_consump$Sub_metering_1, type = "l", col = "black")
points(power_consump$DateTime, power_consump$Sub_metering_2, type = "l", col = "red")
points(power_consump$DateTime, power_consump$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "___", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), inset = 0.05)

# copy graphic to png 
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()