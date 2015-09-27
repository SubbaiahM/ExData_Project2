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

#Get data for Baltimore and Los Angeles
baltimore<-subset(NEI, NEI$fips==24510)         
LA<-subset(NEI, NEI$fips=="06037")

# I will consider "Mobile" in SCC EI.Sector column as motor vehicles for this purpose
# When I do grep on the "mobile" I will get the following result
# lkpMobile<-unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))
# print(lkpMobile)
# [1] "Mobile - On-Road Gasoline Light Duty Vehicles"
# [2] "Mobile - On-Road Gasoline Heavy Duty Vehicles"
# [3] "Mobile - On-Road Diesel Light Duty Vehicles"  
# [4] "Mobile - On-Road Diesel Heavy Duty Vehicles"  
# [5] "Mobile - Non-Road Equipment - Gasoline"       
# [6] "Mobile - Non-Road Equipment - Other"          
# [7] "Mobile - Non-Road Equipment - Diesel"         
# [8] "Mobile - Aircraft"                            
# [9] "Mobile - Commercial Marine Vessels"           
# [10] "Mobile - Locomotives"          

# out of the above list I feel first four comes under the Motor Vechile category
# so will be plotting the same.

#Look for "mobile" keyword in the column EI.Sector of SCC source data
lkpMobile<-unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))  

#Vehicle Type data for SCC
Gas_Heavy<-subset(SCC, EI.Sector %in% lkpMobile[1])  
Gas_Light<-subset(SCC, EI.Sector %in% lkpMobile[2])
Diesel_Light<-subset(SCC, EI.Sector %in% lkpMobile[3])
Diesel_Heavy<-subset(SCC, EI.Sector %in% lkpMobile[4])

#SCC vehicle Type Data for Baltimore
gasHeavy<-subset(baltimore, SCC %in% Gas_Heavy$SCC)    
gasLight<-subset(baltimore, SCC %in% Gas_Light$SCC)
dieselLight<-subset(baltimore, SCC %in% Diesel_Light$SCC)
dieselHeavy<-subset(baltimore, SCC %in% Diesel_Heavy$SCC)
#SCC vehicle Type Data for Los Angeles
LAgasHeavy<-subset(LA, SCC %in% Gas_Heavy$SCC)    
LAgasLight<-subset(LA, SCC %in% Gas_Light$SCC)
LAdieselLight<-subset(LA, SCC %in% Diesel_Light$SCC)
LAdieselHeavy<-subset(LA, SCC %in% Diesel_Heavy$SCC)

#NEI Data with Vehicle Type
MotorVeh1<-data.frame(gasHeavy, vehicle="Gas - Heavy Duty")      
MotorVeh2<-data.frame(gasLight, vehicle="Gas - Light Duty")
MotorVeh3<-data.frame(dieselLight, vehicle="Diesel - Light Duty")
MotorVeh4<-data.frame(dieselHeavy, vehicle="Diesel - Heavy Duty")

LAMotorVeh1<-data.frame(LAgasHeavy, vehicle="Gas - Heavy Duty")    
LAMotorVeh2<-data.frame(LAgasLight, vehicle="Gas - Light Duty")
LAMotorVeh3<-data.frame(LAdieselLight, vehicle="Diesel - Light Duty")
LAMotorVeh4<-data.frame(LAdieselHeavy, vehicle="Diesel - Heavy Duty")


AllMotorVechicles<-rbind(MotorVeh1, MotorVeh2, MotorVeh3, MotorVeh4,
                         LAMotorVeh1, LAMotorVeh2, LAMotorVeh3, LAMotorVeh4) 

#substitute "fips" code to City Name
AllMotorVechicles$fips<-gsub("24510", "Baltimore", AllMotorVechicles$fips)     
AllMotorVechicles$fips<-gsub("06037", "Los Angeles", AllMotorVechicles$fips)

ggplot(data=AllMotorVechicles, aes(factor(year), Emissions, fill=vehicle)) +
  geom_bar(stat="identity", position=position_dodge()) +
  facet_grid(.~fips) +
  labs(x="Year", y="Emissions") + 
  ggtitle(expression(atop("Comparison of Motor Vehicles Emissions from 1999-2008:", 
                          atop(italic("Baltimore, MD and Los Angeles, CA")))))

dev.copy(png, file="plot6.png", height=480, width=640)
dev.off()