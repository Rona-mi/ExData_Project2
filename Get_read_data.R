#set work directory
#create data directory and download data

dir_dest<-'data'
file_dest<-'data/NEI_data.txt'

dir.create(dir_dest)

file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(file.url,destfile='data/NEI_data.zip')
unzip("data/NEI_data.zip", exdir=dir_dest, overwrite=TRUE)


#read data 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

