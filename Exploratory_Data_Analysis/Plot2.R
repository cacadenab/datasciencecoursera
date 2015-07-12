##Download The original File into a tempfile
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method = "wget")
##Read the data
data <- read.table(unz(temp, "household_power_consumption.txt"),
                   sep = ";" ,header=TRUE, na.strings= c("?"))
unlink(temp)

##Extract the Dates needed
Subset_Data<-subset(data, Date == "1/2/2007" | Date == "2/2/2007")


##Second Plot
png(filename = "Plot2.png",
    width = 480, height = 480, units = "px")
plot(strptime(paste(Subset_Data$Date, Subset_Data$Time ), format = "%d/%m/%Y %H:%M:%S"),
     Subset_Data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
