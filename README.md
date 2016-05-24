## Exploratory Data Analysis - Course Project 2
### Instructions
Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

### Data
The data for this assignment are available from the course web site as a single zip file:

<a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip">Data for Peer Assessment</a> [29Mb]
The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
```
     fips      SCC Pollutant Emissions  type year
 4  09001 10100401  PM25-PRI    15.714 POINT 1999
 8  09001 10100404  PM25-PRI   234.178 POINT 1999
 12 09001 10100501  PM25-PRI     0.128 POINT 1999
 16 09001 10200401  PM25-PRI     2.036 POINT 1999
 20 09001 10200504  PM25-PRI     0.388 POINT 1999
 24 09001 10200602  PM25-PRI     1.490 POINT 1999
```
* _fips_: A five-digit number (represented as a string) indicating the U.S. county
* _SCC_: The name of the source as indicated by a digit string (see source code classification table)
* _Pollutant_: A string indicating the pollutant
* _Emissions_: Amount of PM2.5 emitted, in tons
* _type_: The type of source (point, non-point, on-road, or non-road)
* _year_: The year of emissions recorded
* _Source Classification Code Table_ (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings int he * _Emissions_ table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the `readRDS()` function in R. For example, reading in each file can be done with the following code:

*This first line will likely take a few seconds. Be patient!*
```
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

as long as each of those files is in your current working directory (check by calling dir() and see if those files are in the listing).

## Assignment
The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

### Making and Submitting Plots

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.
* In preparation we first ensure the data sets archive is downloaded and extracted.

We now load the NEI and SCC data frames from the .rds files.
```
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

# Process

### Get and read Data
* set your working directory where you have R files from this project
* call R file "Get_read_data.R" - `source("Get_read_data.R")` - this code download and unzip data for project

## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1
**Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?**
```
#aggregate data by year
totalPM25<-tapply(NEI$Emissions, NEI$year, sum)

#plot data
plot(names(totalPM25), totalPM25, type = 'l', col = 'red', xlab = "year", +
    main = "Total US PM2.5 by year")
```
 ![Alt Text](https://github.com/Rona-mi/ExData_Project2/blob/master/plot1.png)

**Answer** - according to the plot total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008

### Question 2
**Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == “24510”) from 1999 to 2008? Use the base plotting system to make a plot answering this question.**
```
# Subset Baltimore data and aggregating data by year
BaltimoreNEI<-NEI[NEI$fips == "24510",]
BaltimoretotalPM25<-tapply(BaltimoreNEI$Emissions, BaltimoreNEI$year, sum)

# plot
plot(names(BaltimoretotalPM25), BaltimoretotalPM25, type = 'l', col = 'blue',  +
    xlab = "year", main = "Total Baltimore PM2.5 from 1998 to 2008")
```
![Alt Text](https://github.com/Rona-mi/ExData_Project2/blob/master/plot2.png)
**Answer** - In general emissions decreased overall in Baltimore, but there was increasing in 2002-2005

### Question 3
**Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.**
```
library(ggplot2)

#change system local
Sys.setlocale("LC_ALL","English")

# Subset Baltimore data and aggregate data by year and type
BaltimoreNEI<-NEI[NEI$fips == "24510",]
BaltimorePM25_YearType<-aggregate(Emissions ~ year + type, BaltimoreNEI, sum)

#plot
g<-ggplot(BaltimorePM25_YearType, aes(year, Emissions, color = type))
g<-g + geom_line() +
  xlab("year") +
  ylab('Total PM2.5* Emissions') +
  ggtitle('Total Emissions in Baltimore from 1999 to 2008 by type')
print(g)
```
![Alt Text](https://github.com/Rona-mi/ExData_Project2/blob/master/plot3.png)

**Answer** - The **non-road**, **nonpoint**, **on-road** source types have all seen decreased emissions overall from 1999-2008 in Baltimore City. Only **point** source saw a slight increase overall from 1999-2008. Also the point source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values.

### Question 4
**Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?**
```
library(ggplot2)
#change system local
Sys.setlocale("LC_ALL","English")

#Subset coal combustion SCC codes
coalcomb.codes<-subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

# Subset NEI data by coal combustion codes and aggregate data by year 
coalcomb<-subset(NEI, SCC %in% coalcomb.codes$SCC)
coalcombPM25_YearType<-aggregate(Emissions ~ year + type, coalcomb, sum)

#plot
qplot(year, Emissions, data=coalcombPM25_YearType, color=type, geom="line") +
     ggtitle('Coal combustion emissions from 1998 to 2008')
```
![Alt Text](https://github.com/Rona-mi/ExData_Project2/blob/master/plot4.png)

**Answer** - Total emissions from coal source have decreased from 1998 to 2008.

### Question 5
**How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?**
```
library(ggplot2)
#change system local
Sys.setlocale("LC_ALL","English")

#Subset  motor vehicles sources 
vehicles.codes<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))

# Subset NEI data by motor vehicle and aggregate data by year 
vehiclesNEI<-subset(NEI, SCC %in% vehicles.codes$SCC)
vehiclesNEI<-vehiclesNEI[vehiclesNEI$fips == "24510",]
vehiclesPM25_Year<-aggregate(Emissions ~ year, vehiclesNEI, sum)

#plot
qplot(year, Emissions, data=vehiclesPM25_Year, geom="line") +
     ggtitle('Motor vehicle emissions from 1998 to 2008 in Baltimore')
```
![Alt Text](https://github.com/Rona-mi/ExData_Project2/blob/master/plot5.png)

**Answer** - Motor vehicle emissions decreased almost twice in Baltimore, MD from 1998 to 2008.

###Question 6
**Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == “06037”). Which city has seen greater changes over time in motor vehicle emissions?**

```
library(ggplot2)

#change system local
Sys.setlocale("LC_ALL","English")

# Subset  motor vehicles sources 
vehicles.codes<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))

# Subset NEI data by motor vehicle and aggregate data by year for Baltimore and LA 
vehiclesNEI<-subset(NEI, SCC %in% vehicles.codes$SCC)
vehiclesNEI<-vehiclesNEI[vehiclesNEI$fips == "24510" | vehiclesNEI$fips == "06037",]
vehiclesPM25_Year<-aggregate(Emissions ~ year * fips, vehiclesNEI, sum)
vehiclesPM25_Year$county<-ifelse(vehiclesPM25_Year$fips == "24510", "Baltimore", "Los Angeles")

#plot
qplot(year, Emissions, data=vehiclesPM25_Year, geom="line", color=county) + 
     ggtitle("Motor vehicle emissions from 1998 to 2008 compared in Baltimore and LA") + xlab("Year") + ylab(expression("Emissions"))
```
![Alt Text](https://github.com/Rona-mi/ExData_Project2/blob/master/plot6.png)

**Answer** - Los Angeles County has seen the greatest changes over time in motor vehicle emissions.

