# This srcipt is an Exploratory Data Analysis script
# The script evaluates a single households electricity house usage for two days in a year
# The script creates an Exploratory line graph of the Global activty usage
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
plot(gdata$DateTime,gdata$Global_active_power,type="l",xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()