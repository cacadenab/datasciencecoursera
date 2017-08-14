##Download The original File into a tempfile
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method = "wget")
##Read the data
data <- read.table(unz(temp, "household_power_consumption.txt"),
                   sep = ";" ,header=TRUE, na.strings= c("?"))
unlink(temp)



##Extract the Dates needed
DATA_2<-subset(data, Date == "1/2/2007" | Date == "2/2/2007")


## ADJUST DATA TYPES
DATA_2$Date=strptime(DATA_2$Date,format = "%d/%m/%Y");


##Fourth Plot
png(filename = "Plot4.png",
    width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

## First_Sub_Plot

with(DATA_2, plot(as.POSIXct(paste(Date, Time)),Global_active_power
                  ,type = "l",ylab = "Global Active Power (Kilowatts)"
                  ,xlab = ""
                  ,xaxt = "n"
)
);
axis.POSIXct(x=as.POSIXct(paste(DATA_2$Date, DATA_2$Time)),
             side=1, format = "%a");


##Second SubPlot

with(DATA_2, plot(as.POSIXct(paste(Date, Time)),Voltage
                  ,type = "l",ylab = "Voltage"
                  ,xlab = "datetime"
                  ,xaxt = "n"
)
);
axis.POSIXct(x=as.POSIXct(paste(DATA_2$Date, DATA_2$Time)),
             side=1, format = "%a");


##Third SubPlot

with(DATA_2, plot(as.POSIXct(paste(Date, Time)),Sub_metering_1
                  ,type = "l",ylab = "Energy sub metering"
                  ,xlab = ""
                  ,xaxt = "n"
                  ,col="black"
)
);
with(DATA_2, lines(as.POSIXct(paste(Date, Time)),Sub_metering_2
                   ,type = "l"
                   ,xlab = ""
                   ,xaxt = "n"
                   ,col="red"
)
);
with(DATA_2, lines(as.POSIXct(paste(Date, Time)),Sub_metering_3
                   ,type = "l"
                   ,xlab = ""
                   ,xaxt = "n"
                   ,col="blue"
)
);
legend("topright",lty= 1,col=c("black","red","blue")
       , legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,bty  = "n"
)

axis.POSIXct(x=as.POSIXct(paste(DATA_2$Date, DATA_2$Time)),
             side=1, format = "%a");


##Fourth SubPlot

with(DATA_2, plot(as.POSIXct(paste(Date, Time)),Global_reactive_power
                  ,type = "l",ylab = "Global_reactive_power"
                  ,xlab = "datetime"
                  ,xaxt = "n"
)
);
axis.POSIXct(x=as.POSIXct(paste(DATA_2$Date, DATA_2$Time)),
             side=1, format = "%a");


dev.off()
