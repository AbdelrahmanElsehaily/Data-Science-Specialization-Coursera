library("ggplot2")
library("dplyr")
if(!exists("NEI")){
  NEI <- readRDS("exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")
}
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}
coalindex=grep("coal|COAL",NEISCC$Short.Name)
coalData=NEISCC[coalindex,]
coalSum<-group_by(coalData,year)%>%summarise(Emissions=sum(Emissions))
ggplot(data=coalSum,aes(year,Emissions))+geom_point()+geom_line()
ggsave("plot4.png")
