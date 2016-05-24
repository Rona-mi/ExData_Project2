#set work directory

library(ggplot2)

#change system local
Sys.setlocale("LC_ALL","English")


#open device
png(filename='plot3.png',width=480,height=480,units='px')

## Subset Baltimore data and aggregate data by year and type
BaltimoreNEI<-NEI[NEI$fips == "24510",]
BaltimorePM25_YearType<-aggregate(Emissions ~ year + type, BaltimoreNEI, sum)

##plotting
g<-ggplot(BaltimorePM25_YearType, aes(year, Emissions, color = type))
g<-g + geom_line() +
  xlab("year") +
  ylab('Total PM2.5* Emissions') +
  ggtitle('Total Emissions in Baltimore from 1999 to 2008 by type')
print(g)

# close device
dev.off()