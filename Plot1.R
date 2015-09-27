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

#Total emissions per year
totalNEI <- tapply(NEI$Emissions, INDEX=NEI$year, sum)  

## Generating the Plot 1
barplot(totalNEI, main=paste("Total PM2.5 emission from all sources/Year"), 
     xlab="Year", ylab="Emissions", col="Green")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()