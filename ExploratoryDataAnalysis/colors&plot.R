# .~ drv is an expresssion which specify the layout if the plot  "." means one row "drv" 
#will be the number of unique values in the dev column in mpg data
qplot(hwy,displ,data=mpg,facets = .~drv)
#this function combines colors and return a funtion
colorRamp("red","blue")
#returns function when called returns
#vector its lenght is the argument passed to the function 
p1<-colorRampPalette(c("red","blue"))
#alpha represents the opacity
p3<-colorRampPalette(c("blue","green"),alpha=0.5)
#useful lattice commands
xyplot(Ozone ~ Wind | as.factor(Month), data = airquality, layout=c(5,1))
#usefful ggplot commands
g+geom_point()+facet_grid(drv~cyl,margins = TRUE)
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

