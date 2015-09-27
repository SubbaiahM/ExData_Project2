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

# Generating the plot 3
ggplot(data=baltimore, aes(factor(year), Emissions, fill=type)) +    
  geom_bar(stat="identity", position="dodge") +
  facet_grid(.~year,scales = "free",space="free") +
  labs(x="Year", y="Emissions") + 
  ggtitle("Baltimore Emissions by Year and by types from 1999-2008") 


dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()