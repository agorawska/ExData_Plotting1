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
png("plot3.png", width=480, height=480)

#creating an empty plot
plot(datetime, as.numeric(energyData$Sub_metering_1), xlab="", ylab="Energy sub metering", type="n")
#adding first series of data - Sub_metering_1
points(datetime,as.numeric(energyData$Sub_metering_1),type="l")
#adding second series of data - Sub_metering_2
points(datetime,as.numeric(energyData$Sub_metering_2),type="l", col="red")
#adding third series of data - Sub_metering_3
points(datetime,as.numeric(energyData$Sub_metering_3),type="l",col="blue")
#adding legend
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch="-",col=c("black","red","blue"))


dev.off()
