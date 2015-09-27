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


#Look for "coal" keyword in the column EI.Sector of SCC source data
LkpCoal<-unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))  

#Get only the coal subset data from SCC
sccCoal<-subset(SCC, EI.Sector %in% LkpCoal)    

#Get the SCC coal data in NEI
coal<-subset(NEI, SCC %in% sccCoal$SCC)        

ggplot(data=coal, aes(factor(year), Emissions, fill = type)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  labs(x="Year", y="Emissions") + 
  ggtitle("U.S. Coal Combustion-Related Sources data from 1999-2008")


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()