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

#Create Plot 1
hist(tab$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", col = "red")

#Copy graph to PNG graphics device 
dev.copy(png, file = ".//data//plot1.png") 
dev.off()
