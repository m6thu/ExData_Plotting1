# Read
raw <- read.table("household_power_consumption.txt",sep=";",na.strings="?",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Clean header
my_data <- raw[2:2075260,]
# Transform to Date
my_data$Date <- as.Date(my_data$Date,"%d/%m/%Y")
# Take data from 2007-02-01 and 2007-02-02
index <- my_data$Date >= "2007-02-01" & my_data$Date <= "2007-02-02"
clean_data <- my_data[index,]

######################

plot_data <- as.numeric(as.character(clean_data$Global_active_power))
hist(plot_data,col="red",xlab = "Global Active Power (kilowatts)", main ="Global Active Power")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()