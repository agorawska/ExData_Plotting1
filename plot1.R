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
#energyData<-read.table("household_power_consumption.txt",skip=grep(pattern = ".+/02/2007.*",readLines("household_power_consumption.txt")), header=TRUE)
energyData<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

#subsetting dataset so that it represents only measurements registered from 2007-02-01 to 2007-02-02
energyData<-energyData[energyData$Date %in% c("1/2/2007","2/2/2007"),]

#formating energyData$Date to Date format
energyData$Date <- as.Date(energyData$Date,"%d/%m/%Y")

#ploting histogram
png("plot1.png", width=480, height=480)
hist(as.numeric(energyData$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()

