# Read
raw <- read.table("household_power_consumption.txt",sep=";",na.strings="?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Clean header
my_data <- raw[2:2075260,]
# Transform to Date
my_data$Date <- as.Date(my_data$Date,"%d/%m/%Y")
# Transform Time
my_data$Time <- strptime(paste(my_data$Date,my_data$Time),"%Y-%m-%d %H:%M:%S")
# Clean factor submeter
my_data$Sub_metering_1 <- as.numeric(as.character(my_data$Sub_metering_1))
my_data$Sub_metering_2 <- as.numeric(as.character(my_data$Sub_metering_2))
my_data$Sub_metering_3 <- as.numeric(as.character(my_data$Sub_metering_3))
# Take data from 2007-02-01 and 2007-02-02
index <- my_data$Date >= "2007-02-01" & my_data$Date <= "2007-02-02"
clean_data <- my_data[index,]


######################

clean_data$day <- weekdays(clean_data$Date)
par(mfrow=c(2,2))

# Plot 1,1
with(clean_data,plot(Time,Global_active_power,type="n",xlab="",ylab="Global Active Power"))
lines(clean_data$Time,clean_data$Global_active_power)

# Plot 2,1
with(clean_data,plot(Time,Voltage,type="n",xlab="datetime",ylab="Voltage"))
lines(clean_data$Time,clean_data$Voltage)

# Plot 1,2
with(clean_data,plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
lines(clean_data$Time,clean_data$Sub_metering_1)
lines(clean_data$Time,clean_data$Sub_metering_2,col="red")
lines(clean_data$Time,clean_data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_1"),cex=0.26)

# Plot 2,2
with(clean_data,plot(Time,Global_reactive_power,type="n",xlab="datetime"))
lines(clean_data$Time,clean_data$Global_reactive_power)

dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()