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

par(mfcol=c(1,1))

png(file="plot3.png")
    
with (filteredConsumption, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering",type="l"))
with (filteredConsumption, lines(DateTime, Sub_metering_2, col="red"))
with (filteredConsumption, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()