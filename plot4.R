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

# set sub metering 1 and 2 columns to numeric instead of factor
power_consump$Sub_metering_1 <- as.numeric(levels(power_consump$Sub_metering_1))[
  power_consump$Sub_metering_1]
power_consump$Sub_metering_2 <- as.numeric(levels(power_consump$Sub_metering_2))[
  power_consump$Sub_metering_2]

# set Voltage to numeric instead of factor
power_consump$Voltage <- as.numeric(levels(power_consump$Voltage))[
  power_consump$Voltage]

# set Global_reactive_power to numeric instead of factor
power_consump$Global_reactive_power <- as.numeric(levels(power_consump$Global_reactive_power))[
  power_consump$Global_reactive_power]

# create new column DateTime combining date and time
power_consump$DateTime <- power_consump$Date + power_consump$Time


# plot 4 graphs
par(mfrow = c(2, 2))

# graph 1
with(power_consump, plot(DateTime, Global_active_power, type = "l",
                         ylab = "Global Active Power"))

# graph 2
with(power_consump, plot(DateTime, Voltage, type = "l",
                         ylab = "Voltage"))

# graph 3
with(power_consump, plot(DateTime, Sub_metering_1, type = "n",
                         ylab = "Energy Sub Metering"))
points(power_consump$DateTime, power_consump$Sub_metering_1, type = "l", col = "black")
points(power_consump$DateTime, power_consump$Sub_metering_2, type = "l", col = "red")
points(power_consump$DateTime, power_consump$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "___", col = c("black", "red", "blue"),
       legend = c("Met1", "Met2", "Met3"))

# graph 4
with(power_consump, plot(DateTime, Global_reactive_power, type = "l",
                         ylab = "Global_reactive_power"))


# copy graphic to png 
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()