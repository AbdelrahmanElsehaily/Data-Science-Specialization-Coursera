NEI <- readRDS("exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
baltimore=NEI[NEI$fips=="24510",]
baltimoreSum=tapply(baltimore$Emissions,baltimore$year,sum)
png("plot2.png")
barplot(baltimoreSum,xlab = "years", ylab = "Total Emmissions",main="Emission in Boltimore")
dev.off()