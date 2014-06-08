#install.packages("sqldf") if not installed already
if (!("sqldf" %in% rownames(installed.packages()))) {install.packages("sqldf")}
library(sqldf)

#create folder Data if it does not exits
if(!file.exists("data")) {dir.create("data")}

#Use a query to read input file and pull it to data frame
dest <- ".\\data\\household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = dest)
#file <- unzip(dest, exdir = ".//data")
file <- ".//data//household_power_consumption.zip"
sql <- "select * from file where Date in ('1/2/2007', '2/2/2007')"
tab <- read.csv.sql(file, sql, header = T, sep = ";")

#combine Date and time to Time Class
tab$DT <- strptime(paste(tab$Date, tab$Time), "%d/%m/%Y %T")

#Open PNG graphics device 
png(file = ".//data//plot4.png")
#set par property
par(mfrow = c(2, 2))

#Create Plot 1 at c(1,1)
plot(tab$DT, tab$Global_active_power, xlab = "" , ylab = "Global Active Power (kilowatts)", type = "l")

#Create Plot 2 at c(1,2)
plot(tab$DT, tab$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#Create Plot 3 at c(2,1)
plot(tab$DT, tab$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
points(tab$DT, tab$Sub_metering_2, type = "l", col = "red")
points(tab$DT, tab$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_1", "Sub_metering_1"), 
       lty = 1, col = c("black", "red", "blue"))

#Create Plot 4 at c(2,2)
plot(tab$DT, tab$Global_reactive_power, xlab = "datetime" , ylab = "Global_reactive_power", type = "l")

dev.off()
