# Practical Machine Learning: Excercise Quality Prediction

## Introduction / Executive summary

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants was used to predict the quality of technique employed.

## Loading and exploring the data set

In first part of the code, data sets is loaded and partially cleaned. Useless columns and columns with near zero variance are excluded from the dataset. Type of exercises empoyed are classified as numbers from 1 to 5. Also parallel computing is setup with doMC library.



After cleaning the data, several prediction models were trained - Global Boost Machine, Random Forest.


```r
boostModel <- train(classe ~ ., method = "gbm", data = dataPML, trControl = trainControl(method = "cv", number = 10, allowParallel = TRUE))
```

```
FALSE Iter   TrainDeviance   ValidDeviance   StepSize   Improve
FALSE      1        1.6094            -nan     0.1000    0.2417
FALSE      2        1.4566            -nan     0.1000    0.1706
FALSE      3        1.3488            -nan     0.1000    0.1304
FALSE      4        1.2663            -nan     0.1000    0.1173
FALSE      5        1.1938            -nan     0.1000    0.0966
FALSE      6        1.1325            -nan     0.1000    0.0861
FALSE      7        1.0791            -nan     0.1000    0.0935
FALSE      8        1.0222            -nan     0.1000    0.0671
FALSE      9        0.9809            -nan     0.1000    0.0682
FALSE     10        0.9399            -nan     0.1000    0.0557
FALSE     20        0.6225            -nan     0.1000    0.0426
FALSE     40        0.3444            -nan     0.1000    0.0122
FALSE     60        0.2056            -nan     0.1000    0.0087
FALSE     80        0.1306            -nan     0.1000    0.0051
FALSE    100        0.0892            -nan     0.1000    0.0020
FALSE    120        0.0647            -nan     0.1000    0.0026
FALSE    140        0.0474            -nan     0.1000    0.0006
FALSE    150        0.0417            -nan     0.1000    0.0005
```

```r
randomForestModel <- train(classe ~ ., method = "rf", data = dataPML, importance = T, trControl = trainControl(method = "cv", number = 10, allowParallel = TRUE))
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
## Summary of sample sizes: 17660, 17662, 17659, 17661, 17661, 17660, ... 
## Resampling results across tuning parameters:
## 
##   interaction.depth  n.trees  Accuracy   Kappa      Accuracy SD
##   1                   50      0.8130132  0.7628505  0.013238517
##   1                  100      0.8884400  0.8587444  0.010979899
##   1                  150      0.9150949  0.8925042  0.006546029
##   2                   50      0.9368067  0.9200050  0.008418745
##   2                  100      0.9785953  0.9729197  0.002729629
##   2                  150      0.9919478  0.9898148  0.002158776
##   3                   50      0.9700336  0.9620818  0.004117025
##   3                  100      0.9933753  0.9916207  0.001458534
##   3                  150      0.9972992  0.9965838  0.001101443
##   Kappa SD   
##   0.016797823
##   0.013890497
##   0.008317837
##   0.010667078
##   0.003453829
##   0.002730365
##   0.005216169
##   0.001844462
##   0.001393123
## 
## Tuning parameter 'shrinkage' was held constant at a value of 0.1
## 
## Tuning parameter 'n.minobsinnode' was held constant at a value of 10
## Accuracy was used to select the optimal model using  the largest value.
## The final values used for the model were n.trees = 150,
##  interaction.depth = 3, shrinkage = 0.1 and n.minobsinnode = 10.
```

```r
randomForestModel
```

```
## Random Forest 
## 
## 19622 samples
##    55 predictors
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## Summary of sample sizes: 17658, 17660, 17660, 17660, 17660, 17660, ... 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa      Accuracy SD   Kappa SD    
##    2    0.9977575  0.9971635  0.0007678212  0.0009713746
##   28    0.9994393  0.9992907  0.0004464648  0.0005647562
##   55    0.9988277  0.9985172  0.0007228565  0.0009143186
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 28.
```

As we can see, both of the models do very well. Almost perfect predictions. Training uses cross validation and chooses the model which generalizes best on the validation set. Random Forest did marginally better and is chosen for submission. 

After choosing the right model, it is used on testing set and is submitted to Coursera for grading:



