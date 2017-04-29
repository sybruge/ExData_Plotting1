library(dplyr)

tmpFile <- tempfile()
download.file(url, destfile = tmpFile, method = "curl")
consumption <- read.csv(file = tmpFile,
                        sep=";", 
                        header=TRUE, 
                        fileEncoding="UTF-8", 
                        stringsAsFactors=FALSE, 
                        na.strings = "?", 
                        colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), 
                        nrows=69517)

filteredConsumption <- as.data.frame(consumption) %>% 
  transform(DateTime = strptime(paste(Date,Time,sep=' '), format="%d/%m/%Y %H:%M:%S")) %>%
  filter(DateTime >= "2007-02-01" & DateTime < "2007-02-03")

png(file="plot4.png")

par(mfcol=c(2,2))

with (filteredConsumption, plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type="l"))

with (filteredConsumption, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering",type="l"))
with (filteredConsumption, lines(DateTime, Sub_metering_2, col="red"))
with (filteredConsumption, lines(DateTime, Sub_metering_3, col="blue"))

with (filteredConsumption, plot(DateTime, Voltage, type="l"))

with (filteredConsumption, plot(DateTime, Global_reactive_power, type="l"))

dev.off()