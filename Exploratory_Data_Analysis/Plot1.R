##Download The original File into a tempfile
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method = "wget")
##Read the data
data <- read.table(unz(temp, "household_power_consumption.txt"),
                   sep = ";" ,header=TRUE, na.strings= c("?"))
unlink(temp)

##Extract the Dates needed
Subset_Data<-subset(data, Date == "1/2/2007" | Date == "2/2/2007")

##First Plot
png(filename = "Plot1.png",
    width = 480, height = 480, units = "px")
hist(Subset_Data$Global_active_power, breaks=12, 
     col = "red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
