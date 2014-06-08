#install.packages("sqldf") if not installed already
if (!("sqldf" %in% rownames(installed.packages()))) {install.packages("sqldf")}
library(sqldf)

#create folder Data if it does not exits
if(!file.exists("data")) {dir.create("data")}

#Use a query to read input file and pull it to data frame
dest <- ".\\data\\household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = dest)
file <- unzip(dest, exdir = ".//data")
sql <- "select * from file where Date in ('1/2/2007', '2/2/2007')"
tab <- read.csv.sql(file, sql, header = T, sep = ";")

#combine Date and time to Time Class
tab$DT <- strptime(paste(tab$Date, tab$Time), "%d/%m/%Y %T")

#Create Plot 2
plot(tab$DT, tab$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab = )

#Copy graph to PNG graphics device 
dev.copy(png, file = ".//data//plot2.png") 
dev.off()
