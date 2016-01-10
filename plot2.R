# Read
raw <- read.table("household_power_consumption.txt",sep=";",na.strings="?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Clean header
my_data <- raw[2:2075260,]
# Transform to Date
my_data$Date <- as.Date(my_data$Date,"%d/%m/%Y")
# Transform Time
my_data$Time <- strptime(paste(my_data$Date,my_data$Time),"%Y-%m-%d %H:%M:%S")
# Take data from 2007-02-01 and 2007-02-02
index <- my_data$Date >= "2007-02-01" & my_data$Date <= "2007-02-02"
clean_data <- my_data[index,]


######################

clean_data$day <- weekdays(clean_data$Date)
with(clean_data,plot(Time,Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)"))
lines(clean_data$Time,clean_data$Global_active_power)
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()