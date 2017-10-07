# Reproducabl Research Final Project



# Analyzing the effects of weather events on United states

## 1.synopsis 

This project is a par Reproducable Research course which is a part of the Data Science Specialization on Coursera, The basic goal of this assignment is to explore the [NOAA Storm Database](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2) and determining which events has the most effect on health and economic the data is collected from 1950 and end in November 2011
the analysis doesn't take into the consideration the dates or the states but the total effects on health, property and crops caused by the different weather events on United States.


## 2. Data Processing

### Importing dpylr for wrangling the data, and ggplot2 for visualization

```r
library("dplyr")
```

```
## Warning: package 'dplyr' was built under R version 3.4.1
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library("ggplot2")
```

```
## Warning: package 'ggplot2' was built under R version 3.4.1
```

```r
library("gridExtra")
```

```
## Warning: package 'gridExtra' was built under R version 3.4.1
```

```
## 
## Attaching package: 'gridExtra'
```

```
## The following object is masked from 'package:dplyr':
## 
##     combine
```
#### Reading data

```r
rawdata=read.csv("repdata%2Fdata%2FStormData.csv.bz2")
head(rawdata,3)
```

```
##   STATE__          BGN_DATE BGN_TIME TIME_ZONE COUNTY COUNTYNAME STATE
## 1       1 4/18/1950 0:00:00     0130       CST     97     MOBILE    AL
## 2       1 4/18/1950 0:00:00     0145       CST      3    BALDWIN    AL
## 3       1 2/20/1951 0:00:00     1600       CST     57    FAYETTE    AL
##    EVTYPE BGN_RANGE BGN_AZI BGN_LOCATI END_DATE END_TIME COUNTY_END
## 1 TORNADO         0                                               0
## 2 TORNADO         0                                               0
## 3 TORNADO         0                                               0
##   COUNTYENDN END_RANGE END_AZI END_LOCATI LENGTH WIDTH F MAG FATALITIES
## 1         NA         0                      14.0   100 3   0          0
## 2         NA         0                       2.0   150 2   0          0
## 3         NA         0                       0.1   123 2   0          0
##   INJURIES PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP WFO STATEOFFIC ZONENAMES
## 1       15    25.0          K       0                                    
## 2        0     2.5          K       0                                    
## 3        2    25.0          K       0                                    
##   LATITUDE LONGITUDE LATITUDE_E LONGITUDE_ REMARKS REFNUM
## 1     3040      8812       3051       8806              1
## 2     3042      8755          0          0              2
## 3     3340      8742          0          0              3
```
### Dealing with the eponents 
from reading the documentation I figured out that the coulumn "PROPDMGEXP", "CROPDMGEXP" is eponent for the "PROPDMG", "CROPDMG" wicht represents the damages in money loss

```r
levels(rawdata$PROPDMGEXP)
```

```
##  [1] ""  "-" "?" "+" "0" "1" "2" "3" "4" "5" "6" "7" "8" "B" "h" "H" "K"
## [18] "m" "M"
```

```r
levels(rawdata$CROPDMGEXP)
```

```
## [1] ""  "?" "0" "2" "B" "k" "K" "m" "M"
```

creating a new data frames that represnt the exponents with the real numbers and merging them to the data 

```r
propdmgdf=data.frame(PROPDMGEXP=levels(rawdata$PROPDMGEXP),PROPDMGEXPNUM= c(0,0,0,0,1,1,10,100,1000,1e+05,1e+06,1e+07,1e+08,1e+09,100,100,1000,1e+06,1e+06))
cropdf=data.frame(CROPDMGEXP=levels(rawdata$CROPDMGEXP),CROPDMGEXPNUM= c(1,0,1,10,1e+09,1000,1000,1e+06,1e+06))
numericdf=merge(rawdata,propdmgdf,by="PROPDMGEXP")
numericdf=merge(numericdf,cropdf,by="CROPDMGEXP")
```
Creating new cloumns represents the multiblcations of the damages and the exponents

```r
numericdf=numericdf%>%mutate(TOTALPROPDMG=PROPDMGEXPNUM*PROPDMG,TOTALCROPDMG=CROPDMGEXPNUM*CROPDMG)
```

```
## Warning: package 'bindrcpp' was built under R version 3.4.1
```
### getting the required data frame
first selected the required coulmns only for the results part, then grouped by event type to get the total (injuries, fatalities, crop damages, Property damages)

```r
analysisdata=select(numericdf,
                  EVTYPE,TOTALPROPDMG,TOTALCROPDMG,INJURIES,FATALITIES)%>%
                  group_by(EVTYPE)%>%
                  summarise(TOTALPROPDMG=sum(TOTALPROPDMG),
                            TOTALCROPDMG=sum(TOTALCROPDMG),
                            INJURIES=sum(INJURIES),
                            FATALITIES=sum(FATALITIES))
```
## 2.Results

### Health Effect
getting the first ten event types with highest deaths and highest injuries in distinct plots

```r
p1<-ggplot(data=slice(arrange(analysisdata,desc(FATALITIES)),1:10),aes(x=reorder(EVTYPE,-FATALITIES),y=FATALITIES))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, hjust = 1))+xlab("")+ggtitle("Highsest Events FATALITIES")
p2<-ggplot(data=slice(arrange(analysisdata,desc(INJURIES)),1:10),aes(x=reorder(EVTYPE,-INJURIES),y=INJURIES))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, hjust = 1))+xlab("")+ggtitle("Highsest Events INJURIES")
grid.arrange(p1, p2, ncol=2)
```

![](projet2_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

### Econmic Effect

```r
p3<-ggplot(data=slice(arrange(analysisdata,desc(FATALITIES)),1:10),aes(x=reorder(EVTYPE,-FATALITIES),y=FATALITIES))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, hjust = 1))+xlab("")+ggtitle("Highsest Events FATALITIES")
p4<-ggplot(data=slice(arrange(analysisdata,desc(INJURIES)),1:10),aes(x=reorder(EVTYPE,-INJURIES),y=INJURIES))+geom_bar(stat = "identity")+theme(axis.text.x = element_text(angle = 90, hjust = 1))+xlab("")+ggtitle("Highsest Events INJURIES")
grid.arrange(p3, p4, ncol=2)
```

![](projet2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

## Conclusion

It seemd that Tornade has the highest effect on either the health and economics, also the high death doesn't imply high injuries and vise versa.
