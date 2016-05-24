#set work directory

#change system local
Sys.setlocale("LC_ALL","English")

#open device
png(filename='plot2.png',width=480,height=480,units='px')

## Subsetting Baltimore data and aggregating data by year
BaltimoreNEI<-NEI[NEI$fips == "24510",]
BaltimoretotalPM25<-tapply(BaltimoreNEI$Emissions, BaltimoreNEI$year, sum)

##plotting
plot(names(BaltimoretotalPM25), BaltimoretotalPM25, type = 'l', col = 'blue', xlab = "year", main = "Total Baltimore PM2.5 from 1998 to 2008")

# close device
dev.off()