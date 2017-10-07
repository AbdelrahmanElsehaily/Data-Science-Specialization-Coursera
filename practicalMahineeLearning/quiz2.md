---
title: "Untitled"
author: "Abdelrahman Elsehaily"
date: "October 1, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## question 4
```{r}
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```



```{r}
training$diagnosis
training=training[,grep("^IL|diagnosis",names(training))]
xprc=prcomp(training[,-1])
s=preProcess(training[,-1],method="pca",thresh = 0.9)

```

## Question 5

```{r}
pca=preProcess(training[,-1],method="pca",thresh = 0.8)
pcaTraining=predict(pca,training[,-1])
trainSmall <- data.frame(training[,grep('^IL',names(training))],training$diagnosis)
testSmall <- data.frame(testing[,grep('^IL',names(testing))],testing$diagnosis)
preProc <- preProcess(trainSmall[-13],method="pca",thres=.8)
trainPC <- predict(preProc,trainSmall[-13])
testPC <- predict(preProc,testSmall[-13])

PCFit <- train(trainSmall$training.diagnosis ~ . ,data=trainPC[,1],method="glm")
```
Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
