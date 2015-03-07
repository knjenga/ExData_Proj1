# This srcipt is an Exploratory Data Analysis script
# The script evaluates a single households electricity house usage for two days in a year
# The script creates an Exploratory line graph of the sub meter reading instaled at the house
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
#plot the Global active power line graph for diffrent types of the days
par(3,4,1,1)
#get the axis range ranges for the graph
xrange <- range(gdata$DateTime)
yrange <- range(gdata$Sub_metering_1)
plot(xrange,yrange,xlab="",ylab="Energy sub metering",type="n")
lines(gdata$DateTime,gdata$Sub_metering_1, col="black",lty=1)
lines(gdata$DateTime,gdata$Sub_metering_2, col="red",lty=1)
lines(gdata$DateTime,gdata$Sub_metering_3, col="blue",lty=1)
# format the graphs legend
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.7,
       lty=1
      )
# copy the graph to a png file called plot3.png
dev.copy(png,file ="plot3.png",height=480,width=580)
dev.off()