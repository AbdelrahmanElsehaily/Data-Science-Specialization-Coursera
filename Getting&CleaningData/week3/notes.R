download.file(" https://data.baltimorecity.gov/api/views/hzrz-cfzs/rows.csv?accessType=DOWNLOAD",destfile = "circulatorHeadways.csv")
dat=read.csv("circulatorHeadways.csv")
dat2=dat[,c("day","date","orangeAverage","purpleAverage","greenAverage","bannerAverage","daily")]