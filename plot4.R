# This srcipt is an Exploratory Data Analysis script
# The script evaluates a single households electricity house usage for two days in a year
# The script creates an 4 Exploratory graphs on a single graph
#
#Load the required library functions
library(dplyr) 
# The function assumes that the input are in the working directory
# Get the users working directory
file_dir <- getwd()
# Create the file name
file_location <- paste0(file_dir,"/household_power_consumption.txt")
# Read the whole data set
edata <- read.table(file_location,header = TRUE,sep=";",na.strings = "?",dec = ".")
# filter the data to just the required two days of intrest
gdata <- filter(edata, Date == "1/2/2007"|Date == "2/2/2007")
# create a new field that holds both the data and time
gdata$DateTime <- strptime(paste(gdata$Date,gdata$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")
# format the Date and time fields in from text to date fields
gdata$Date <- as.Date(gdata$Date,format="%d/%m/%Y")
gdata$Time <- as.Date(gdata$Time,format="%H/%M/%S")
#set the number of graphs per page to be created 4 in total 2 down and 2 across
par(mfrow=c(2,2))
#Set the margins of the entire page size
par(mar = c(4,5,1,1))
#graph for Global Active Power for the two days
plot(gdata$DateTime,gdata$Global_active_power,type="l",xlab="",ylab="Global Active Power")
# Voltage usage for the two days
plot(gdata$DateTime,gdata$Voltage,type="l",xlab="datetime",ylab="Voltage")
# Graph Sub metering usage for the two days
xrange <- range(gdata$DateTime)
yrange <- range(gdata$Sub_metering_1)
plot(xrange,yrange,xlab="",ylab="Energy sub metering",type="n")
lines(gdata$DateTime,gdata$Sub_metering_1, col="black",lty=1)
lines(gdata$DateTime,gdata$Sub_metering_2, col="red",lty=1)
lines(gdata$DateTime,gdata$Sub_metering_3, col="blue",lty=1)
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.4,
       lty=1
      )
# Graph the global reacative power usage for the two days
plot(gdata$DateTime,gdata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
# Write the output to a png file
dev.copy(png,file ="plot4.png",height=1080,width=1280)
dev.off()
