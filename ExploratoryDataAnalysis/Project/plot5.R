library('dplyr')
library("ggplot2")
#check if the data is already loaded, if not then load it
if(!exists("NEI")){
  NEI <- readRDS("exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")
}
#meging the two datasets
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}
if(!exists("mvData")){
mvData=NEISCC[grep("motor vehicle",NEISCC$Short.Name,ignore.case=TRUE),]
}
#it only contains two rows !!
mvData_baltimore <- mvData[mvData$fips=="24510",]
ggplot(mvData_baltimore,aes(year,Emissions))+geom_point()+geom_line()
ggsave("plot5.png")

