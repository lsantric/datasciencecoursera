# Practical Machine Learning: Excercise Quality Prediction

## Introduction / Executive summary

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants was used to predict the quality of technique employed.

## Loading and exploring the data set

In first part of the code, data sets is loaded and cleaned. Useless columns with near zero variance and filled with missing data are excluded from the dataset. Type of exercises empoyed are classified as numbers from 1 to 5. Also parallel computing is setup with doMC library.



After cleaning the data, several prediction models were trained - Global Boost Machine, Random Forest.


```
FALSE Iter   TrainDeviance   ValidDeviance   StepSize   Improve
FALSE      1        1.6094            -nan     0.1000    0.2489
FALSE      2        1.4536            -nan     0.1000    0.1687
FALSE      3        1.3479            -nan     0.1000    0.1313
FALSE      4        1.2652            -nan     0.1000    0.1161
FALSE      5        1.1920            -nan     0.1000    0.0824
FALSE      6        1.1393            -nan     0.1000    0.0862
FALSE      7        1.0854            -nan     0.1000    0.0858
FALSE      8        1.0337            -nan     0.1000    0.0789
FALSE      9        0.9858            -nan     0.1000    0.0723
FALSE     10        0.9410            -nan     0.1000    0.0617
FALSE     20        0.6268            -nan     0.1000    0.0392
FALSE     40        0.3384            -nan     0.1000    0.0161
FALSE     60        0.2007            -nan     0.1000    0.0080
FALSE     80        0.1322            -nan     0.1000    0.0037
FALSE    100        0.0931            -nan     0.1000    0.0023
FALSE    120        0.0674            -nan     0.1000    0.0018
FALSE    140        0.0480            -nan     0.1000    0.0007
FALSE    150        0.0425            -nan     0.1000    0.0006
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
## Summary of sample sizes: 17659, 17660, 17659, 17659, 17660, 17660, ... 
## Resampling results across tuning parameters:
## 
##   interaction.depth  n.trees  Accuracy   Kappa      Accuracy SD
##   1                   50      0.8148010  0.7650974  0.008174623
##   1                  100      0.8863037  0.8560462  0.008675438
##   1                  150      0.9158616  0.8934928  0.007671310
##   2                   50      0.9356856  0.9185938  0.007834348
##   2                  100      0.9795125  0.9740802  0.003667243
##   2                  150      0.9919476  0.9898148  0.001662107
##   3                   50      0.9696252  0.9615627  0.005918405
##   3                  100      0.9926105  0.9906535  0.001954490
##   3                  150      0.9971461  0.9963902  0.001363045
##   Kappa SD   
##   0.010445929
##   0.011001013
##   0.009707269
##   0.009917962
##   0.004641820
##   0.002102214
##   0.007495305
##   0.002471501
##   0.001723940
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
## Summary of sample sizes: 17660, 17661, 17659, 17660, 17661, 17659, ... 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa      Accuracy SD   Kappa SD    
##    2    0.9977070  0.9970996  0.0015044752  0.0019030029
##   28    0.9994393  0.9992908  0.0006101552  0.0007717624
##   55    0.9987767  0.9984526  0.0007290861  0.0009222461
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 28.
```

As we can see, both of the models do very well. They achieve almost perfect predictions with accuracy of ~ 0.99. It means they almost always correctly classify quality of excercize. Training uses cross validation and chooses the model which generalizes best on the validation set. Random Forest did marginally better and is chosen for submission. 

After choosing the right model, it is used on testing set and is submitted to Coursera for grading:



