#set work directory

library(ggplot2)

#change system local
Sys.setlocale("LC_ALL","English")

#open device
png(filename='plot5.png',width=480,height=480,units='px')

##Subset  motor vehicles sources 
vehicles.codes<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))

## Subset NEI data by motor vehicle and aggregate data by year 
vehiclesNEI<-subset(NEI, SCC %in% vehicles.codes$SCC)
vehiclesNEI<-vehiclesNEI[vehiclesNEI$fips == "24510",]
vehiclesPM25_Year<-aggregate(Emissions ~ year, vehiclesNEI, sum)

##plotting
qplot(year, Emissions, data=vehiclesPM25_Year, geom="line") + ggtitle('Motor vehicle emissions from 1998 to 2008 in Baltimore')

# close device
dev.off()