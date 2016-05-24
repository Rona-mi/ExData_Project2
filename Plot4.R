#set work directory
#setwd("C:/Users/ronami/Documents/DataScienceCourse/04_Exploratory Data Analysis/PrAss_2/ExData_Project2")

library(ggplot2)

#change system local
Sys.setlocale("LC_ALL","English")

#open device
png(filename='plot4.png',width=480,height=480,units='px')

##Subset coal combustion SCC codes
coalcomb.codes<-subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

## Subset NEI data by coal combustion codes and aggregate data by year 
coalcomb<-subset(NEI, SCC %in% coalcomb.codes$SCC)
coalcombPM25_YearType<-aggregate(Emissions ~ year + type, coalcomb, sum)

##plotting
qplot(year, Emissions, data=coalcombPM25_YearType, color=type, geom="line") + ggtitle('Coal combustion emissions from 1998 to 2008')

# close device
dev.off()