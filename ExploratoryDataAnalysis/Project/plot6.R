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
#filtering to get the data of the two counties only
mvData=mvData[mvData$fips %in% c("06037","24510"),]
mvSummary=group_by(mvData,fips,year)%>%summarise(Total_Emissions=sum(Emissions))
countyNames<-c('06037'="Los Angeles",'24510'='Baltimore')
ggplot(mvSummary,aes(year,Total_Emissions))+geom_point()+
geom_line()+facet_grid(.~fips,labeller = as_labeller(countyNames))
+ggtitle("Total Emissions in Baltimore and Los Angeles")
ggsave("plot6.png")
