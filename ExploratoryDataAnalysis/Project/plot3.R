library("ggplot2")
library("dplyr")
if(!exists("NEI")){
  NEI <- readRDS("/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
}
baltimore=NEI[NEI$fips=="24510",]

grouped_baltimore=group_by(baltimore,year,type)

summary=summarise(grouped_baltimore,Emission=sum(Emissions,na.rm = TRUE))
ggplot(summary,aes(year,Emission))+geom_point()+geom_smooth(method="lm")+facet_grid(.~type)
ggsave("plot3.png",width = 9,height = 4)
