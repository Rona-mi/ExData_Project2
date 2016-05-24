#set work directory

library(ggplot2)

#change system local
Sys.setlocale("LC_ALL","English")

#open device
png(filename='plot6.png',width=480,height=480,units='px')

# Subset  motor vehicles sources 
vehicles.codes<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))

# Subset NEI data by motor vehicle and aggregate data by year for Baltimore and LA 
vehiclesNEI<-subset(NEI, SCC %in% vehicles.codes$SCC)
vehiclesNEI<-vehiclesNEI[vehiclesNEI$fips == "24510" | vehiclesNEI$fips == "06037",]
vehiclesPM25_Year<-aggregate(Emissions ~ year * fips, vehiclesNEI, sum)
vehiclesPM25_Year$county<-ifelse(vehiclesPM25_Year$fips == "24510", "Baltimore", "Los Angeles")

##plot
qplot(year, Emissions, data=vehiclesPM25_Year, geom="line", color=county) + ggtitle("Motor vehicle emissions from 1998 to 2008 compared in Baltimore and LA") + xlab("Year") + ylab(expression("Emissions"))

# close device
dev.off()