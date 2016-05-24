#set your work directory

#change system local
Sys.setlocale("LC_ALL","English")

#open device
png(filename='plot1.png',width=480,height=480,units='px')

## aggregating data by year
totalPM25<-tapply(NEI$Emissions, NEI$year, sum)

# plot data
plot(names(totalPM25), totalPM25, type = 'l', col = 'red', xlab = "year", main = "Total US PM2.5 by year")

# close device
dev.off()