# Project 2

# Please download the Data source Zip File 
# Unzip the file and copy the files to your desired location
# Then please execute the "setwd()" command for that location as shown in the example below


# Read the source data from the file in the following path
setwd("C:/Users/wa82/Documents/Malleswari/Coursera/Exploratory Data Analysis/Project2 Data")

#Extract/Read PM2.5 Emissions Source Data
NEI <- readRDS("summarySCC_PM25.rds")

# Extract/Read Source Classification Code Data
SCC <- readRDS("Source_Classification_Code.rds")  

#Get only data of Baltimore area
baltimore<-subset(NEI, NEI$fips==24510)           

#Total emissions per year for Baltomore
totalBaltimore<-tapply(baltimore$Emissions, INDEX=baltimore$year, sum)   

# plot that shows Emissions/year for the Baltimore city
barplot(totalBaltimore, main="Total PM2.5 Emission from Baltimore/Year", 
        xlab="Year", ylab="Emissions", col="Green")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()