#quiz4 getting and cleaning data
#Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="survey.csv")
dt<-read.csv("survey.csv")
splited_vnames<-strsplit(names(dt),"wgtp")
print (splited_vnames[[123]])

#Q2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="./week4/countryRanking.csv")
dt<-read.csv("./week4/countryRanking.csv")
gdp <- as.numeric(gsub(",", "", dt$X.3))[1:195]
mean(gdp, na.rm = TRUE)

#Q3
grep("^United",countryNames)#3

#Q4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="./week4/countryedu.csv")
dtedu<-read.csv("./week4/countryedu.csv")
dt<-read.csv("./week4/countryRanking.csv")
dt <- dt[,c("X","X.2","X.3")]
colnames(dt)<-c("CountryCode", "Long.Name", "gdp")
mergedddt <- merge(dt, dtedu, all = TRUE, by = c("CountryCode"))
for(name in names(mergeddf)){
  
  if (length(grep("*fiscal year",tolower(mergeddf[,name])))){
    
    print (paste(name,"****************"))
    print(grep("fiscal year.*june|june.*fiscal year",tolower(mergeddf[,name]),value=TRUE))
    
  }}
#Q5
addmargins(table(year(index(amzn)), weekdays(index(amzn))))
