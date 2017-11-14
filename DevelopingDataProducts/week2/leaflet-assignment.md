# Life Expectancy Map
Abdelrahman  
October 31, 2017  



## Introduction
This map Contains the life expectency on birth for evey country, the source of the data is [world bank] (https://data.worldbank.org/indicator/SP.DYN.LE00.IN)

### Loading the required libraries

```r
library(sp)
library(maps)
library(maptools)
```

```
## Checking rgeos availability: TRUE
```

```r
library(leaflet)
library(countrycode)
library(plyr)
```

```
## 
## Attaching package: 'plyr'
```

```
## The following object is masked from 'package:maps':
## 
##     ozone
```

### Reading dataset


```r
lifedata<-read.csv(file ="API_SP.DYN.LE00.IN_DS2_en_csv_v2.csv")
```

### using map to create polygons of whold worldcountries then filterin it to conatin the same countries as the life expectation data


```r
world <- map("world", fill=TRUE, plot=FALSE)
world_map <- map2SpatialPolygons(world, sub(":.*$", "", world$names))
#some countries in wolrld map has differnet names from the data set so using country code is better
country_names=countrycode(names(world_map), 'country.name',"iso3c")
```

```
## Warning in countrycode(names(world_map), "country.name", "iso3c"): Some values were not matched unambiguously: Ascension Island, Azores, Barbuda, Bonaire, Canary Islands, Chagos Archipelago, Grenadines, Heard Island, Kosovo, Madeira Islands, Micronesia, Saba, Saint Martin, Siachen Glacier, Sint Eustatius
```

```r
#getting only countries that exists in the data set
world_map=world_map[!is.na(country_names)&(country_names%in%lifedata$Country.Code),]
#creating datafram for joining
country_names=data.frame("Country.Code"=country_names[!is.na(country_names)&(country_names%in%lifedata$Country.Code)])
```
### joining country names in the worl_map polygons to the dataset so data will be in the same order as wolrd_map object


```r
#using join so data will be in the same order of the object world_map
lifedata=join(country_names,lifedata)
```

```
## Joining by: Country.Code
```

### drawing map

```r
world_map <- SpatialPolygonsDataFrame(world_map[1:211],lifedata,FALSE)
bins <- c( 45, 50, 55, 60, 65, 70,75,80, Inf)
pal <- colorBin("YlOrRd", domain = world_map$X2015, bins = bins)
labels <- sprintf(
  "<strong>%s</strong><br/>%g years",
  world_map$Country.Name, world_map$X2015
) %>% lapply(htmltools::HTML)
leaflet(world_map) %>% 
  addTiles() %>% 
  addPolygons(fillColor = ~pal(X2015),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7, 
  label = labels,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "15px",
    direction = "auto"))
```

<!--html_preserve--><div id="htmlwidget-8c8d9e1830472e7ef448" style="width:672px;height:480px;" class="leaflet html-widget"></div>


