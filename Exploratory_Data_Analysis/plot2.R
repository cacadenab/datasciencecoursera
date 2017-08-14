setwd("/media/camilo/Info/Documents/UN/0-Courses/Coursera/Data_Science_Specialization/4.Exploratory_Data_Analysis/1.Assignments/1.Course_Project_1/")

### READ DATA ###

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile= "raw_data_1.zip", method = "curl");

unzip("raw_data_1.zip","household_power_consumption.txt");

DATA_1 <- read.csv(file = "household_power_consumption.txt" , sep = ";"
                   ,na.strings = c("?")
);

## ADJUST DATA TYPES
DATA_1$Date=strptime(DATA_1$Date,format = "%d/%m/%Y");


###subset data
DATA_2 = subset(DATA_1, Date == "2007-02-01" | Date == "2007-02-02")


## make the plot
png(filename = "plot2.png",width = 480,height = 480 )

with(DATA_2, plot(as.POSIXct(paste(Date, Time)),Global_active_power
                  ,type = "l",ylab = "Global Active Power (Kilowatts)"
                  ,xlab = ""
                  ,xaxt = "n"
                  )
     );
axis.POSIXct(x=as.POSIXct(paste(DATA_2$Date, DATA_2$Time)),
             side=1, format = "%a");


dev.off();

