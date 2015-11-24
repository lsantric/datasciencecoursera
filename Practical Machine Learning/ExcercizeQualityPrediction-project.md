# Practical Machine Learning: Excercise Quality Prediction

## Introduction / Executive summary

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants was used to predict the quality of technique employed.

## Loading and exploring the data set

In first part of the code, data sets is loaded and cleaned. Useless columns with near zero variance and filled with missing data are excluded from the dataset. Type of exercises empoyed are classified as numbers from 1 to 5. Also parallel computing is setup with doMC library.



After cleaning the data, several prediction models were trained - Global Boost Machine, Random Forest.


```
FALSE Iter   TrainDeviance   ValidDeviance   StepSize   Improve
FALSE      1        1.6094            -nan     0.1000    0.2457
FALSE      2        1.4556            -nan     0.1000    0.1674
FALSE      3        1.3520            -nan     0.1000    0.1468
FALSE      4        1.2614            -nan     0.1000    0.1016
FALSE      5        1.1965            -nan     0.1000    0.1071
FALSE      6        1.1301            -nan     0.1000    0.0879
FALSE      7        1.0758            -nan     0.1000    0.0773
FALSE      8        1.0268            -nan     0.1000    0.0830
FALSE      9        0.9766            -nan     0.1000    0.0633
FALSE     10        0.9386            -nan     0.1000    0.0679
FALSE     20        0.6244            -nan     0.1000    0.0321
FALSE     40        0.3479            -nan     0.1000    0.0211
FALSE     60        0.2056            -nan     0.1000    0.0054
FALSE     80        0.1343            -nan     0.1000    0.0050
FALSE    100        0.0938            -nan     0.1000    0.0027
FALSE    120        0.0672            -nan     0.1000    0.0018
FALSE    140        0.0495            -nan     0.1000    0.0007
FALSE    150        0.0432            -nan     0.1000    0.0011
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
## Summary of sample sizes: 17660, 17659, 17661, 17659, 17661, 17659, ... 
## Resampling results across tuning parameters:
## 
##   interaction.depth  n.trees  Accuracy   Kappa      Accuracy SD
##   1                   50      0.8118963  0.7613699  0.010219541
##   1                  100      0.8880847  0.8583042  0.009219833
##   1                  150      0.9160634  0.8937421  0.007584237
##   2                   50      0.9352260  0.9180121  0.008195721
##   2                  100      0.9791552  0.9736286  0.004231742
##   2                  150      0.9916418  0.9894280  0.001652157
##   3                   50      0.9683519  0.9599558  0.003435889
##   3                  100      0.9932726  0.9914910  0.002106781
##   3                  150      0.9971971  0.9964548  0.001133015
##   Kappa SD   
##   0.012998374
##   0.011704685
##   0.009608225
##   0.010378517
##   0.005354056
##   0.002089188
##   0.004347553
##   0.002664057
##   0.001433070
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
## Summary of sample sizes: 17660, 17661, 17659, 17660, 17659, 17661, ... 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa      Accuracy SD   Kappa SD    
##    2    0.9979614  0.9974215  0.0008662120  0.0010956899
##   28    0.9993373  0.9991618  0.0006818957  0.0008625569
##   55    0.9990825  0.9988394  0.0007130952  0.0009020548
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 28.
```

As we can see, both of the models do very well. They achieve almost perfect predictions with accuracy of ~ 0.99. It means they almost always correctly classify quality of excercize. Training uses cross validation and chooses the model which generalizes best on the validation set. Random Forest did marginally better and is chosen for submission. 

After choosing the right model, it is used on testing set and is submitted to Coursera for grading:


```r
prediction <- predict(randomForestModel, dataPMLtest)

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("./TestPredictions/problem_id_", i, ".txt")
    write.table(x[i], file = filename, quote = FALSE, row.names = FALSE, col.names = FALSE)
  }
}
pml_write_files(prediction)
```

