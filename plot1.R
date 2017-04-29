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

png(filename="plot1.png")
hist(filteredConsumption$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", breaks=12, main="Global Active Power")
dev.off()