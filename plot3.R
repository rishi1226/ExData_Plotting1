#install.packages("sqldf") if not installed already
if (!("sqldf" %in% rownames(installed.packages()))) {install.packages("sqldf")}
library(sqldf)


#create folder Data if it does not exits
if(!file.exists("data")) {dir.create("data")}

#Use a query to read input file
dest <- ".\\data\\household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = dest)

file <- unzip(dest, exdir = ".//data")

sql <- "select * from file where Date in ('1/2/2007', '2/2/2007')"

tab <- read.csv.sql(file, sql, header = T, sep = ";")

#Open PNG graphics device 
png(file = ".//data//plot3.png")

#Create Plot 3
plot(tab$DT, tab$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
points(tab$DT, tab$Sub_metering_2, type = "l", col = "red")
points(tab$DT, tab$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_1", "Sub_metering_1"), lty = 1, col = c("black", "red", "blue"))

dev.off()
