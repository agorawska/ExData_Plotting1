####################################################################################
#STEP 1 - loading datasets and merging training and tests sets to create one dataset
####################################################################################

fileName <- "energy_consumption_dataset.zip"

## checks if datasets are available in the current working directory
if (!file.exists(fileName)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, fileName, method="auto")
}  
#checks if datasets were unzipped - generally if we can access it 
if (!file.exists("household_power_consumption.txt")) { 
  unzip(fileName) 
}

#loading dataset
energyData<-read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE)

#subsetting dataset so that it represents only measurements registered from 2007-02-01 to 2007-02-02
energyData<-energyData[energyData$Date %in% c("1/2/2007","2/2/2007"),]

#formating date and time
datetime <-paste(energyData$Date, energyData$Time, sep=" ")
datetime <- strptime(datetime, format =  "%d/%m/%Y %H:%M:%S")

#ploting
png("plot2.png", width=480, height=480)

#ploting - X axis will have abbreviation according to your system settings - mine are in Polish
#CZ - is a shortcut for polish translation of 'Thursday'
#PT - is a shortcut for polish translation of 'Friday'
#SO - is a shortcut for polish translation of 'Sathurday'
plot(datetime, as.numeric(energyData$Global_active_power), xlab="", ylab="Global Active Power (kilowatts)", type="l")

dev.off()
