---
output: html_document
---
---
title: 'Practical Machine Learning: Excercise Quality Prediction'
output:
  pdf_document: default
  html_document:
    keep_md: yes
  ---

## Introduction / Executive summary

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants was used to predict the quality of technique employed.

## Loading and exploring the data set

In first part of the code, data sets is loaded and partially cleaned. Useless columns and columns with near zero variance are excluded from the dataset. Type of exercises empoyed are classified as numbers from 1 to 5. Also parallel computing is setup with doMC library.



After cleaning the data, several prediction models were trained - Global Boost Machine, Random Forest.


```r
boostModel <- train(classe ~ ., method = "gbm", data = dataPML, trControl = trainControl(method = "cv", number = 10, allowParallel = TRUE))
```

```
## Loading required package: gbm
## Loading required package: survival
## 
## Attaching package: 'survival'
## 
## The following object is masked from 'package:caret':
## 
##     cluster
## 
## Loading required package: splines
## Loaded gbm 2.1.1
## Loading required package: plyr
```

```
## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
##      1        1.6094            -nan     0.1000    0.2423
##      2        1.4563            -nan     0.1000    0.1706
##      3        1.3514            -nan     0.1000    0.1315
##      4        1.2682            -nan     0.1000    0.1107
##      5        1.1972            -nan     0.1000    0.1025
##      6        1.1336            -nan     0.1000    0.0803
##      7        1.0830            -nan     0.1000    0.0821
##      8        1.0325            -nan     0.1000    0.0818
##      9        0.9832            -nan     0.1000    0.0746
##     10        0.9395            -nan     0.1000    0.0594
##     20        0.6325            -nan     0.1000    0.0483
##     40        0.3414            -nan     0.1000    0.0144
##     60        0.2017            -nan     0.1000    0.0049
##     80        0.1325            -nan     0.1000    0.0031
##    100        0.0899            -nan     0.1000    0.0029
##    120        0.0644            -nan     0.1000    0.0013
##    140        0.0473            -nan     0.1000    0.0011
##    150        0.0417            -nan     0.1000    0.0006
```

```r
randomForestModel <- train(classe ~ ., method = "rf", data = training, importance = T, trControl = trainControl(method = "cv", number = 10, allowParallel = TRUE))
```

```
## Error in eval(expr, envir, enclos): object 'training' not found
```

```r
boostModel
```

```
## Stochastic Gradient Boosting 
## 
## 19622 samples
##    55 predictors
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## Summary of sample sizes: 17660, 17659, 17660, 17661, 17659, 17660, ... 
## Resampling results across tuning parameters:
## 
##   interaction.depth  n.trees  Accuracy   Kappa      Accuracy SD 
##   1                   50      0.8126066  0.7623134  0.0087551100
##   1                  100      0.8875232  0.8575833  0.0045534695
##   1                  150      0.9167766  0.8946455  0.0038624492
##   2                   50      0.9355816  0.9184556  0.0061328872
##   2                  100      0.9789524  0.9733700  0.0025635264
##   2                  150      0.9918458  0.9896862  0.0019669008
##   3                   50      0.9690144  0.9607919  0.0020502817
##   3                  100      0.9931709  0.9913622  0.0015424073
##   3                  150      0.9967383  0.9958744  0.0007287033
##   Kappa SD    
##   0.0110833293
##   0.0057706760
##   0.0048911897
##   0.0077580233
##   0.0032452601
##   0.0024876651
##   0.0025978419
##   0.0019508530
##   0.0009215854
## 
## Tuning parameter 'shrinkage' was held constant at a value of 0.1
## 
## Tuning parameter 'n.minobsinnode' was held constant at a value of 10
## Accuracy was used to select the optimal model using  the largest value.
## The final values used for the model were n.trees = 150,
##  interaction.depth = 3, shrinkage = 0.1 and n.minobsinnode = 10.
```

```r
andomForestModel
```

```
## Error in eval(expr, envir, enclos): object 'andomForestModel' not found
```

As we can see, both of the models do very well. Almost perfect predictions. Training uses cross validation and chooses the model which generalizes best on the validation set. Random Forest did marginally better and is chosen for submission. 

After choosing the right model, it is used on testing set and is submitted to Coursera for grading:


```r
prediction <- predict(boostModel, dataPMLtest)

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("./predictions/problem_id_", i, ".txt")
    write.table(x[i], file = filename, quote = FALSE, row.names = FALSE, col.names = FALSE)
  }
}
pml_write_files(prediction)
```

```
## Warning in file(file, ifelse(append, "a", "w")): cannot open file './
## predictions/problem_id_1.txt': No such file or directory
```

```
## Error in file(file, ifelse(append, "a", "w")): cannot open the connection
```

