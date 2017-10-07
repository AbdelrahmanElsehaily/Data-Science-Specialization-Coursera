#question 1 after downloading the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "housingIdho.csv")
housing<-read.csv('housingIdho.csv')
print(nrow(subset(housing,VAL==24)))
print(nrow(housing[housing$VAL==24 & !is.na(housing$VAL), ]))
#Q3
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx',destfile = 'NGas-Acqusition.xlsx', mode='wb')
library('xlsx')
#Q4
doc<-xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",useInternal=TRUE)
rootNode<-xmlRoot(doc)
xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode==21231])

#Q5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "Fdata.csv")