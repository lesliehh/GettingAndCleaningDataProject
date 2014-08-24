---
title: "CodeBook"
date: "Sunday, August 24, 2014"
output: html_document
---

This file describes the variables, the data, and any transformations or work that was performed to clean up the data.

## Data structure

- The final strucutre of the data has 562 variables with 10299 observations.
- The first column is "subject," which is the ID of the subject
- The second column is the "activity," which contains the activity that a specific subject performed
- From the 3rd to the 562nd column are the different measurements for each pair of subject/activity

## Data transformation in R

### Download and unzip the files

```r
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
file <- "../ProjectData.zip";
download.file(url, destfile = file);
unzip(file);
```

### Load the files into R

```r
# Loan the feature and activity files
features <- read.table("../UCI HAR Dataset/features.txt");
activities <- read.table("../UCI HAR Dataset/activity_labels.txt");
# Load the test files
test_subject <- read.table("../UCI HAR Dataset/test/subject_test.txt");
test_x <- read.table("../UCI HAR Dataset/test/X_test.txt");
test_y <- read.table("../UCI HAR Dataset/test/y_test.txt");
# Load the train files
train_subject <- read.table("../UCI HAR Dataset/train/subject_train.txt");
train_x <- read.table("../UCI HAR Dataset/train/X_train.txt");
train_y <- read.table("../UCI HAR Dataset/train/y_train.txt");
```

### Merge the training and the test sets to create one data set

```r
names(activities) <- c("activity_label", "activity");
# Merge subject, activity and type data for test set
names(test_subject) <- c("subject");
names(test_y) <- c("activity_label");
names(test_x) <- unlist(features[,2]);
test_activity <- merge(test_y, activities, by = "activity_label");
test_data <- cbind(test_subject, test_activity, test_x)
# Merge subject, activity and type data for train set
names(train_subject) <- c("subject");
names(train_y) <- c("activity_label");
names(train_x) <- unlist(features[,2]);
train_activity <- merge(train_y, activities, by = "activity_label");
train_data <- cbind(train_subject, train_activity, train_x);
# Merge the test and train set
data <- rbind(test_data, train_data);
data <- data[,c(1,3:563)];
```

### Output a subset of the data to verify the structure

```r
head(data[, 1:5])
```

```
##   subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 1       2  WALKING            0.2572          -0.02329          -0.01465
## 2       2  WALKING            0.2860          -0.01316          -0.11908
## 3       2  WALKING            0.2755          -0.02605          -0.11815
## 4       2  WALKING            0.2703          -0.03261          -0.11752
## 5       2  WALKING            0.2748          -0.02785          -0.12953
## 6       2  WALKING            0.2792          -0.01862          -0.11390
```

### See how the data is structred
#### Get the size of the data

```r
print(object.size(data), units="Mb")
```

```
## 44.2 Mb
```
#### Get a summary of the data

```r
summary(data);
```

```
##     subject                   activity    tBodyAcc-mean()-X
##  Min.   : 1.0   LAYING            :1944   Min.   :-1.000   
##  1st Qu.: 9.0   SITTING           :1777   1st Qu.: 0.263   
##  Median :17.0   STANDING          :1906   Median : 0.277   
##  Mean   :16.1   WALKING           :1722   Mean   : 0.274   
##  3rd Qu.:24.0   WALKING_DOWNSTAIRS:1406   3rd Qu.: 0.288   
##  Max.   :30.0   WALKING_UPSTAIRS  :1544   Max.   : 1.000   
##  tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y 
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.0249   1st Qu.:-0.1210   1st Qu.:-0.992   1st Qu.:-0.9770  
##  Median :-0.0172   Median :-0.1086   Median :-0.943   Median :-0.8350  
##  Mean   :-0.0177   Mean   :-0.1089   Mean   :-0.608   Mean   :-0.5102  
##  3rd Qu.:-0.0106   3rd Qu.:-0.0976   3rd Qu.:-0.250   3rd Qu.:-0.0573  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000   Max.   : 1.0000  
##  tBodyAcc-std()-Z tBodyAcc-mad()-X tBodyAcc-mad()-Y  tBodyAcc-mad()-Z
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.979   1st Qu.:-0.993   1st Qu.:-0.9770   1st Qu.:-0.979  
##  Median :-0.851   Median :-0.948   Median :-0.8437   Median :-0.845  
##  Mean   :-0.613   Mean   :-0.634   Mean   :-0.5257   Mean   :-0.615  
##  3rd Qu.:-0.279   3rd Qu.:-0.302   3rd Qu.:-0.0874   3rd Qu.:-0.288  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##  tBodyAcc-max()-X  tBodyAcc-max()-Y  tBodyAcc-max()-Z tBodyAcc-min()-X
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9358   1st Qu.:-0.5626   1st Qu.:-0.812   1st Qu.: 0.212  
##  Median :-0.8748   Median :-0.4682   Median :-0.725   Median : 0.784  
##  Mean   :-0.4667   Mean   :-0.3052   Mean   :-0.562   Mean   : 0.525  
##  3rd Qu.:-0.0146   3rd Qu.:-0.0673   3rd Qu.:-0.346   3rd Qu.: 0.844  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000  
##  tBodyAcc-min()-Y tBodyAcc-min()-Z tBodyAcc-sma()   tBodyAcc-energy()-X
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000     
##  1st Qu.: 0.114   1st Qu.: 0.393   1st Qu.:-0.982   1st Qu.:-1.000     
##  Median : 0.620   Median : 0.772   Median :-0.877   Median :-0.998     
##  Mean   : 0.390   Mean   : 0.598   Mean   :-0.552   Mean   :-0.826     
##  3rd Qu.: 0.685   3rd Qu.: 0.837   3rd Qu.:-0.123   3rd Qu.:-0.716     
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000     
##  tBodyAcc-energy()-Y tBodyAcc-energy()-Z tBodyAcc-iqr()-X tBodyAcc-iqr()-Y
##  Min.   :-1.000      Min.   :-1.000      Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000      1st Qu.:-0.999      1st Qu.:-0.994   1st Qu.:-0.981  
##  Median :-0.993      Median :-0.984      Median :-0.956   Median :-0.885  
##  Mean   :-0.903      Mean   :-0.855      Mean   :-0.689   Mean   :-0.643  
##  3rd Qu.:-0.825      3rd Qu.:-0.759      3rd Qu.:-0.408   3rd Qu.:-0.325  
##  Max.   : 1.000      Max.   : 1.000      Max.   : 1.000   Max.   : 1.000  
##  tBodyAcc-iqr()-Z tBodyAcc-entropy()-X tBodyAcc-entropy()-Y
##  Min.   :-1.000   Min.   :-1.0000      Min.   :-1.000      
##  1st Qu.:-0.979   1st Qu.:-0.5638      1st Qu.:-0.550      
##  Median :-0.854   Median :-0.0571      Median :-0.102      
##  Mean   :-0.641   Mean   :-0.1003      Mean   :-0.129      
##  3rd Qu.:-0.336   3rd Qu.: 0.3296      3rd Qu.: 0.283      
##  Max.   : 1.000   Max.   : 1.0000      Max.   : 1.000      
##  tBodyAcc-entropy()-Z tBodyAcc-arCoeff()-X,1 tBodyAcc-arCoeff()-X,2
##  Min.   :-1.000       Min.   :-1.000         Min.   :-1.0000       
##  1st Qu.:-0.497       1st Qu.:-0.369         1st Qu.:-0.0790       
##  Median :-0.136       Median :-0.136         Median : 0.0775       
##  Mean   :-0.158       Mean   :-0.119         Mean   : 0.1086       
##  3rd Qu.: 0.167       3rd Qu.: 0.133         3rd Qu.: 0.2861       
##  Max.   : 1.000       Max.   : 1.000         Max.   : 1.0000       
##  tBodyAcc-arCoeff()-X,3 tBodyAcc-arCoeff()-X,4 tBodyAcc-arCoeff()-Y,1
##  Min.   :-1.0000        Min.   :-1.0000        Min.   :-1.0000       
##  1st Qu.:-0.1899        1st Qu.:-0.0339        1st Qu.:-0.2220       
##  Median :-0.0176        Median : 0.1263        Median :-0.0455       
##  Mean   :-0.0357        Mean   : 0.1220        Mean   :-0.0297       
##  3rd Qu.: 0.1333        3rd Qu.: 0.2777        3rd Qu.: 0.1633       
##  Max.   : 1.0000        Max.   : 1.0000        Max.   : 1.0000       
##  tBodyAcc-arCoeff()-Y,2 tBodyAcc-arCoeff()-Y,3 tBodyAcc-arCoeff()-Y,4
##  Min.   :-1.0000        Min.   :-1.000         Min.   :-1.0000       
##  1st Qu.:-0.1290        1st Qu.: 0.029         1st Qu.:-0.1657       
##  Median : 0.0177        Median : 0.161         Median :-0.0189       
##  Mean   : 0.0317        Mean   : 0.155         Mean   :-0.0181       
##  3rd Qu.: 0.1808        3rd Qu.: 0.288         3rd Qu.: 0.1312       
##  Max.   : 1.0000        Max.   : 1.000         Max.   : 1.0000       
##  tBodyAcc-arCoeff()-Z,1 tBodyAcc-arCoeff()-Z,2 tBodyAcc-arCoeff()-Z,3
##  Min.   :-1.0000        Min.   :-1.0000        Min.   :-1.0000       
##  1st Qu.:-0.2065        1st Qu.:-0.1181        1st Qu.:-0.1108       
##  Median : 0.0207        Median : 0.0099        Median : 0.0454       
##  Mean   : 0.0061        Mean   : 0.0377        Mean   : 0.0344       
##  3rd Qu.: 0.2235        3rd Qu.: 0.1796        3rd Qu.: 0.1943       
##  Max.   : 1.0000        Max.   : 1.0000        Max.   : 1.0000       
##  tBodyAcc-arCoeff()-Z,4 tBodyAcc-correlation()-X,Y
##  Min.   :-1.0000        Min.   :-1.0000           
##  1st Qu.:-0.2395        1st Qu.:-0.3617           
##  Median :-0.0833        Median :-0.1612           
##  Mean   :-0.0827        Mean   :-0.1203           
##  3rd Qu.: 0.0747        3rd Qu.: 0.0801           
##  Max.   : 1.0000        Max.   : 1.0000           
##  tBodyAcc-correlation()-X,Z tBodyAcc-correlation()-Y,Z
##  Min.   :-1.0000            Min.   :-1.000            
##  1st Qu.:-0.4088            1st Qu.:-0.141            
##  Median :-0.1918            Median : 0.136            
##  Mean   :-0.1977            Mean   : 0.102            
##  3rd Qu.: 0.0025            3rd Qu.: 0.372            
##  Max.   : 1.0000            Max.   : 1.000            
##  tGravityAcc-mean()-X tGravityAcc-mean()-Y tGravityAcc-mean()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.0000     
##  1st Qu.: 0.812       1st Qu.:-0.243       1st Qu.:-0.1167     
##  Median : 0.922       Median :-0.144       Median : 0.0368     
##  Mean   : 0.669       Mean   : 0.004       Mean   : 0.0922     
##  3rd Qu.: 0.955       3rd Qu.: 0.119       3rd Qu.: 0.2162     
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.0000     
##  tGravityAcc-std()-X tGravityAcc-std()-Y tGravityAcc-std()-Z
##  Min.   :-1.000      Min.   :-1.000      Min.   :-1.000     
##  1st Qu.:-0.995      1st Qu.:-0.991      1st Qu.:-0.987     
##  Median :-0.982      Median :-0.976      Median :-0.967     
##  Mean   :-0.965      Mean   :-0.954      Mean   :-0.939     
##  3rd Qu.:-0.962      3rd Qu.:-0.946      3rd Qu.:-0.930     
##  Max.   : 1.000      Max.   : 1.000      Max.   : 1.000     
##  tGravityAcc-mad()-X tGravityAcc-mad()-Y tGravityAcc-mad()-Z
##  Min.   :-1.000      Min.   :-1.000      Min.   :-1.000     
##  1st Qu.:-0.995      1st Qu.:-0.992      1st Qu.:-0.987     
##  Median :-0.983      Median :-0.977      Median :-0.968     
##  Mean   :-0.966      Mean   :-0.955      Mean   :-0.940     
##  3rd Qu.:-0.963      3rd Qu.:-0.948      3rd Qu.:-0.931     
##  Max.   : 1.000      Max.   : 1.000      Max.   : 1.000     
##  tGravityAcc-max()-X tGravityAcc-max()-Y tGravityAcc-max()-Z
##  Min.   :-1.000      Min.   :-1.0000     Min.   :-1.0000    
##  1st Qu.: 0.756      1st Qu.:-0.2496     1st Qu.:-0.1116    
##  Median : 0.859      Median :-0.1509     Median : 0.0430    
##  Mean   : 0.609      Mean   :-0.0103     Mean   : 0.0967    
##  3rd Qu.: 0.888      3rd Qu.: 0.1179     3rd Qu.: 0.2168    
##  Max.   : 1.000      Max.   : 1.0000     Max.   : 1.0000    
##  tGravityAcc-min()-X tGravityAcc-min()-Y tGravityAcc-min()-Z
##  Min.   :-1.000      Min.   :-1.0000     Min.   :-1.0000    
##  1st Qu.: 0.817      1st Qu.:-0.2296     1st Qu.:-0.1326    
##  Median : 0.929      Median :-0.1284     Median : 0.0222    
##  Mean   : 0.684      Mean   : 0.0166     Mean   : 0.0793    
##  3rd Qu.: 0.967      3rd Qu.: 0.1290     3rd Qu.: 0.1998    
##  Max.   : 1.000      Max.   : 1.0000     Max.   : 1.0000    
##  tGravityAcc-sma() tGravityAcc-energy()-X tGravityAcc-energy()-Y
##  Min.   :-1.0000   Min.   :-1.000         Min.   :-1.000        
##  1st Qu.:-0.4093   1st Qu.: 0.521         1st Qu.:-0.968        
##  Median :-0.1313   Median : 0.791         Median :-0.910        
##  Mean   :-0.0986   Mean   : 0.446         Mean   :-0.722        
##  3rd Qu.: 0.1884   3rd Qu.: 0.877         3rd Qu.:-0.767        
##  Max.   : 1.0000   Max.   : 1.000         Max.   : 1.000        
##  tGravityAcc-energy()-Z tGravityAcc-iqr()-X tGravityAcc-iqr()-Y
##  Min.   :-1.000         Min.   :-1.000      Min.   :-1.000     
##  1st Qu.:-0.991         1st Qu.:-0.995      1st Qu.:-0.992     
##  Median :-0.951         Median :-0.985      Median :-0.980     
##  Mean   :-0.764         Mean   :-0.968      Mean   :-0.959     
##  3rd Qu.:-0.787         3rd Qu.:-0.966      3rd Qu.:-0.952     
##  Max.   : 1.000         Max.   : 1.000      Max.   : 1.000     
##  tGravityAcc-iqr()-Z tGravityAcc-entropy()-X tGravityAcc-entropy()-Y
##  Min.   :-1.000      Min.   :-1.000          Min.   :-1.000         
##  1st Qu.:-0.988      1st Qu.:-1.000          1st Qu.:-1.000         
##  Median :-0.971      Median :-0.763          Median :-1.000         
##  Mean   :-0.945      Mean   :-0.675          Mean   :-0.867         
##  3rd Qu.:-0.938      3rd Qu.:-0.400          3rd Qu.:-0.851         
##  Max.   : 1.000      Max.   : 1.000          Max.   : 1.000         
##  tGravityAcc-entropy()-Z tGravityAcc-arCoeff()-X,1
##  Min.   :-1.000          Min.   :-1.000           
##  1st Qu.:-1.000          1st Qu.:-0.651           
##  Median :-0.781          Median :-0.510           
##  Mean   :-0.669          Mean   :-0.504           
##  3rd Qu.:-0.401          3rd Qu.:-0.367           
##  Max.   : 1.000          Max.   : 1.000           
##  tGravityAcc-arCoeff()-X,2 tGravityAcc-arCoeff()-X,3
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.: 0.405            1st Qu.:-0.739           
##  Median : 0.555            Median :-0.597           
##  Mean   : 0.543            Mean   :-0.581           
##  3rd Qu.: 0.693            3rd Qu.:-0.440           
##  Max.   : 1.000            Max.   : 1.000           
##  tGravityAcc-arCoeff()-X,4 tGravityAcc-arCoeff()-Y,1
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.: 0.471            1st Qu.:-0.546           
##  Median : 0.642            Median :-0.342           
##  Mean   : 0.618            Mean   :-0.344           
##  3rd Qu.: 0.785            3rd Qu.:-0.143           
##  Max.   : 1.000            Max.   : 1.000           
##  tGravityAcc-arCoeff()-Y,2 tGravityAcc-arCoeff()-Y,3
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.: 0.128            1st Qu.:-0.558           
##  Median : 0.329            Median :-0.366           
##  Mean   : 0.330            Mean   :-0.361           
##  3rd Qu.: 0.535            3rd Qu.:-0.173           
##  Max.   : 1.000            Max.   : 1.000           
##  tGravityAcc-arCoeff()-Y,4 tGravityAcc-arCoeff()-Z,1
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.: 0.230            1st Qu.:-0.620           
##  Median : 0.424            Median :-0.426           
##  Mean   : 0.409            Mean   :-0.428           
##  3rd Qu.: 0.605            3rd Qu.:-0.249           
##  Max.   : 1.000            Max.   : 1.000           
##  tGravityAcc-arCoeff()-Z,2 tGravityAcc-arCoeff()-Z,3
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.: 0.279            1st Qu.:-0.663           
##  Median : 0.450            Median :-0.479           
##  Mean   : 0.453            Mean   :-0.478           
##  3rd Qu.: 0.642            3rd Qu.:-0.307           
##  Max.   : 1.000            Max.   : 1.000           
##  tGravityAcc-arCoeff()-Z,4 tGravityAcc-correlation()-X,Y
##  Min.   :-1.000            Min.   :-1.000               
##  1st Qu.: 0.331            1st Qu.:-0.490               
##  Median : 0.505            Median : 0.361               
##  Mean   : 0.499            Mean   : 0.176               
##  3rd Qu.: 0.684            3rd Qu.: 0.838               
##  Max.   : 1.000            Max.   : 1.000               
##  tGravityAcc-correlation()-X,Z tGravityAcc-correlation()-Y,Z
##  Min.   :-1.000                Min.   :-1.0000              
##  1st Qu.:-0.806                1st Qu.:-0.6090              
##  Median :-0.217                Median : 0.1754              
##  Mean   :-0.108                Mean   : 0.0848              
##  3rd Qu.: 0.591                3rd Qu.: 0.7760              
##  Max.   : 1.000                Max.   : 1.0000              
##  tBodyAccJerk-mean()-X tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z
##  Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000      
##  1st Qu.: 0.0630       1st Qu.:-0.0186       1st Qu.:-0.0316      
##  Median : 0.0760       Median : 0.0108       Median :-0.0012      
##  Mean   : 0.0789       Mean   : 0.0079       Mean   :-0.0047      
##  3rd Qu.: 0.0913       3rd Qu.: 0.0335       3rd Qu.: 0.0246      
##  Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000      
##  tBodyAccJerk-std()-X tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.991       1st Qu.:-0.985       1st Qu.:-0.989      
##  Median :-0.951       Median :-0.925       Median :-0.954      
##  Mean   :-0.640       Mean   :-0.608       Mean   :-0.763      
##  3rd Qu.:-0.291       3rd Qu.:-0.222       3rd Qu.:-0.548      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  tBodyAccJerk-mad()-X tBodyAccJerk-mad()-Y tBodyAccJerk-mad()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.991       1st Qu.:-0.983       1st Qu.:-0.988      
##  Median :-0.958       Median :-0.926       Median :-0.955      
##  Mean   :-0.637       Mean   :-0.594       Mean   :-0.756      
##  3rd Qu.:-0.280       3rd Qu.:-0.189       3rd Qu.:-0.536      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  tBodyAccJerk-max()-X tBodyAccJerk-max()-Y tBodyAccJerk-max()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.992       1st Qu.:-0.990       1st Qu.:-0.990      
##  Median :-0.945       Median :-0.941       Median :-0.956      
##  Mean   :-0.700       Mean   :-0.748       Mean   :-0.819      
##  3rd Qu.:-0.461       3rd Qu.:-0.535       3rd Qu.:-0.683      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  tBodyAccJerk-min()-X tBodyAccJerk-min()-Y tBodyAccJerk-min()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.: 0.253       1st Qu.: 0.402       1st Qu.: 0.529      
##  Median : 0.938       Median : 0.931       Median : 0.940      
##  Mean   : 0.616       Mean   : 0.685       Mean   : 0.740      
##  3rd Qu.: 0.990       3rd Qu.: 0.989       3rd Qu.: 0.987      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  tBodyAccJerk-sma() tBodyAccJerk-energy()-X tBodyAccJerk-energy()-Y
##  Min.   :-1.000     Min.   :-1.000          Min.   :-1.000         
##  1st Qu.:-0.990     1st Qu.:-1.000          1st Qu.:-1.000         
##  Median :-0.948     Median :-0.999          Median :-0.997         
##  Mean   :-0.647     Mean   :-0.850          Mean   :-0.827         
##  3rd Qu.:-0.291     3rd Qu.:-0.746          3rd Qu.:-0.692         
##  Max.   : 1.000     Max.   : 1.000          Max.   : 1.000         
##  tBodyAccJerk-energy()-Z tBodyAccJerk-iqr()-X tBodyAccJerk-iqr()-Y
##  Min.   :-1.000          Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-1.000          1st Qu.:-0.990       1st Qu.:-0.984      
##  Median :-0.998          Median :-0.963       Median :-0.943      
##  Mean   :-0.931          Mean   :-0.627       Mean   :-0.660      
##  3rd Qu.:-0.893          3rd Qu.:-0.266       3rd Qu.:-0.330      
##  Max.   : 1.000          Max.   : 1.000       Max.   : 1.000      
##  tBodyAccJerk-iqr()-Z tBodyAccJerk-entropy()-X tBodyAccJerk-entropy()-Y
##  Min.   :-1.000       Min.   :-1.0000          Min.   :-1.0000         
##  1st Qu.:-0.986       1st Qu.:-0.7298          1st Qu.:-0.7263         
##  Median :-0.958       Median :-0.3377          Median :-0.2842         
##  Mean   :-0.771       Mean   :-0.0826          Mean   :-0.0879         
##  3rd Qu.:-0.576       3rd Qu.: 0.5994          3rd Qu.: 0.5678         
##  Max.   : 1.000       Max.   : 1.0000          Max.   : 1.0000         
##  tBodyAccJerk-entropy()-Z tBodyAccJerk-arCoeff()-X,1
##  Min.   :-1.000           Min.   :-1.000            
##  1st Qu.:-0.721           1st Qu.:-0.360            
##  Median :-0.394           Median :-0.116            
##  Mean   :-0.127           Mean   :-0.109            
##  3rd Qu.: 0.494           3rd Qu.: 0.144            
##  Max.   : 1.000           Max.   : 1.000            
##  tBodyAccJerk-arCoeff()-X,2 tBodyAccJerk-arCoeff()-X,3
##  Min.   :-1.0000            Min.   :-1.0000           
##  1st Qu.: 0.0489            1st Qu.:-0.0878           
##  Median : 0.1729            Median : 0.0772           
##  Mean   : 0.1697            Mean   : 0.0676           
##  3rd Qu.: 0.2916            3rd Qu.: 0.2343           
##  Max.   : 1.0000            Max.   : 1.0000           
##  tBodyAccJerk-arCoeff()-X,4 tBodyAccJerk-arCoeff()-Y,1
##  Min.   :-1.0000            Min.   :-1.0000           
##  1st Qu.:-0.0036            1st Qu.:-0.2766           
##  Median : 0.1348            Median :-0.0858           
##  Mean   : 0.1265            Mean   :-0.0727           
##  3rd Qu.: 0.2636            3rd Qu.: 0.1399           
##  Max.   : 1.0000            Max.   : 1.0000           
##  tBodyAccJerk-arCoeff()-Y,2 tBodyAccJerk-arCoeff()-Y,3
##  Min.   :-1.0000            Min.   :-1.0000           
##  1st Qu.:-0.0650            1st Qu.: 0.0225           
##  Median : 0.0670            Median : 0.1865           
##  Mean   : 0.0687            Mean   : 0.1745           
##  3rd Qu.: 0.2073            3rd Qu.: 0.3393           
##  Max.   : 1.0000            Max.   : 1.0000           
##  tBodyAccJerk-arCoeff()-Y,4 tBodyAccJerk-arCoeff()-Z,1
##  Min.   :-1.000             Min.   :-1.0000           
##  1st Qu.: 0.185             1st Qu.:-0.2374           
##  Median : 0.318             Median :-0.0135           
##  Mean   : 0.314             Mean   :-0.0327           
##  3rd Qu.: 0.452             3rd Qu.: 0.1801           
##  Max.   : 1.000             Max.   : 1.0000           
##  tBodyAccJerk-arCoeff()-Z,2 tBodyAccJerk-arCoeff()-Z,3
##  Min.   :-1.0000            Min.   :-1.0000           
##  1st Qu.:-0.0356            1st Qu.:-0.1433           
##  Median : 0.0874            Median : 0.0133           
##  Mean   : 0.0887            Mean   :-0.0010           
##  3rd Qu.: 0.2125            3rd Qu.: 0.1582           
##  Max.   : 1.0000            Max.   : 1.0000           
##  tBodyAccJerk-arCoeff()-Z,4 tBodyAccJerk-correlation()-X,Y
##  Min.   :-1.0000            Min.   :-1.0000               
##  1st Qu.:-0.0155            1st Qu.:-0.3099               
##  Median : 0.1502            Median :-0.1390               
##  Mean   : 0.1385            Mean   :-0.1381               
##  3rd Qu.: 0.3001            3rd Qu.: 0.0287               
##  Max.   : 1.0000            Max.   : 1.0000               
##  tBodyAccJerk-correlation()-X,Z tBodyAccJerk-correlation()-Y,Z
##  Min.   :-1.0000                Min.   :-1.0000               
##  1st Qu.:-0.1987                1st Qu.:-0.1025               
##  Median : 0.0133                Median : 0.0761               
##  Mean   : 0.0030                Mean   : 0.0803               
##  3rd Qu.: 0.2070                3rd Qu.: 0.2634               
##  Max.   : 1.0000                Max.   : 1.0000               
##  tBodyGyro-mean()-X tBodyGyro-mean()-Y tBodyGyro-mean()-Z
##  Min.   :-1.0000    Min.   :-1.0000    Min.   :-1.0000   
##  1st Qu.:-0.0458    1st Qu.:-0.1040    1st Qu.: 0.0648   
##  Median :-0.0278    Median :-0.0748    Median : 0.0863   
##  Mean   :-0.0310    Mean   :-0.0747    Mean   : 0.0884   
##  3rd Qu.:-0.0106    3rd Qu.:-0.0511    3rd Qu.: 0.1104   
##  Max.   : 1.0000    Max.   : 1.0000    Max.   : 1.0000   
##  tBodyGyro-std()-X tBodyGyro-std()-Y tBodyGyro-std()-Z tBodyGyro-mad()-X
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.987    1st Qu.:-0.982    1st Qu.:-0.985    1st Qu.:-0.988   
##  Median :-0.902    Median :-0.911    Median :-0.882    Median :-0.908   
##  Mean   :-0.721    Mean   :-0.683    Mean   :-0.654    Mean   :-0.727   
##  3rd Qu.:-0.482    3rd Qu.:-0.446    3rd Qu.:-0.338    3rd Qu.:-0.492   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  tBodyGyro-mad()-Y tBodyGyro-mad()-Z tBodyGyro-max()-X tBodyGyro-max()-Y
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.983    1st Qu.:-0.986    1st Qu.:-0.878    1st Qu.:-0.947   
##  Median :-0.919    Median :-0.889    Median :-0.795    Median :-0.890   
##  Mean   :-0.695    Mean   :-0.667    Mean   :-0.645    Mean   :-0.738   
##  3rd Qu.:-0.464    3rd Qu.:-0.363    3rd Qu.:-0.437    3rd Qu.:-0.580   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  tBodyGyro-max()-Z tBodyGyro-min()-X tBodyGyro-min()-Y tBodyGyro-min()-Z
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.749    1st Qu.: 0.463    1st Qu.: 0.604    1st Qu.: 0.323   
##  Median :-0.645    Median : 0.771    Median : 0.853    Median : 0.742   
##  Mean   :-0.484    Mean   : 0.632    Mean   : 0.734    Mean   : 0.559   
##  3rd Qu.:-0.257    3rd Qu.: 0.838    3rd Qu.: 0.906    3rd Qu.: 0.823   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  tBodyGyro-sma()  tBodyGyro-energy()-X tBodyGyro-energy()-Y
##  Min.   :-1.000   Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.979   1st Qu.:-1.000       1st Qu.:-1.000      
##  Median :-0.820   Median :-0.990       Median :-0.993      
##  Mean   :-0.603   Mean   :-0.902       Mean   :-0.884      
##  3rd Qu.:-0.239   3rd Qu.:-0.837       3rd Qu.:-0.842      
##  Max.   : 1.000   Max.   : 1.000       Max.   : 1.000      
##  tBodyGyro-energy()-Z tBodyGyro-iqr()-X tBodyGyro-iqr()-Y
##  Min.   :-1.000       Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-1.000       1st Qu.:-0.990    1st Qu.:-0.986   
##  Median :-0.981       Median :-0.919    Median :-0.932   
##  Mean   :-0.873       Mean   :-0.729    Mean   :-0.717   
##  3rd Qu.:-0.788       3rd Qu.:-0.501    3rd Qu.:-0.506   
##  Max.   : 1.000       Max.   : 1.000    Max.   : 1.000   
##  tBodyGyro-iqr()-Z tBodyGyro-entropy()-X tBodyGyro-entropy()-Y
##  Min.   :-1.000    Min.   :-1.000        Min.   :-1.0000      
##  1st Qu.:-0.989    1st Qu.:-0.508        1st Qu.:-0.3547      
##  Median :-0.907    Median :-0.176        Median :-0.0642      
##  Mean   :-0.720    Mean   :-0.145        Mean   :-0.0992      
##  3rd Qu.:-0.474    3rd Qu.: 0.189        3rd Qu.: 0.1790      
##  Max.   : 1.000    Max.   : 1.000        Max.   : 1.0000      
##  tBodyGyro-entropy()-Z tBodyGyro-arCoeff()-X,1 tBodyGyro-arCoeff()-X,2
##  Min.   :-1.0000       Min.   :-1.000          Min.   :-1.0000        
##  1st Qu.:-0.4647       1st Qu.:-0.425          1st Qu.:-0.0185        
##  Median : 0.0329       Median :-0.243          Median : 0.1415        
##  Mean   :-0.0633       Mean   :-0.223          Mean   : 0.1477        
##  3rd Qu.: 0.3089       3rd Qu.:-0.028          3rd Qu.: 0.3022        
##  Max.   : 1.0000       Max.   : 1.000          Max.   : 1.0000        
##  tBodyGyro-arCoeff()-X,3 tBodyGyro-arCoeff()-X,4 tBodyGyro-arCoeff()-Y,1
##  Min.   :-1.0000         Min.   :-1.0000         Min.   :-1.0000        
##  1st Qu.:-0.0147         1st Qu.:-0.2437         1st Qu.:-0.3487        
##  Median : 0.1427         Median :-0.0780         Median :-0.2103        
##  Mean   : 0.1285         Mean   :-0.0803         Mean   :-0.2048        
##  3rd Qu.: 0.2825         3rd Qu.: 0.0806         3rd Qu.:-0.0645        
##  Max.   : 1.0000         Max.   : 1.0000         Max.   : 1.0000        
##  tBodyGyro-arCoeff()-Y,2 tBodyGyro-arCoeff()-Y,3 tBodyGyro-arCoeff()-Y,4
##  Min.   :-1.0000         Min.   :-1.0000         Min.   :-1.0000        
##  1st Qu.: 0.0365         1st Qu.:-0.1888         1st Qu.: 0.0005        
##  Median : 0.1646         Median :-0.0393         Median : 0.1447        
##  Mean   : 0.1697         Mean   :-0.0425         Mean   : 0.1417        
##  3rd Qu.: 0.2993         3rd Qu.: 0.1116         3rd Qu.: 0.2901        
##  Max.   : 1.0000         Max.   : 1.0000         Max.   : 1.0000        
##  tBodyGyro-arCoeff()-Z,1 tBodyGyro-arCoeff()-Z,2 tBodyGyro-arCoeff()-Z,3
##  Min.   :-1.0000         Min.   :-1.0000         Min.   :-1.0000        
##  1st Qu.:-0.3355         1st Qu.:-0.1667         1st Qu.:-0.1955        
##  Median :-0.1025         Median : 0.0642         Median : 0.0114        
##  Mean   :-0.0851         Mean   : 0.0667         Mean   :-0.0079        
##  3rd Qu.: 0.1626         3rd Qu.: 0.2904         3rd Qu.: 0.1875        
##  Max.   : 1.0000         Max.   : 1.0000         Max.   : 1.0000        
##  tBodyGyro-arCoeff()-Z,4 tBodyGyro-correlation()-X,Y
##  Min.   :-1.0000         Min.   :-1.0000            
##  1st Qu.:-0.0319         1st Qu.:-0.4439            
##  Median : 0.1471         Median :-0.1793            
##  Mean   : 0.1464         Mean   :-0.1693            
##  3rd Qu.: 0.3216         3rd Qu.: 0.0858            
##  Max.   : 1.0000         Max.   : 1.0000            
##  tBodyGyro-correlation()-X,Z tBodyGyro-correlation()-Y,Z
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.:-0.2393             1st Qu.:-0.4114            
##  Median :-0.0080             Median :-0.0939            
##  Mean   : 0.0143             Mean   :-0.1057            
##  3rd Qu.: 0.2595             3rd Qu.: 0.1886            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z
##  Min.   :-1.0000        Min.   :-1.0000        Min.   :-1.0000       
##  1st Qu.:-0.1172        1st Qu.:-0.0587        1st Qu.:-0.0794       
##  Median :-0.0982        Median :-0.0406        Median :-0.0546       
##  Mean   :-0.0967        Mean   :-0.0423        Mean   :-0.0548       
##  3rd Qu.:-0.0793        3rd Qu.:-0.0252        3rd Qu.:-0.0317       
##  Max.   : 1.0000        Max.   : 1.0000        Max.   : 1.0000       
##  tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-0.991        1st Qu.:-0.992        1st Qu.:-0.993       
##  Median :-0.935        Median :-0.955        Median :-0.950       
##  Mean   :-0.731        Mean   :-0.786        Mean   :-0.740       
##  3rd Qu.:-0.486        3rd Qu.:-0.627        3rd Qu.:-0.510       
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.000       
##  tBodyGyroJerk-mad()-X tBodyGyroJerk-mad()-Y tBodyGyroJerk-mad()-Z
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-0.991        1st Qu.:-0.993        1st Qu.:-0.993       
##  Median :-0.943        Median :-0.962        Median :-0.958       
##  Mean   :-0.730        Mean   :-0.797        Mean   :-0.747       
##  3rd Qu.:-0.478        3rd Qu.:-0.640        3rd Qu.:-0.513       
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.000       
##  tBodyGyroJerk-max()-X tBodyGyroJerk-max()-Y tBodyGyroJerk-max()-Z
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-0.990        1st Qu.:-0.993        1st Qu.:-0.991       
##  Median :-0.927        Median :-0.953        Median :-0.937       
##  Mean   :-0.747        Mean   :-0.810        Mean   :-0.743       
##  3rd Qu.:-0.537        3rd Qu.:-0.686        3rd Qu.:-0.532       
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.000       
##  tBodyGyroJerk-min()-X tBodyGyroJerk-min()-Y tBodyGyroJerk-min()-Z
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.000       
##  1st Qu.: 0.566        1st Qu.: 0.721        1st Qu.: 0.644       
##  Median : 0.932        Median : 0.959        Median : 0.956       
##  Mean   : 0.761        Mean   : 0.830        Mean   : 0.799       
##  3rd Qu.: 0.991        3rd Qu.: 0.994        3rd Qu.: 0.994       
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.000       
##  tBodyGyroJerk-sma() tBodyGyroJerk-energy()-X tBodyGyroJerk-energy()-Y
##  Min.   :-1.000      Min.   :-1.000           Min.   :-1.000          
##  1st Qu.:-0.993      1st Qu.:-1.000           1st Qu.:-1.000          
##  Median :-0.957      Median :-0.998           Median :-0.999          
##  Mean   :-0.767      Mean   :-0.917           Mean   :-0.940          
##  3rd Qu.:-0.554      3rd Qu.:-0.867           3rd Qu.:-0.930          
##  Max.   : 1.000      Max.   : 1.000           Max.   : 1.000          
##  tBodyGyroJerk-energy()-Z tBodyGyroJerk-iqr()-X tBodyGyroJerk-iqr()-Y
##  Min.   :-1.000           Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-1.000           1st Qu.:-0.991        1st Qu.:-0.993       
##  Median :-0.999           Median :-0.953        Median :-0.970       
##  Mean   :-0.919           Mean   :-0.738        Mean   :-0.809       
##  3rd Qu.:-0.878           3rd Qu.:-0.493        3rd Qu.:-0.660       
##  Max.   : 1.000           Max.   : 1.000        Max.   : 1.000       
##  tBodyGyroJerk-iqr()-Z tBodyGyroJerk-entropy()-X tBodyGyroJerk-entropy()-Y
##  Min.   :-1.000        Min.   :-1.0000           Min.   :-1.0000          
##  1st Qu.:-0.993        1st Qu.:-0.5746           1st Qu.:-0.5090          
##  Median :-0.967        Median :-0.0339           Median :-0.0024          
##  Mean   :-0.766        Mean   :-0.0152           Mean   : 0.0187          
##  3rd Qu.:-0.548        3rd Qu.: 0.5437           3rd Qu.: 0.5517          
##  Max.   : 1.000        Max.   : 1.0000           Max.   : 1.0000          
##  tBodyGyroJerk-entropy()-Z tBodyGyroJerk-arCoeff()-X,1
##  Min.   :-1.0000           Min.   :-1.0000            
##  1st Qu.:-0.6055           1st Qu.:-0.2504            
##  Median :-0.1321           Median :-0.0898            
##  Mean   :-0.0151           Mean   :-0.0725            
##  3rd Qu.: 0.5729           3rd Qu.: 0.0970            
##  Max.   : 1.0000           Max.   : 1.0000            
##  tBodyGyroJerk-arCoeff()-X,2 tBodyGyroJerk-arCoeff()-X,3
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.:-0.0774             1st Qu.: 0.0247            
##  Median : 0.0402             Median : 0.1650            
##  Mean   : 0.0409             Mean   : 0.1597            
##  3rd Qu.: 0.1558             3rd Qu.: 0.3028            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerk-arCoeff()-X,4 tBodyGyroJerk-arCoeff()-Y,1
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.: 0.0296             1st Qu.:-0.3162            
##  Median : 0.1715             Median :-0.1689            
##  Mean   : 0.1647             Mean   :-0.1624            
##  3rd Qu.: 0.3075             3rd Qu.:-0.0214            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerk-arCoeff()-Y,2 tBodyGyroJerk-arCoeff()-Y,3
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.: 0.0969             1st Qu.:-0.0427            
##  Median : 0.2004             Median : 0.0903            
##  Mean   : 0.2002             Mean   : 0.0835            
##  3rd Qu.: 0.3007             3rd Qu.: 0.2161            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerk-arCoeff()-Y,4 tBodyGyroJerk-arCoeff()-Z,1
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.:-0.0791             1st Qu.:-0.3090            
##  Median : 0.0826             Median :-0.0595            
##  Mean   : 0.0802             Mean   :-0.0287            
##  3rd Qu.: 0.2475             3rd Qu.: 0.2483            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerk-arCoeff()-Z,2 tBodyGyroJerk-arCoeff()-Z,3
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.:-0.1081             1st Qu.:-0.0728            
##  Median : 0.0433             Median : 0.0958            
##  Mean   : 0.0524             Mean   : 0.0888            
##  3rd Qu.: 0.2118             3rd Qu.: 0.2629            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerk-arCoeff()-Z,4 tBodyGyroJerk-correlation()-X,Y
##  Min.   :-1.0000             Min.   :-1.0000                
##  1st Qu.:-0.1353             1st Qu.:-0.1532                
##  Median : 0.0396             Median : 0.0343                
##  Mean   : 0.0335             Mean   : 0.0369                
##  3rd Qu.: 0.2077             3rd Qu.: 0.2241                
##  Max.   : 1.0000             Max.   : 1.0000                
##  tBodyGyroJerk-correlation()-X,Z tBodyGyroJerk-correlation()-Y,Z
##  Min.   :-1.0000                 Min.   :-1.000                 
##  1st Qu.:-0.1223                 1st Qu.:-0.285                 
##  Median : 0.0469                 Median :-0.117                 
##  Mean   : 0.0493                 Mean   :-0.114                 
##  3rd Qu.: 0.2187                 3rd Qu.: 0.048                 
##  Max.   : 1.0000                 Max.   : 1.000                 
##  tBodyAccMag-mean() tBodyAccMag-std() tBodyAccMag-mad() tBodyAccMag-max()
##  Min.   :-1.000     Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.982     1st Qu.:-0.982    1st Qu.:-0.984    1st Qu.:-0.980   
##  Median :-0.875     Median :-0.844    Median :-0.862    Median :-0.849   
##  Mean   :-0.548     Mean   :-0.591    Mean   :-0.643    Mean   :-0.559   
##  3rd Qu.:-0.120     3rd Qu.:-0.242    3rd Qu.:-0.337    3rd Qu.:-0.170   
##  Max.   : 1.000     Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  tBodyAccMag-min() tBodyAccMag-sma() tBodyAccMag-energy()
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000      
##  1st Qu.:-0.993    1st Qu.:-0.982    1st Qu.:-1.000      
##  Median :-0.967    Median :-0.875    Median :-0.989      
##  Mean   :-0.838    Mean   :-0.548    Mean   :-0.777      
##  3rd Qu.:-0.695    3rd Qu.:-0.120    3rd Qu.:-0.600      
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000      
##  tBodyAccMag-iqr() tBodyAccMag-entropy() tBodyAccMag-arCoeff()1
##  Min.   :-1.000    Min.   :-1.000        Min.   :-1.0000       
##  1st Qu.:-0.985    1st Qu.:-0.546        1st Qu.:-0.2858       
##  Median :-0.882    Median : 0.165        Median :-0.0718       
##  Mean   :-0.703    Mean   : 0.133        Mean   :-0.0695       
##  3rd Qu.:-0.451    3rd Qu.: 0.801        3rd Qu.: 0.1381       
##  Max.   : 1.000    Max.   : 1.000        Max.   : 1.0000       
##  tBodyAccMag-arCoeff()2 tBodyAccMag-arCoeff()3 tBodyAccMag-arCoeff()4
##  Min.   :-1.0000        Min.   :-1.0000        Min.   :-1.0000       
##  1st Qu.:-0.1488        1st Qu.:-0.1109        1st Qu.:-0.2356       
##  Median : 0.0179        Median : 0.0646        Median :-0.0537       
##  Mean   : 0.0240        Mean   : 0.0586        Mean   :-0.0579       
##  3rd Qu.: 0.1868        3rd Qu.: 0.2348        3rd Qu.: 0.1226       
##  Max.   : 1.0000        Max.   : 1.0000        Max.   : 1.0000       
##  tGravityAccMag-mean() tGravityAccMag-std() tGravityAccMag-mad()
##  Min.   :-1.000        Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.982        1st Qu.:-0.982       1st Qu.:-0.984      
##  Median :-0.875        Median :-0.844       Median :-0.862      
##  Mean   :-0.548        Mean   :-0.591       Mean   :-0.643      
##  3rd Qu.:-0.120        3rd Qu.:-0.242       3rd Qu.:-0.337      
##  Max.   : 1.000        Max.   : 1.000       Max.   : 1.000      
##  tGravityAccMag-max() tGravityAccMag-min() tGravityAccMag-sma()
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.980       1st Qu.:-0.993       1st Qu.:-0.982      
##  Median :-0.849       Median :-0.967       Median :-0.875      
##  Mean   :-0.559       Mean   :-0.838       Mean   :-0.548      
##  3rd Qu.:-0.170       3rd Qu.:-0.695       3rd Qu.:-0.120      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  tGravityAccMag-energy() tGravityAccMag-iqr() tGravityAccMag-entropy()
##  Min.   :-1.000          Min.   :-1.000       Min.   :-1.000          
##  1st Qu.:-1.000          1st Qu.:-0.985       1st Qu.:-0.546          
##  Median :-0.989          Median :-0.882       Median : 0.165          
##  Mean   :-0.777          Mean   :-0.703       Mean   : 0.133          
##  3rd Qu.:-0.600          3rd Qu.:-0.451       3rd Qu.: 0.801          
##  Max.   : 1.000          Max.   : 1.000       Max.   : 1.000          
##  tGravityAccMag-arCoeff()1 tGravityAccMag-arCoeff()2
##  Min.   :-1.0000           Min.   :-1.0000          
##  1st Qu.:-0.2858           1st Qu.:-0.1488          
##  Median :-0.0718           Median : 0.0179          
##  Mean   :-0.0695           Mean   : 0.0240          
##  3rd Qu.: 0.1381           3rd Qu.: 0.1868          
##  Max.   : 1.0000           Max.   : 1.0000          
##  tGravityAccMag-arCoeff()3 tGravityAccMag-arCoeff()4
##  Min.   :-1.0000           Min.   :-1.0000          
##  1st Qu.:-0.1109           1st Qu.:-0.2356          
##  Median : 0.0646           Median :-0.0537          
##  Mean   : 0.0586           Mean   :-0.0579          
##  3rd Qu.: 0.2348           3rd Qu.: 0.1226          
##  Max.   : 1.0000           Max.   : 1.0000          
##  tBodyAccJerkMag-mean() tBodyAccJerkMag-std() tBodyAccJerkMag-mad()
##  Min.   :-1.000         Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-0.990         1st Qu.:-0.991        1st Qu.:-0.991       
##  Median :-0.948         Median :-0.929        Median :-0.938       
##  Mean   :-0.649         Mean   :-0.628        Mean   :-0.647       
##  3rd Qu.:-0.296         3rd Qu.:-0.273        3rd Qu.:-0.309       
##  Max.   : 1.000         Max.   : 1.000        Max.   : 1.000       
##  tBodyAccJerkMag-max() tBodyAccJerkMag-min() tBodyAccJerkMag-sma()
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-0.989        1st Qu.:-0.983        1st Qu.:-0.990       
##  Median :-0.926        Median :-0.962        Median :-0.948       
##  Mean   :-0.639        Mean   :-0.788        Mean   :-0.649       
##  3rd Qu.:-0.298        3rd Qu.:-0.611        3rd Qu.:-0.296       
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.000       
##  tBodyAccJerkMag-energy() tBodyAccJerkMag-iqr() tBodyAccJerkMag-entropy()
##  Min.   :-1.000           Min.   :-1.000        Min.   :-1.0000          
##  1st Qu.:-1.000           1st Qu.:-0.992        1st Qu.:-0.8016          
##  Median :-0.998           Median :-0.955        Median :-0.3204          
##  Mean   :-0.851           Mean   :-0.699        Mean   :-0.0616          
##  3rd Qu.:-0.732           3rd Qu.:-0.411        3rd Qu.: 0.7027          
##  Max.   : 1.000           Max.   : 1.000        Max.   : 1.0000          
##  tBodyAccJerkMag-arCoeff()1 tBodyAccJerkMag-arCoeff()2
##  Min.   :-1.0000            Min.   :-1.0000           
##  1st Qu.:-0.0906            1st Qu.:-0.2084           
##  Median : 0.0930            Median :-0.0559           
##  Mean   : 0.0788            Mean   :-0.0290           
##  3rd Qu.: 0.2589            3rd Qu.: 0.1369           
##  Max.   : 1.0000            Max.   : 1.0000           
##  tBodyAccJerkMag-arCoeff()3 tBodyAccJerkMag-arCoeff()4 tBodyGyroMag-mean()
##  Min.   :-1.0000            Min.   :-1.0000            Min.   :-1.000     
##  1st Qu.:-0.2515            1st Qu.:-0.2207            1st Qu.:-0.978     
##  Median :-0.0939            Median :-0.0461            Median :-0.822     
##  Mean   :-0.0912            Mean   :-0.0417            Mean   :-0.605     
##  3rd Qu.: 0.0653            3rd Qu.: 0.1322            3rd Qu.:-0.245     
##  Max.   : 1.0000            Max.   : 1.0000            Max.   : 1.000     
##  tBodyGyroMag-std() tBodyGyroMag-mad() tBodyGyroMag-max()
##  Min.   :-1.000     Min.   :-1.000     Min.   :-1.000    
##  1st Qu.:-0.978     1st Qu.:-0.976     1st Qu.:-0.981    
##  Median :-0.826     Median :-0.807     Median :-0.849    
##  Mean   :-0.662     Mean   :-0.630     Mean   :-0.695    
##  3rd Qu.:-0.394     3rd Qu.:-0.333     3rd Qu.:-0.452    
##  Max.   : 1.000     Max.   : 1.000     Max.   : 1.000    
##  tBodyGyroMag-min() tBodyGyroMag-sma() tBodyGyroMag-energy()
##  Min.   :-1.000     Min.   :-1.000     Min.   :-1.000       
##  1st Qu.:-0.988     1st Qu.:-0.978     1st Qu.:-1.000       
##  Median :-0.881     Median :-0.822     Median :-0.981       
##  Mean   :-0.730     Mean   :-0.605     Mean   :-0.835       
##  3rd Qu.:-0.528     3rd Qu.:-0.245     3rd Qu.:-0.703       
##  Max.   : 1.000     Max.   : 1.000     Max.   : 1.000       
##  tBodyGyroMag-iqr() tBodyGyroMag-entropy() tBodyGyroMag-arCoeff()1
##  Min.   :-1.000     Min.   :-1.000         Min.   :-1.0000        
##  1st Qu.:-0.979     1st Qu.:-0.152         1st Qu.:-0.2280        
##  Median :-0.816     Median : 0.285         Median :-0.0303        
##  Mean   :-0.654     Mean   : 0.235         Mean   :-0.0245        
##  3rd Qu.:-0.372     3rd Qu.: 0.657         3rd Qu.: 0.1768        
##  Max.   : 1.000     Max.   : 1.000         Max.   : 1.0000        
##  tBodyGyroMag-arCoeff()2 tBodyGyroMag-arCoeff()3 tBodyGyroMag-arCoeff()4
##  Min.   :-1.0000         Min.   :-1.0000         Min.   :-1.0000        
##  1st Qu.:-0.2551         1st Qu.:-0.0568         1st Qu.:-0.2167        
##  Median :-0.0758         Median : 0.1098         Median :-0.0527        
##  Mean   :-0.0692         Mean   : 0.1076         Mean   :-0.0544        
##  3rd Qu.: 0.1064         3rd Qu.: 0.2734         3rd Qu.: 0.1113        
##  Max.   : 1.0000         Max.   : 1.0000         Max.   : 1.0000        
##  tBodyGyroJerkMag-mean() tBodyGyroJerkMag-std() tBodyGyroJerkMag-mad()
##  Min.   :-1.000          Min.   :-1.000         Min.   :-1.000        
##  1st Qu.:-0.992          1st Qu.:-0.992         1st Qu.:-0.993        
##  Median :-0.956          Median :-0.940         Median :-0.949        
##  Mean   :-0.762          Mean   :-0.778         Mean   :-0.793        
##  3rd Qu.:-0.550          3rd Qu.:-0.609         3rd Qu.:-0.629        
##  Max.   : 1.000          Max.   : 1.000         Max.   : 1.000        
##  tBodyGyroJerkMag-max() tBodyGyroJerkMag-min() tBodyGyroJerkMag-sma()
##  Min.   :-1.000         Min.   :-1.000         Min.   :-1.000        
##  1st Qu.:-0.992         1st Qu.:-0.990         1st Qu.:-0.992        
##  Median :-0.940         Median :-0.971         Median :-0.956        
##  Mean   :-0.785         Mean   :-0.803         Mean   :-0.762        
##  3rd Qu.:-0.631         3rd Qu.:-0.642         3rd Qu.:-0.550        
##  Max.   : 1.000         Max.   : 1.000         Max.   : 1.000        
##  tBodyGyroJerkMag-energy() tBodyGyroJerkMag-iqr()
##  Min.   :-1.000            Min.   :-1.000        
##  1st Qu.:-1.000            1st Qu.:-0.994        
##  Median :-0.999            Median :-0.958        
##  Mean   :-0.932            Mean   :-0.806        
##  3rd Qu.:-0.901            3rd Qu.:-0.645        
##  Max.   : 1.000            Max.   : 1.000        
##  tBodyGyroJerkMag-entropy() tBodyGyroJerkMag-arCoeff()1
##  Min.   :-1.000             Min.   :-1.000             
##  1st Qu.:-0.572             1st Qu.: 0.141             
##  Median : 0.084             Median : 0.299             
##  Mean   : 0.131             Mean   : 0.286             
##  3rd Qu.: 0.843             3rd Qu.: 0.453             
##  Max.   : 1.000             Max.   : 1.000             
##  tBodyGyroJerkMag-arCoeff()2 tBodyGyroJerkMag-arCoeff()3
##  Min.   :-1.0000             Min.   :-1.0000            
##  1st Qu.:-0.3701             1st Qu.:-0.2010            
##  Median :-0.2345             Median :-0.0587            
##  Mean   :-0.2269             Mean   :-0.0575            
##  3rd Qu.:-0.0975             3rd Qu.: 0.0903            
##  Max.   : 1.0000             Max.   : 1.0000            
##  tBodyGyroJerkMag-arCoeff()4 fBodyAcc-mean()-X fBodyAcc-mean()-Y
##  Min.   :-1.0000             Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.2794             1st Qu.:-0.991    1st Qu.:-0.979   
##  Median :-0.1187             Median :-0.946    Median :-0.864   
##  Mean   :-0.1067             Mean   :-0.623    Mean   :-0.537   
##  3rd Qu.: 0.0516             3rd Qu.:-0.265    3rd Qu.:-0.103   
##  Max.   : 1.0000             Max.   : 1.000    Max.   : 1.000   
##  fBodyAcc-mean()-Z fBodyAcc-std()-X fBodyAcc-std()-Y  fBodyAcc-std()-Z
##  Min.   :-1.000    Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.983    1st Qu.:-0.993   1st Qu.:-0.9769   1st Qu.:-0.978  
##  Median :-0.895    Median :-0.942   Median :-0.8326   Median :-0.840  
##  Mean   :-0.665    Mean   :-0.603   Mean   :-0.5284   Mean   :-0.618  
##  3rd Qu.:-0.366    3rd Qu.:-0.249   3rd Qu.:-0.0922   3rd Qu.:-0.302  
##  Max.   : 1.000    Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##  fBodyAcc-mad()-X fBodyAcc-mad()-Y  fBodyAcc-mad()-Z fBodyAcc-max()-X
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.9801   1st Qu.:-0.981   1st Qu.:-0.994  
##  Median :-0.944   Median :-0.8571   Median :-0.878   Median :-0.943  
##  Mean   :-0.591   Mean   :-0.5222   Mean   :-0.632   Mean   :-0.651  
##  3rd Qu.:-0.203   3rd Qu.:-0.0789   3rd Qu.:-0.306   3rd Qu.:-0.352  
##  Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000  
##  fBodyAcc-max()-Y fBodyAcc-max()-Z fBodyAcc-min()-X fBodyAcc-min()-Y
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.980   1st Qu.:-0.974   1st Qu.:-0.995   1st Qu.:-0.992  
##  Median :-0.858   Median :-0.816   Median :-0.977   Median :-0.969  
##  Mean   :-0.658   Mean   :-0.636   Mean   :-0.856   Mean   :-0.880  
##  3rd Qu.:-0.361   3rd Qu.:-0.367   3rd Qu.:-0.790   3rd Qu.:-0.825  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyAcc-min()-Z fBodyAcc-sma()   fBodyAcc-energy()-X fBodyAcc-energy()-Y
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000      Min.   :-1.000     
##  1st Qu.:-0.992   1st Qu.:-0.986   1st Qu.:-1.000      1st Qu.:-1.000     
##  Median :-0.975   Median :-0.898   Median :-0.998      Median :-0.985     
##  Mean   :-0.914   Mean   :-0.555   Mean   :-0.826      Mean   :-0.752     
##  3rd Qu.:-0.880   3rd Qu.:-0.115   3rd Qu.:-0.717      3rd Qu.:-0.551     
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000      Max.   : 1.000     
##  fBodyAcc-energy()-Z fBodyAcc-iqr()-X fBodyAcc-iqr()-Y fBodyAcc-iqr()-Z
##  Min.   :-1.000      Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.999      1st Qu.:-0.990   1st Qu.:-0.987   1st Qu.:-0.983  
##  Median :-0.987      Median :-0.943   Median :-0.924   Median :-0.938  
##  Mean   :-0.840      Mean   :-0.653   Mean   :-0.650   Mean   :-0.747  
##  3rd Qu.:-0.732      3rd Qu.:-0.328   3rd Qu.:-0.314   3rd Qu.:-0.534  
##  Max.   : 1.000      Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyAcc-entropy()-X fBodyAcc-entropy()-Y fBodyAcc-entropy()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.946       1st Qu.:-0.870       1st Qu.:-0.814      
##  Median :-0.498       Median :-0.364       Median :-0.385      
##  Mean   :-0.200       Mean   :-0.184       Mean   :-0.205      
##  3rd Qu.: 0.549       3rd Qu.: 0.502       3rd Qu.: 0.410      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  fBodyAcc-maxInds-X fBodyAcc-maxInds-Y fBodyAcc-maxInds-Z
##  Min.   :-1.000     Min.   :-1.000     Min.   :-1.000    
##  1st Qu.:-1.000     1st Qu.:-1.000     1st Qu.:-1.000    
##  Median :-0.806     Median :-0.800     Median :-0.923    
##  Mean   :-0.760     Mean   :-0.797     Mean   :-0.844    
##  3rd Qu.:-0.742     3rd Qu.:-0.733     3rd Qu.:-0.769    
##  Max.   : 1.000     Max.   : 1.000     Max.   : 1.000    
##  fBodyAcc-meanFreq()-X fBodyAcc-meanFreq()-Y fBodyAcc-meanFreq()-Z
##  Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000      
##  1st Qu.:-0.4188       1st Qu.:-0.1448       1st Qu.:-0.1384      
##  Median :-0.2383       Median : 0.0047       Median : 0.0608      
##  Mean   :-0.2215       Mean   : 0.0154       Mean   : 0.0473      
##  3rd Qu.:-0.0204       3rd Qu.: 0.1766       3rd Qu.: 0.2492      
##  Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000      
##  fBodyAcc-skewness()-X fBodyAcc-kurtosis()-X fBodyAcc-skewness()-Y
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.0000      
##  1st Qu.:-0.489        1st Qu.:-0.845        1st Qu.:-0.5256      
##  Median :-0.173        Median :-0.584        Median :-0.3590      
##  Mean   :-0.136        Mean   :-0.465        Mean   :-0.2680      
##  3rd Qu.: 0.152        3rd Qu.:-0.179        3rd Qu.:-0.0997      
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.0000      
##  fBodyAcc-kurtosis()-Y fBodyAcc-skewness()-Z fBodyAcc-kurtosis()-Z
##  Min.   :-1.000        Min.   :-1.0000       Min.   :-1.000       
##  1st Qu.:-0.850        1st Qu.:-0.5623       1st Qu.:-0.808       
##  Median :-0.720        Median :-0.3140       Median :-0.604       
##  Mean   :-0.582        Mean   :-0.2412       Mean   :-0.479       
##  3rd Qu.:-0.452        3rd Qu.: 0.0326       3rd Qu.:-0.236       
##  Max.   : 1.000        Max.   : 1.0000       Max.   : 1.000       
##  fBodyAcc-bandsEnergy()-1,8 fBodyAcc-bandsEnergy()-9,16
##  Min.   :-1.000             Min.   :-1.000             
##  1st Qu.:-1.000             1st Qu.:-1.000             
##  Median :-0.998             Median :-0.999             
##  Mean   :-0.818             Mean   :-0.887             
##  3rd Qu.:-0.714             3rd Qu.:-0.822             
##  Max.   : 1.000             Max.   : 1.000             
##  fBodyAcc-bandsEnergy()-17,24 fBodyAcc-bandsEnergy()-25,32
##  Min.   :-1.000               Min.   :-1.000              
##  1st Qu.:-1.000               1st Qu.:-1.000              
##  Median :-0.998               Median :-0.998              
##  Mean   :-0.858               Mean   :-0.894              
##  3rd Qu.:-0.782               3rd Qu.:-0.856              
##  Max.   : 1.000               Max.   : 1.000              
##  fBodyAcc-bandsEnergy()-33,40 fBodyAcc-bandsEnergy()-41,48
##  Min.   :-1.000               Min.   :-1.000              
##  1st Qu.:-1.000               1st Qu.:-1.000              
##  Median :-0.999               Median :-0.999              
##  Mean   :-0.915               Mean   :-0.913              
##  3rd Qu.:-0.877               3rd Qu.:-0.875              
##  Max.   : 1.000               Max.   : 1.000              
##  fBodyAcc-bandsEnergy()-49,56 fBodyAcc-bandsEnergy()-57,64
##  Min.   :-1.000               Min.   :-1.000              
##  1st Qu.:-1.000               1st Qu.:-1.000              
##  Median :-0.999               Median :-1.000              
##  Mean   :-0.946               Mean   :-0.956              
##  3rd Qu.:-0.930               3rd Qu.:-0.973              
##  Max.   : 1.000               Max.   : 1.000              
##  fBodyAcc-bandsEnergy()-1,16 fBodyAcc-bandsEnergy()-17,32
##  Min.   :-1.000              Min.   :-1.000              
##  1st Qu.:-1.000              1st Qu.:-1.000              
##  Median :-0.998              Median :-0.998              
##  Mean   :-0.822              Mean   :-0.847              
##  3rd Qu.:-0.713              3rd Qu.:-0.762              
##  Max.   : 1.000              Max.   : 1.000              
##  fBodyAcc-bandsEnergy()-33,48 fBodyAcc-bandsEnergy()-49,64
##  Min.   :-1.000               Min.   :-1.000              
##  1st Qu.:-1.000               1st Qu.:-1.000              
##  Median :-0.999               Median :-0.999              
##  Mean   :-0.914               Mean   :-0.949              
##  3rd Qu.:-0.873               3rd Qu.:-0.941              
##  Max.   : 1.000               Max.   : 1.000              
##  fBodyAcc-bandsEnergy()-1,24 fBodyAcc-bandsEnergy()-25,48
##  Min.   :-1.000              Min.   :-1.000              
##  1st Qu.:-1.000              1st Qu.:-1.000              
##  Median :-0.998              Median :-0.998              
##  Mean   :-0.824              Mean   :-0.883              
##  3rd Qu.:-0.714              3rd Qu.:-0.830              
##  Max.   : 1.000              Max.   : 1.000              
##  fBodyAcc-bandsEnergy()-1,8.1 fBodyAcc-bandsEnergy()-9,16.1
##  Min.   :-1.000               Min.   :-1.000               
##  1st Qu.:-1.000               1st Qu.:-1.000               
##  Median :-0.982               Median :-0.997               
##  Mean   :-0.788               Mean   :-0.847               
##  3rd Qu.:-0.620               3rd Qu.:-0.765               
##  Max.   : 1.000               Max.   : 1.000               
##  fBodyAcc-bandsEnergy()-17,24.1 fBodyAcc-bandsEnergy()-25,32.1
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.997                 Median :-0.997                
##  Mean   :-0.860                 Mean   :-0.903                
##  3rd Qu.:-0.778                 3rd Qu.:-0.859                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-33,40.1 fBodyAcc-bandsEnergy()-41,48.1
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.996                 Median :-0.995                
##  Mean   :-0.897                 Mean   :-0.883                
##  3rd Qu.:-0.849                 3rd Qu.:-0.822                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-49,56.1 fBodyAcc-bandsEnergy()-57,64.1
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.995                 Median :-0.999                
##  Mean   :-0.902                 Mean   :-0.952                
##  3rd Qu.:-0.865                 3rd Qu.:-0.968                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-1,16.1 fBodyAcc-bandsEnergy()-17,32.1
##  Min.   :-1.000                Min.   :-1.000                
##  1st Qu.:-1.000                1st Qu.:-1.000                
##  Median :-0.984                Median :-0.996                
##  Mean   :-0.759                Mean   :-0.837                
##  3rd Qu.:-0.566                3rd Qu.:-0.734                
##  Max.   : 1.000                Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-33,48.1 fBodyAcc-bandsEnergy()-49,64.1
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.995                 Median :-0.995                
##  Mean   :-0.880                 Mean   :-0.920                
##  3rd Qu.:-0.816                 3rd Qu.:-0.897                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-1,24.1 fBodyAcc-bandsEnergy()-25,48.1
##  Min.   :-1.000                Min.   :-1.000                
##  1st Qu.:-1.000                1st Qu.:-1.000                
##  Median :-0.985                Median :-0.996                
##  Mean   :-0.755                Mean   :-0.891                
##  3rd Qu.:-0.556                3rd Qu.:-0.832                
##  Max.   : 1.000                Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-1,8.2 fBodyAcc-bandsEnergy()-9,16.2
##  Min.   :-1.000               Min.   :-1.000               
##  1st Qu.:-0.999               1st Qu.:-1.000               
##  Median :-0.985               Median :-0.997               
##  Mean   :-0.857               Mean   :-0.899               
##  3rd Qu.:-0.777               3rd Qu.:-0.859               
##  Max.   : 1.000               Max.   : 1.000               
##  fBodyAcc-bandsEnergy()-17,24.2 fBodyAcc-bandsEnergy()-25,32.2
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.998                 Median :-0.999                
##  Mean   :-0.926                 Mean   :-0.962                
##  3rd Qu.:-0.905                 3rd Qu.:-0.954                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-33,40.2 fBodyAcc-bandsEnergy()-41,48.2
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.998                 Median :-0.997                
##  Mean   :-0.964                 Mean   :-0.938                
##  3rd Qu.:-0.955                 3rd Qu.:-0.917                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-49,56.2 fBodyAcc-bandsEnergy()-57,64.2
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.996                 Median :-0.999                
##  Mean   :-0.942                 Mean   :-0.958                
##  3rd Qu.:-0.925                 3rd Qu.:-0.973                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-1,16.2 fBodyAcc-bandsEnergy()-17,32.2
##  Min.   :-1.000                Min.   :-1.000                
##  1st Qu.:-1.000                1st Qu.:-1.000                
##  Median :-0.987                Median :-0.998                
##  Mean   :-0.854                Mean   :-0.939                
##  3rd Qu.:-0.763                3rd Qu.:-0.919                
##  Max.   : 1.000                Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-33,48.2 fBodyAcc-bandsEnergy()-49,64.2
##  Min.   :-1.000                 Min.   :-1.000                
##  1st Qu.:-1.000                 1st Qu.:-1.000                
##  Median :-0.998                 Median :-0.995                
##  Mean   :-0.955                 Mean   :-0.946                
##  3rd Qu.:-0.940                 3rd Qu.:-0.934                
##  Max.   : 1.000                 Max.   : 1.000                
##  fBodyAcc-bandsEnergy()-1,24.2 fBodyAcc-bandsEnergy()-25,48.2
##  Min.   :-1.000                Min.   :-1.000                
##  1st Qu.:-0.999                1st Qu.:-1.000                
##  Median :-0.987                Median :-0.998                
##  Mean   :-0.843                Mean   :-0.960                
##  3rd Qu.:-0.741                3rd Qu.:-0.949                
##  Max.   : 1.000                Max.   : 1.000                
##  fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z
##  Min.   :-1.000        Min.   :-1.000        Min.   :-1.000       
##  1st Qu.:-0.991        1st Qu.:-0.985        1st Qu.:-0.987       
##  Median :-0.952        Median :-0.926        Median :-0.948       
##  Mean   :-0.657        Mean   :-0.629        Mean   :-0.744       
##  3rd Qu.:-0.327        3rd Qu.:-0.264        3rd Qu.:-0.513       
##  Max.   : 1.000        Max.   : 1.000        Max.   : 1.000       
##  fBodyAccJerk-std()-X fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.992       1st Qu.:-0.987       1st Qu.:-0.990      
##  Median :-0.956       Median :-0.928       Median :-0.959      
##  Mean   :-0.655       Mean   :-0.612       Mean   :-0.781      
##  3rd Qu.:-0.320       3rd Qu.:-0.236       3rd Qu.:-0.590      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  fBodyAccJerk-mad()-X fBodyAccJerk-mad()-Y fBodyAccJerk-mad()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.990       1st Qu.:-0.986       1st Qu.:-0.988      
##  Median :-0.945       Median :-0.929       Median :-0.955      
##  Mean   :-0.595       Mean   :-0.624       Mean   :-0.764      
##  3rd Qu.:-0.202       3rd Qu.:-0.256       3rd Qu.:-0.557      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  fBodyAccJerk-max()-X fBodyAccJerk-max()-Y fBodyAccJerk-max()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.994       1st Qu.:-0.988       1st Qu.:-0.990      
##  Median :-0.968       Median :-0.943       Median :-0.963      
##  Mean   :-0.712       Mean   :-0.682       Mean   :-0.801      
##  3rd Qu.:-0.445       3rd Qu.:-0.392       3rd Qu.:-0.640      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  fBodyAccJerk-min()-X fBodyAccJerk-min()-Y fBodyAccJerk-min()-Z
##  Min.   :-1.000       Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.995       1st Qu.:-0.991       1st Qu.:-0.989      
##  Median :-0.983       Median :-0.971       Median :-0.969      
##  Mean   :-0.883       Mean   :-0.860       Mean   :-0.884      
##  3rd Qu.:-0.830       3rd Qu.:-0.798       3rd Qu.:-0.845      
##  Max.   : 1.000       Max.   : 1.000       Max.   : 1.000      
##  fBodyAccJerk-sma() fBodyAccJerk-energy()-X fBodyAccJerk-energy()-Y
##  Min.   :-1.000     Min.   :-1.000          Min.   :-1.000         
##  1st Qu.:-0.988     1st Qu.:-1.000          1st Qu.:-1.000         
##  Median :-0.936     Median :-0.999          Median :-0.997         
##  Mean   :-0.620     Mean   :-0.850          Mean   :-0.827         
##  3rd Qu.:-0.244     3rd Qu.:-0.746          3rd Qu.:-0.693         
##  Max.   : 1.000     Max.   : 1.000          Max.   : 1.000         
##  fBodyAccJerk-energy()-Z fBodyAccJerk-iqr()-X fBodyAccJerk-iqr()-Y
##  Min.   :-1.000          Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-1.000          1st Qu.:-0.989       1st Qu.:-0.988      
##  Median :-0.998          Median :-0.946       Median :-0.944      
##  Mean   :-0.931          Mean   :-0.634       Mean   :-0.720      
##  3rd Qu.:-0.893          3rd Qu.:-0.298       3rd Qu.:-0.454      
##  Max.   : 1.000          Max.   : 1.000       Max.   : 1.000      
##  fBodyAccJerk-iqr()-Z fBodyAccJerk-entropy()-X fBodyAccJerk-entropy()-Y
##  Min.   :-1.000       Min.   :-1.000           Min.   :-1.000          
##  1st Qu.:-0.986       1st Qu.:-1.000           1st Qu.:-1.000          
##  Median :-0.951       Median :-0.679           Median :-0.618          
##  Mean   :-0.771       Mean   :-0.267           Mean   :-0.266          
##  3rd Qu.:-0.584       3rd Qu.: 0.520           3rd Qu.: 0.508          
##  Max.   : 1.000       Max.   : 1.000           Max.   : 1.000          
##  fBodyAccJerk-entropy()-Z fBodyAccJerk-maxInds-X fBodyAccJerk-maxInds-Y
##  Min.   :-1.000           Min.   :-1.000         Min.   :-1.000        
##  1st Qu.:-1.000           1st Qu.:-0.680         1st Qu.:-0.560        
##  Median :-0.671           Median :-0.400         Median :-0.400        
##  Mean   :-0.365           Mean   :-0.414         Mean   :-0.397        
##  3rd Qu.: 0.289           3rd Qu.:-0.160         3rd Qu.:-0.240        
##  Max.   : 1.000           Max.   : 1.000         Max.   : 1.000        
##  fBodyAccJerk-maxInds-Z fBodyAccJerk-meanFreq()-X
##  Min.   :-1.000         Min.   :-1.0000          
##  1st Qu.:-0.480         1st Qu.:-0.2977          
##  Median :-0.320         Median :-0.0454          
##  Mean   :-0.325         Mean   :-0.0477          
##  3rd Qu.:-0.160         3rd Qu.: 0.2045          
##  Max.   : 1.000         Max.   : 1.0000          
##  fBodyAccJerk-meanFreq()-Y fBodyAccJerk-meanFreq()-Z
##  Min.   :-1.0000           Min.   :-1.0000          
##  1st Qu.:-0.4280           1st Qu.:-0.3314          
##  Median :-0.2365           Median :-0.1025          
##  Mean   :-0.2134           Mean   :-0.1238          
##  3rd Qu.: 0.0087           3rd Qu.: 0.0912          
##  Max.   : 1.0000           Max.   : 1.0000          
##  fBodyAccJerk-skewness()-X fBodyAccJerk-kurtosis()-X
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.:-0.505            1st Qu.:-0.857           
##  Median :-0.352            Median :-0.773           
##  Mean   :-0.316            Mean   :-0.713           
##  3rd Qu.:-0.163            3rd Qu.:-0.636           
##  Max.   : 1.000            Max.   : 1.000           
##  fBodyAccJerk-skewness()-Y fBodyAccJerk-kurtosis()-Y
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.:-0.536            1st Qu.:-0.913           
##  Median :-0.421            Median :-0.858           
##  Mean   :-0.400            Mean   :-0.823           
##  3rd Qu.:-0.293            3rd Qu.:-0.777           
##  Max.   : 1.000            Max.   : 1.000           
##  fBodyAccJerk-skewness()-Z fBodyAccJerk-kurtosis()-Z
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.:-0.628            1st Qu.:-0.912           
##  Median :-0.519            Median :-0.856           
##  Mean   :-0.488            Mean   :-0.816           
##  3rd Qu.:-0.384            3rd Qu.:-0.768           
##  Max.   : 1.000            Max.   : 1.000           
##  fBodyAccJerk-bandsEnergy()-1,8 fBodyAccJerk-bandsEnergy()-9,16
##  Min.   :-1.000                 Min.   :-1.000                 
##  1st Qu.:-1.000                 1st Qu.:-1.000                 
##  Median :-1.000                 Median :-0.999                 
##  Mean   :-0.868                 Mean   :-0.887                 
##  3rd Qu.:-0.805                 3rd Qu.:-0.814                 
##  Max.   : 1.000                 Max.   : 1.000                 
##  fBodyAccJerk-bandsEnergy()-17,24 fBodyAccJerk-bandsEnergy()-25,32
##  Min.   :-1.000                   Min.   :-1.000                  
##  1st Qu.:-1.000                   1st Qu.:-1.000                  
##  Median :-0.999                   Median :-0.999                  
##  Mean   :-0.874                   Mean   :-0.897                  
##  3rd Qu.:-0.811                   3rd Qu.:-0.865                  
##  Max.   : 1.000                   Max.   : 1.000                  
##  fBodyAccJerk-bandsEnergy()-33,40 fBodyAccJerk-bandsEnergy()-41,48
##  Min.   :-1.000                   Min.   :-1.000                  
##  1st Qu.:-1.000                   1st Qu.:-1.000                  
##  Median :-0.999                   Median :-0.999                  
##  Mean   :-0.922                   Mean   :-0.903                  
##  3rd Qu.:-0.889                   3rd Qu.:-0.860                  
##  Max.   : 1.000                   Max.   : 1.000                  
##  fBodyAccJerk-bandsEnergy()-49,56 fBodyAccJerk-bandsEnergy()-57,64
##  Min.   :-1.000                   Min.   :-1.000                  
##  1st Qu.:-1.000                   1st Qu.:-1.000                  
##  Median :-0.999                   Median :-1.000                  
##  Mean   :-0.945                   Mean   :-0.985                  
##  3rd Qu.:-0.924                   3rd Qu.:-0.991                  
##  Max.   : 1.000                   Max.   : 1.000                  
##  fBodyAccJerk-bandsEnergy()-1,16 fBodyAccJerk-bandsEnergy()-17,32
##  Min.   :-1.000                  Min.   :-1.000                  
##  1st Qu.:-1.000                  1st Qu.:-1.000                  
##  Median :-0.999                  Median :-0.998                  
##  Mean   :-0.868                  Mean   :-0.855                  
##  3rd Qu.:-0.785                  3rd Qu.:-0.780                  
##  Max.   : 1.000                  Max.   : 1.000                  
##  fBodyAccJerk-bandsEnergy()-33,48 fBodyAccJerk-bandsEnergy()-49,64
##  Min.   :-1.000                   Min.   :-1.000                  
##  1st Qu.:-1.000                   1st Qu.:-1.000                  
##  Median :-0.999                   Median :-0.999                  
##  Mean   :-0.907                   Mean   :-0.943                  
##  3rd Qu.:-0.862                   3rd Qu.:-0.921                  
##  Max.   : 1.000                   Max.   : 1.000                  
##  fBodyAccJerk-bandsEnergy()-1,24 fBodyAccJerk-bandsEnergy()-25,48
##  Min.   :-1.000                  Min.   :-1.000                  
##  1st Qu.:-1.000                  1st Qu.:-1.000                  
##  Median :-0.999                  Median :-0.998                  
##  Mean   :-0.846                  Mean   :-0.862                  
##  3rd Qu.:-0.737                  3rd Qu.:-0.799                  
##  Max.   : 1.000                  Max.   : 1.000                  
##  fBodyAccJerk-bandsEnergy()-1,8.1 fBodyAccJerk-bandsEnergy()-9,16.1
##  Min.   :-1.000                   Min.   :-1.000                   
##  1st Qu.:-1.000                   1st Qu.:-1.000                   
##  Median :-0.995                   Median :-0.998                   
##  Mean   :-0.835                   Mean   :-0.869                   
##  3rd Qu.:-0.720                   3rd Qu.:-0.797                   
##  Max.   : 1.000                   Max.   : 1.000                   
##  fBodyAccJerk-bandsEnergy()-17,24.1 fBodyAccJerk-bandsEnergy()-25,32.1
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.997                     Median :-0.998                    
##  Mean   :-0.836                     Mean   :-0.908                    
##  3rd Qu.:-0.740                     3rd Qu.:-0.866                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-33,40.1 fBodyAccJerk-bandsEnergy()-41,48.1
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.998                     Median :-0.997                    
##  Mean   :-0.916                     Mean   :-0.877                    
##  3rd Qu.:-0.877                     3rd Qu.:-0.811                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-49,56.1 fBodyAccJerk-bandsEnergy()-57,64.1
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.998                     Median :-1.000                    
##  Mean   :-0.923                     Mean   :-0.971                    
##  3rd Qu.:-0.887                     3rd Qu.:-0.984                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-1,16.1 fBodyAccJerk-bandsEnergy()-17,32.1
##  Min.   :-1.000                    Min.   :-1.000                    
##  1st Qu.:-1.000                    1st Qu.:-1.000                    
##  Median :-0.997                    Median :-0.997                    
##  Mean   :-0.842                    Mean   :-0.837                    
##  3rd Qu.:-0.743                    3rd Qu.:-0.735                    
##  Max.   : 1.000                    Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-33,48.1 fBodyAccJerk-bandsEnergy()-49,64.1
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.997                     Median :-0.998                    
##  Mean   :-0.879                     Mean   :-0.929                    
##  3rd Qu.:-0.811                     3rd Qu.:-0.896                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-1,24.1 fBodyAccJerk-bandsEnergy()-25,48.1
##  Min.   :-1.000                    Min.   :-1.000                    
##  1st Qu.:-1.000                    1st Qu.:-1.000                    
##  Median :-0.996                    Median :-0.998                    
##  Mean   :-0.813                    Mean   :-0.896                    
##  3rd Qu.:-0.673                    3rd Qu.:-0.836                    
##  Max.   : 1.000                    Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-1,8.2 fBodyAccJerk-bandsEnergy()-9,16.2
##  Min.   :-1.000                   Min.   :-1.000                   
##  1st Qu.:-1.000                   1st Qu.:-1.000                   
##  Median :-0.997                   Median :-0.998                   
##  Mean   :-0.901                   Mean   :-0.899                   
##  3rd Qu.:-0.857                   3rd Qu.:-0.859                   
##  Max.   : 1.000                   Max.   : 1.000                   
##  fBodyAccJerk-bandsEnergy()-17,24.2 fBodyAccJerk-bandsEnergy()-25,32.2
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.999                     Median :-0.999                    
##  Mean   :-0.931                     Mean   :-0.963                    
##  3rd Qu.:-0.912                     3rd Qu.:-0.956                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-33,40.2 fBodyAccJerk-bandsEnergy()-41,48.2
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.999                     Median :-0.998                    
##  Mean   :-0.967                     Mean   :-0.942                    
##  3rd Qu.:-0.961                     3rd Qu.:-0.925                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-49,56.2 fBodyAccJerk-bandsEnergy()-57,64.2
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.998                     Median :-0.999                    
##  Mean   :-0.932                     Mean   :-0.971                    
##  3rd Qu.:-0.915                     3rd Qu.:-0.987                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-1,16.2 fBodyAccJerk-bandsEnergy()-17,32.2
##  Min.   :-1.000                    Min.   :-1.000                    
##  1st Qu.:-1.000                    1st Qu.:-1.000                    
##  Median :-0.997                    Median :-0.999                    
##  Mean   :-0.879                    Mean   :-0.947                    
##  3rd Qu.:-0.818                    3rd Qu.:-0.929                    
##  Max.   : 1.000                    Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-33,48.2 fBodyAccJerk-bandsEnergy()-49,64.2
##  Min.   :-1.000                     Min.   :-1.000                    
##  1st Qu.:-1.000                     1st Qu.:-1.000                    
##  Median :-0.999                     Median :-0.998                    
##  Mean   :-0.958                     Mean   :-0.932                    
##  3rd Qu.:-0.945                     3rd Qu.:-0.916                    
##  Max.   : 1.000                     Max.   : 1.000                    
##  fBodyAccJerk-bandsEnergy()-1,24.2 fBodyAccJerk-bandsEnergy()-25,48.2
##  Min.   :-1.000                    Min.   :-1.000                    
##  1st Qu.:-1.000                    1st Qu.:-1.000                    
##  Median :-0.998                    Median :-0.999                    
##  Mean   :-0.899                    Mean   :-0.961                    
##  3rd Qu.:-0.847                    3rd Qu.:-0.950                    
##  Max.   : 1.000                    Max.   : 1.000                    
##  fBodyGyro-mean()-X fBodyGyro-mean()-Y fBodyGyro-mean()-Z
##  Min.   :-1.000     Min.   :-1.000     Min.   :-1.000    
##  1st Qu.:-0.985     1st Qu.:-0.985     1st Qu.:-0.985    
##  Median :-0.892     Median :-0.920     Median :-0.888    
##  Mean   :-0.672     Mean   :-0.706     Mean   :-0.644    
##  3rd Qu.:-0.384     3rd Qu.:-0.473     3rd Qu.:-0.323    
##  Max.   : 1.000     Max.   : 1.000     Max.   : 1.000    
##  fBodyGyro-std()-X fBodyGyro-std()-Y fBodyGyro-std()-Z fBodyGyro-mad()-X
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.988    1st Qu.:-0.981    1st Qu.:-0.986    1st Qu.:-0.986   
##  Median :-0.905    Median :-0.906    Median :-0.891    Median :-0.890   
##  Mean   :-0.739    Mean   :-0.674    Mean   :-0.690    Mean   :-0.688   
##  3rd Qu.:-0.522    3rd Qu.:-0.438    3rd Qu.:-0.417    3rd Qu.:-0.414   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  fBodyGyro-mad()-Y fBodyGyro-mad()-Z fBodyGyro-max()-X fBodyGyro-max()-Y
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.985    1st Qu.:-0.985    1st Qu.:-0.988    1st Qu.:-0.984   
##  Median :-0.920    Median :-0.889    Median :-0.907    Median :-0.921   
##  Mean   :-0.712    Mean   :-0.641    Mean   :-0.736    Mean   :-0.734   
##  3rd Qu.:-0.495    3rd Qu.:-0.310    3rd Qu.:-0.537    3rd Qu.:-0.570   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  fBodyGyro-max()-Z fBodyGyro-min()-X fBodyGyro-min()-Y fBodyGyro-min()-Z
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.989    1st Qu.:-0.997    1st Qu.:-0.995    1st Qu.:-0.995   
##  Median :-0.910    Median :-0.982    Median :-0.975    Median :-0.972   
##  Mean   :-0.764    Mean   :-0.931    Mean   :-0.901    Mean   :-0.909   
##  3rd Qu.:-0.581    3rd Qu.:-0.906    3rd Qu.:-0.863    3rd Qu.:-0.870   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  fBodyGyro-sma()  fBodyGyro-energy()-X fBodyGyro-energy()-Y
##  Min.   :-1.000   Min.   :-1.000       Min.   :-1.000      
##  1st Qu.:-0.984   1st Qu.:-1.000       1st Qu.:-1.000      
##  Median :-0.901   Median :-0.995       Median :-0.996      
##  Mean   :-0.660   Mean   :-0.915       Mean   :-0.885      
##  3rd Qu.:-0.353   3rd Qu.:-0.865       3rd Qu.:-0.846      
##  Max.   : 1.000   Max.   : 1.000       Max.   : 1.000      
##  fBodyGyro-energy()-Z fBodyGyro-iqr()-X fBodyGyro-iqr()-Y
##  Min.   :-1.000       Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-1.000       1st Qu.:-0.989    1st Qu.:-0.990   
##  Median :-0.993       Median :-0.930    Median :-0.942   
##  Mean   :-0.870       Mean   :-0.707    Mean   :-0.754   
##  3rd Qu.:-0.779       3rd Qu.:-0.451    3rd Qu.:-0.572   
##  Max.   : 1.000       Max.   : 1.000    Max.   : 1.000   
##  fBodyGyro-iqr()-Z fBodyGyro-entropy()-X fBodyGyro-entropy()-Y
##  Min.   :-1.000    Min.   :-1.0000       Min.   :-1.0000      
##  1st Qu.:-0.989    1st Qu.:-0.6991       1st Qu.:-0.6365      
##  Median :-0.933    Median :-0.1660       Median :-0.1320      
##  Mean   :-0.697    Mean   :-0.0932       Mean   :-0.0467      
##  3rd Qu.:-0.438    3rd Qu.: 0.5172       3rd Qu.: 0.5629      
##  Max.   : 1.000    Max.   : 1.0000       Max.   : 1.0000      
##  fBodyGyro-entropy()-Z fBodyGyro-maxInds-X fBodyGyro-maxInds-Y
##  Min.   :-1.000        Min.   :-1.000      Min.   :-1.000     
##  1st Qu.:-0.759        1st Qu.:-1.000      1st Qu.:-1.000     
##  Median :-0.249        Median :-0.933      Median :-0.935     
##  Mean   :-0.149        Mean   :-0.879      Mean   :-0.801     
##  3rd Qu.: 0.450        3rd Qu.:-0.867      3rd Qu.:-0.677     
##  Max.   : 1.000        Max.   : 1.000      Max.   : 1.000     
##  fBodyGyro-maxInds-Z fBodyGyro-meanFreq()-X fBodyGyro-meanFreq()-Y
##  Min.   :-1.000      Min.   :-1.0000        Min.   :-1.0000       
##  1st Qu.:-1.000      1st Qu.:-0.2719        1st Qu.:-0.3626       
##  Median :-0.931      Median :-0.0987        Median :-0.1730       
##  Mean   :-0.808      Mean   :-0.1010        Mean   :-0.1743       
##  3rd Qu.:-0.655      3rd Qu.: 0.0681        3rd Qu.: 0.0137       
##  Max.   : 1.000      Max.   : 1.0000        Max.   : 1.0000       
##  fBodyGyro-meanFreq()-Z fBodyGyro-skewness()-X fBodyGyro-kurtosis()-X
##  Min.   :-1.0000        Min.   :-1.0000        Min.   :-1.000        
##  1st Qu.:-0.2324        1st Qu.:-0.4172        1st Qu.:-0.754        
##  Median :-0.0537        Median :-0.2195        Median :-0.584        
##  Mean   :-0.0514        Mean   :-0.1768        Mean   :-0.494        
##  3rd Qu.: 0.1225        3rd Qu.: 0.0309        3rd Qu.:-0.307        
##  Max.   : 1.0000        Max.   : 1.0000        Max.   : 1.000        
##  fBodyGyro-skewness()-Y fBodyGyro-kurtosis()-Y fBodyGyro-skewness()-Z
##  Min.   :-1.0000        Min.   :-1.000         Min.   :-1.0000       
##  1st Qu.:-0.4495        1st Qu.:-0.817         1st Qu.:-0.4653       
##  Median :-0.2490        Median :-0.658         Median :-0.2704       
##  Mean   :-0.1785        Mean   :-0.533         Mean   :-0.2136       
##  3rd Qu.: 0.0358        3rd Qu.:-0.357         3rd Qu.:-0.0056       
##  Max.   : 1.0000        Max.   : 1.000         Max.   : 1.0000       
##  fBodyGyro-kurtosis()-Z fBodyGyro-bandsEnergy()-1,8
##  Min.   :-1.000         Min.   :-1.000             
##  1st Qu.:-0.797         1st Qu.:-1.000             
##  Median :-0.637         Median :-0.995             
##  Mean   :-0.533         Mean   :-0.929             
##  3rd Qu.:-0.357         3rd Qu.:-0.897             
##  Max.   : 1.000         Max.   : 1.000             
##  fBodyGyro-bandsEnergy()-9,16 fBodyGyro-bandsEnergy()-17,24
##  Min.   :-1.000               Min.   :-1.000               
##  1st Qu.:-1.000               1st Qu.:-1.000               
##  Median :-0.998               Median :-0.998               
##  Mean   :-0.908               Mean   :-0.920               
##  3rd Qu.:-0.867               3rd Qu.:-0.887               
##  Max.   : 1.000               Max.   : 1.000               
##  fBodyGyro-bandsEnergy()-25,32 fBodyGyro-bandsEnergy()-33,40
##  Min.   :-1.000                Min.   :-1.000               
##  1st Qu.:-1.000                1st Qu.:-1.000               
##  Median :-0.999                Median :-0.998               
##  Mean   :-0.959                Mean   :-0.950               
##  3rd Qu.:-0.948                3rd Qu.:-0.937               
##  Max.   : 1.000                Max.   : 1.000               
##  fBodyGyro-bandsEnergy()-41,48 fBodyGyro-bandsEnergy()-49,56
##  Min.   :-1.000                Min.   :-1.000               
##  1st Qu.:-1.000                1st Qu.:-1.000               
##  Median :-0.998                Median :-0.998               
##  Mean   :-0.952                Mean   :-0.964               
##  3rd Qu.:-0.935                3rd Qu.:-0.958               
##  Max.   : 1.000                Max.   : 1.000               
##  fBodyGyro-bandsEnergy()-57,64 fBodyGyro-bandsEnergy()-1,16
##  Min.   :-1.000                Min.   :-1.000              
##  1st Qu.:-1.000                1st Qu.:-1.000              
##  Median :-1.000                Median :-0.995              
##  Mean   :-0.975                Mean   :-0.920              
##  3rd Qu.:-0.984                3rd Qu.:-0.875              
##  Max.   : 1.000                Max.   : 1.000              
##  fBodyGyro-bandsEnergy()-17,32 fBodyGyro-bandsEnergy()-33,48
##  Min.   :-1.000                Min.   :-1.000               
##  1st Qu.:-1.000                1st Qu.:-1.000               
##  Median :-0.998                Median :-0.998               
##  Mean   :-0.919                Mean   :-0.946               
##  3rd Qu.:-0.883                3rd Qu.:-0.929               
##  Max.   : 1.000                Max.   : 1.000               
##  fBodyGyro-bandsEnergy()-49,64 fBodyGyro-bandsEnergy()-1,24
##  Min.   :-1.000                Min.   :-1.000              
##  1st Qu.:-1.000                1st Qu.:-1.000              
##  Median :-0.998                Median :-0.995              
##  Mean   :-0.969                Mean   :-0.917              
##  3rd Qu.:-0.969                3rd Qu.:-0.868              
##  Max.   : 1.000                Max.   : 1.000              
##  fBodyGyro-bandsEnergy()-25,48 fBodyGyro-bandsEnergy()-1,8.1
##  Min.   :-1.000                Min.   :-1.000               
##  1st Qu.:-1.000                1st Qu.:-1.000               
##  Median :-0.998                Median :-0.995               
##  Mean   :-0.955                Mean   :-0.878               
##  3rd Qu.:-0.938                3rd Qu.:-0.847               
##  Max.   : 1.000                Max.   : 1.000               
##  fBodyGyro-bandsEnergy()-9,16.1 fBodyGyro-bandsEnergy()-17,24.1
##  Min.   :-1.000                 Min.   :-1.000                 
##  1st Qu.:-1.000                 1st Qu.:-1.000                 
##  Median :-0.999                 Median :-0.999                 
##  Mean   :-0.957                 Mean   :-0.960                 
##  3rd Qu.:-0.953                 3rd Qu.:-0.965                 
##  Max.   : 1.000                 Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-25,32.1 fBodyGyro-bandsEnergy()-33,40.1
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-1.000                  1st Qu.:-1.000                 
##  Median :-0.999                  Median :-0.999                 
##  Mean   :-0.968                  Mean   :-0.978                 
##  3rd Qu.:-0.969                  3rd Qu.:-0.976                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-41,48.1 fBodyGyro-bandsEnergy()-49,56.1
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-1.000                  1st Qu.:-1.000                 
##  Median :-0.999                  Median :-0.998                 
##  Mean   :-0.958                  Mean   :-0.952                 
##  3rd Qu.:-0.953                  3rd Qu.:-0.949                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-57,64.1 fBodyGyro-bandsEnergy()-1,16.1
##  Min.   :-1.000                  Min.   :-1.000                
##  1st Qu.:-1.000                  1st Qu.:-1.000                
##  Median :-1.000                  Median :-0.996                
##  Mean   :-0.976                  Mean   :-0.890                
##  3rd Qu.:-0.987                  3rd Qu.:-0.854                
##  Max.   : 1.000                  Max.   : 1.000                
##  fBodyGyro-bandsEnergy()-17,32.1 fBodyGyro-bandsEnergy()-33,48.1
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-1.000                  1st Qu.:-1.000                 
##  Median :-0.999                  Median :-0.999                 
##  Mean   :-0.953                  Mean   :-0.973                 
##  3rd Qu.:-0.955                  3rd Qu.:-0.970                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-49,64.1 fBodyGyro-bandsEnergy()-1,24.1
##  Min.   :-1.000                  Min.   :-1.000                
##  1st Qu.:-1.000                  1st Qu.:-1.000                
##  Median :-0.998                  Median :-0.995                
##  Mean   :-0.956                  Mean   :-0.879                
##  3rd Qu.:-0.955                  3rd Qu.:-0.837                
##  Max.   : 1.000                  Max.   : 1.000                
##  fBodyGyro-bandsEnergy()-25,48.1 fBodyGyro-bandsEnergy()-1,8.2
##  Min.   :-1.000                  Min.   :-1.000               
##  1st Qu.:-1.000                  1st Qu.:-1.000               
##  Median :-0.999                  Median :-0.993               
##  Mean   :-0.967                  Mean   :-0.899               
##  3rd Qu.:-0.966                  3rd Qu.:-0.841               
##  Max.   : 1.000                  Max.   : 1.000               
##  fBodyGyro-bandsEnergy()-9,16.2 fBodyGyro-bandsEnergy()-17,24.2
##  Min.   :-1.000                 Min.   :-1.000                 
##  1st Qu.:-1.000                 1st Qu.:-1.000                 
##  Median :-0.998                 Median :-0.999                 
##  Mean   :-0.933                 Mean   :-0.932                 
##  3rd Qu.:-0.914                 3rd Qu.:-0.912                 
##  Max.   : 1.000                 Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-25,32.2 fBodyGyro-bandsEnergy()-33,40.2
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-1.000                  1st Qu.:-1.000                 
##  Median :-0.999                  Median :-0.999                 
##  Mean   :-0.966                  Mean   :-0.971                 
##  3rd Qu.:-0.960                  3rd Qu.:-0.966                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-41,48.2 fBodyGyro-bandsEnergy()-49,56.2
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-1.000                  1st Qu.:-1.000                 
##  Median :-0.998                  Median :-0.996                 
##  Mean   :-0.961                  Mean   :-0.951                 
##  3rd Qu.:-0.950                  3rd Qu.:-0.946                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-57,64.2 fBodyGyro-bandsEnergy()-1,16.2
##  Min.   :-1.000                  Min.   :-1.000                
##  1st Qu.:-1.000                  1st Qu.:-1.000                
##  Median :-0.999                  Median :-0.993                
##  Mean   :-0.969                  Mean   :-0.882                
##  3rd Qu.:-0.981                  3rd Qu.:-0.805                
##  Max.   : 1.000                  Max.   : 1.000                
##  fBodyGyro-bandsEnergy()-17,32.2 fBodyGyro-bandsEnergy()-33,48.2
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-1.000                  1st Qu.:-1.000                 
##  Median :-0.998                  Median :-0.998                 
##  Mean   :-0.918                  Mean   :-0.968                 
##  3rd Qu.:-0.892                  3rd Qu.:-0.961                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  fBodyGyro-bandsEnergy()-49,64.2 fBodyGyro-bandsEnergy()-1,24.2
##  Min.   :-1.000                  Min.   :-1.000                
##  1st Qu.:-1.000                  1st Qu.:-1.000                
##  Median :-0.996                  Median :-0.993                
##  Mean   :-0.959                  Mean   :-0.873                
##  3rd Qu.:-0.959                  3rd Qu.:-0.785                
##  Max.   : 1.000                  Max.   : 1.000                
##  fBodyGyro-bandsEnergy()-25,48.2 fBodyAccMag-mean() fBodyAccMag-std()
##  Min.   :-1.000                  Min.   :-1.000     Min.   :-1.000   
##  1st Qu.:-1.000                  1st Qu.:-0.985     1st Qu.:-0.983   
##  Median :-0.999                  Median :-0.875     Median :-0.855   
##  Mean   :-0.966                  Mean   :-0.586     Mean   :-0.659   
##  3rd Qu.:-0.959                  3rd Qu.:-0.217     3rd Qu.:-0.382   
##  Max.   : 1.000                  Max.   : 1.000     Max.   : 1.000   
##  fBodyAccMag-mad() fBodyAccMag-max() fBodyAccMag-min() fBodyAccMag-sma()
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.982    1st Qu.:-0.986    1st Qu.:-0.992    1st Qu.:-0.985   
##  Median :-0.855    Median :-0.877    Median :-0.969    Median :-0.875   
##  Mean   :-0.596    Mean   :-0.756    Mean   :-0.891    Mean   :-0.586   
##  3rd Qu.:-0.253    3rd Qu.:-0.571    3rd Qu.:-0.839    3rd Qu.:-0.217   
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  fBodyAccMag-energy() fBodyAccMag-iqr() fBodyAccMag-entropy()
##  Min.   :-1.000       Min.   :-1.000    Min.   :-1.000       
##  1st Qu.:-1.000       1st Qu.:-0.988    1st Qu.:-0.874       
##  Median :-0.986       Median :-0.931    Median :-0.355       
##  Mean   :-0.822       Mean   :-0.695    Mean   :-0.190       
##  3rd Qu.:-0.708       3rd Qu.:-0.432    3rd Qu.: 0.491       
##  Max.   : 1.000       Max.   : 1.000    Max.   : 1.000       
##  fBodyAccMag-maxInds fBodyAccMag-meanFreq() fBodyAccMag-skewness()
##  Min.   :-1.000      Min.   :-1.0000        Min.   :-1.000        
##  1st Qu.:-1.000      1st Qu.:-0.0966        1st Qu.:-0.575        
##  Median :-0.793      Median : 0.0703        Median :-0.423        
##  Mean   :-0.753      Mean   : 0.0769        Mean   :-0.352        
##  3rd Qu.:-0.517      3rd Qu.: 0.2450        3rd Qu.:-0.204        
##  Max.   : 1.000      Max.   : 1.0000        Max.   : 1.000        
##  fBodyAccMag-kurtosis() fBodyBodyAccJerkMag-mean()
##  Min.   :-1.000         Min.   :-1.000            
##  1st Qu.:-0.844         1st Qu.:-0.990            
##  Median :-0.735         Median :-0.929            
##  Mean   :-0.632         Mean   :-0.621            
##  3rd Qu.:-0.536         3rd Qu.:-0.260            
##  Max.   : 1.000         Max.   : 1.000            
##  fBodyBodyAccJerkMag-std() fBodyBodyAccJerkMag-mad()
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.:-0.991            1st Qu.:-0.988           
##  Median :-0.925            Median :-0.923           
##  Mean   :-0.640            Mean   :-0.614           
##  3rd Qu.:-0.308            3rd Qu.:-0.252           
##  Max.   : 1.000            Max.   : 1.000           
##  fBodyBodyAccJerkMag-max() fBodyBodyAccJerkMag-min()
##  Min.   :-1.000            Min.   :-1.000           
##  1st Qu.:-0.993            1st Qu.:-0.987           
##  Median :-0.935            Median :-0.960           
##  Mean   :-0.683            Mean   :-0.803           
##  3rd Qu.:-0.404            3rd Qu.:-0.679           
##  Max.   : 1.000            Max.   : 1.000           
##  fBodyBodyAccJerkMag-sma() fBodyBodyAccJerkMag-energy()
##  Min.   :-1.000            Min.   :-1.000              
##  1st Qu.:-0.990            1st Qu.:-1.000              
##  Median :-0.929            Median :-0.997              
##  Mean   :-0.621            Mean   :-0.841              
##  3rd Qu.:-0.260            3rd Qu.:-0.731              
##  Max.   : 1.000            Max.   : 1.000              
##  fBodyBodyAccJerkMag-iqr() fBodyBodyAccJerkMag-entropy()
##  Min.   :-1.000            Min.   :-1.000               
##  1st Qu.:-0.989            1st Qu.:-1.000               
##  Median :-0.942            Median :-0.682               
##  Mean   :-0.677            Mean   :-0.339               
##  3rd Qu.:-0.372            3rd Qu.: 0.346               
##  Max.   : 1.000            Max.   : 1.000               
##  fBodyBodyAccJerkMag-maxInds fBodyBodyAccJerkMag-meanFreq()
##  Min.   :-1.000              Min.   :-1.000                
##  1st Qu.:-0.968              1st Qu.:-0.003                
##  Median :-0.905              Median : 0.164                
##  Mean   :-0.878              Mean   : 0.173                
##  3rd Qu.:-0.873              3rd Qu.: 0.357                
##  Max.   : 1.000              Max.   : 1.000                
##  fBodyBodyAccJerkMag-skewness() fBodyBodyAccJerkMag-kurtosis()
##  Min.   :-1.0000                Min.   :-1.000                
##  1st Qu.:-0.6014                1st Qu.:-0.879                
##  Median :-0.3475                Median :-0.714                
##  Mean   :-0.2986                Mean   :-0.602                
##  3rd Qu.:-0.0577                3rd Qu.:-0.426                
##  Max.   : 1.0000                Max.   : 1.000                
##  fBodyBodyGyroMag-mean() fBodyBodyGyroMag-std() fBodyBodyGyroMag-mad()
##  Min.   :-1.000          Min.   :-1.000         Min.   :-1.000        
##  1st Qu.:-0.983          1st Qu.:-0.978         1st Qu.:-0.979        
##  Median :-0.876          Median :-0.828         Median :-0.846        
##  Mean   :-0.697          Mean   :-0.700         Mean   :-0.681        
##  3rd Qu.:-0.451          3rd Qu.:-0.471         3rd Qu.:-0.418        
##  Max.   : 1.000          Max.   : 1.000         Max.   : 1.000        
##  fBodyBodyGyroMag-max() fBodyBodyGyroMag-min() fBodyBodyGyroMag-sma()
##  Min.   :-1.000         Min.   :-1.000         Min.   :-1.000        
##  1st Qu.:-0.980         1st Qu.:-0.994         1st Qu.:-0.983        
##  Median :-0.827         Median :-0.959         Median :-0.876        
##  Mean   :-0.735         Mean   :-0.889         Mean   :-0.697        
##  3rd Qu.:-0.556         3rd Qu.:-0.840         3rd Qu.:-0.451        
##  Max.   : 1.000         Max.   : 1.000         Max.   : 1.000        
##  fBodyBodyGyroMag-energy() fBodyBodyGyroMag-iqr()
##  Min.   :-1.000            Min.   :-1.000        
##  1st Qu.:-1.000            1st Qu.:-0.985        
##  Median :-0.984            Median :-0.913        
##  Mean   :-0.881            Mean   :-0.722        
##  3rd Qu.:-0.815            3rd Qu.:-0.495        
##  Max.   : 1.000            Max.   : 1.000        
##  fBodyBodyGyroMag-entropy() fBodyBodyGyroMag-maxInds
##  Min.   :-1.0000            Min.   :-1.000          
##  1st Qu.:-0.6650            1st Qu.:-1.000          
##  Median :-0.1550            Median :-0.949          
##  Mean   :-0.0763            Mean   :-0.887          
##  3rd Qu.: 0.5139            3rd Qu.:-0.846          
##  Max.   : 1.0000            Max.   : 1.000          
##  fBodyBodyGyroMag-meanFreq() fBodyBodyGyroMag-skewness()
##  Min.   :-1.0000             Min.   :-1.000             
##  1st Qu.:-0.2344             1st Qu.:-0.500             
##  Median :-0.0521             Median :-0.318             
##  Mean   :-0.0416             Mean   :-0.264             
##  3rd Qu.: 0.1516             3rd Qu.:-0.085             
##  Max.   : 1.0000             Max.   : 1.000             
##  fBodyBodyGyroMag-kurtosis() fBodyBodyGyroJerkMag-mean()
##  Min.   :-1.000              Min.   :-1.000             
##  1st Qu.:-0.808              1st Qu.:-0.992             
##  Median :-0.665              Median :-0.945             
##  Mean   :-0.576              Mean   :-0.780             
##  3rd Qu.:-0.439              3rd Qu.:-0.612             
##  Max.   : 1.000              Max.   : 1.000             
##  fBodyBodyGyroJerkMag-std() fBodyBodyGyroJerkMag-mad()
##  Min.   :-1.000             Min.   :-1.000            
##  1st Qu.:-0.993             1st Qu.:-0.992            
##  Median :-0.938             Median :-0.935            
##  Mean   :-0.792             Mean   :-0.773            
##  3rd Qu.:-0.644             3rd Qu.:-0.610            
##  Max.   : 1.000             Max.   : 1.000            
##  fBodyBodyGyroJerkMag-max() fBodyBodyGyroJerkMag-min()
##  Min.   :-1.000             Min.   :-1.000            
##  1st Qu.:-0.994             1st Qu.:-0.994            
##  Median :-0.943             Median :-0.973            
##  Mean   :-0.810             Mean   :-0.871            
##  3rd Qu.:-0.685             3rd Qu.:-0.806            
##  Max.   : 1.000             Max.   : 1.000            
##  fBodyBodyGyroJerkMag-sma() fBodyBodyGyroJerkMag-energy()
##  Min.   :-1.000             Min.   :-1.000               
##  1st Qu.:-0.992             1st Qu.:-1.000               
##  Median :-0.945             Median :-0.998               
##  Mean   :-0.780             Mean   :-0.938               
##  3rd Qu.:-0.612             3rd Qu.:-0.923               
##  Max.   : 1.000             Max.   : 1.000               
##  fBodyBodyGyroJerkMag-iqr() fBodyBodyGyroJerkMag-entropy()
##  Min.   :-1.000             Min.   :-1.000                
##  1st Qu.:-0.991             1st Qu.:-0.923                
##  Median :-0.942             Median :-0.414                
##  Mean   :-0.773             Mean   :-0.274                
##  3rd Qu.:-0.605             3rd Qu.: 0.337                
##  Max.   : 1.000             Max.   : 1.000                
##  fBodyBodyGyroJerkMag-maxInds fBodyBodyGyroJerkMag-meanFreq()
##  Min.   :-1.000               Min.   :-1.0000                
##  1st Qu.:-0.968               1st Qu.:-0.0195                
##  Median :-0.905               Median : 0.1362                
##  Mean   :-0.900               Mean   : 0.1267                
##  3rd Qu.:-0.873               3rd Qu.: 0.2890                
##  Max.   : 1.000               Max.   : 1.0000                
##  fBodyBodyGyroJerkMag-skewness() fBodyBodyGyroJerkMag-kurtosis()
##  Min.   :-1.000                  Min.   :-1.000                 
##  1st Qu.:-0.536                  1st Qu.:-0.842                 
##  Median :-0.335                  Median :-0.703                 
##  Mean   :-0.299                  Mean   :-0.618                 
##  3rd Qu.:-0.113                  3rd Qu.:-0.488                 
##  Max.   : 1.000                  Max.   : 1.000                 
##  angle(tBodyAccMean,gravity) angle(tBodyAccJerkMean),gravityMean)
##  Min.   :-1.0000             Min.   :-1.0000                     
##  1st Qu.:-0.1247             1st Qu.:-0.2870                     
##  Median : 0.0081             Median : 0.0077                     
##  Mean   : 0.0077             Mean   : 0.0026                     
##  3rd Qu.: 0.1490             3rd Qu.: 0.2915                     
##  Max.   : 1.0000             Max.   : 1.0000                     
##  angle(tBodyGyroMean,gravityMean) angle(tBodyGyroJerkMean,gravityMean)
##  Min.   :-1.0000                  Min.   :-1.0000                     
##  1st Qu.:-0.4931                  1st Qu.:-0.3890                     
##  Median : 0.0172                  Median :-0.0072                     
##  Mean   : 0.0177                  Mean   :-0.0092                     
##  3rd Qu.: 0.5361                  3rd Qu.: 0.3660                     
##  Max.   : 1.0000                  Max.   : 1.0000                     
##  angle(X,gravityMean) angle(Y,gravityMean)
##  Min.   :-1.000       Min.   :-1.0000     
##  1st Qu.:-0.817       1st Qu.: 0.0022     
##  Median :-0.716       Median : 0.1820     
##  Mean   :-0.496       Mean   : 0.0633     
##  3rd Qu.:-0.521       3rd Qu.: 0.2508     
##  Max.   : 1.000       Max.   : 1.0000
```
#### Get the structure of the data

```r
str(data);
```

```
## 'data.frame':	10299 obs. of  562 variables:
##  $ subject                             : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ activity                            : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##  $ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
##  $ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
##  $ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
##  $ tBodyAcc-std()-Z                    : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
##  $ tBodyAcc-mad()-X                    : num  -0.953 -0.987 -0.994 -0.995 -0.994 ...
##  $ tBodyAcc-mad()-Y                    : num  -0.925 -0.968 -0.971 -0.974 -0.966 ...
##  $ tBodyAcc-mad()-Z                    : num  -0.674 -0.946 -0.963 -0.969 -0.977 ...
##  $ tBodyAcc-max()-X                    : num  -0.894 -0.894 -0.939 -0.939 -0.939 ...
##  $ tBodyAcc-max()-Y                    : num  -0.555 -0.555 -0.569 -0.569 -0.561 ...
##  $ tBodyAcc-max()-Z                    : num  -0.466 -0.806 -0.799 -0.799 -0.826 ...
##  $ tBodyAcc-min()-X                    : num  0.717 0.768 0.848 0.848 0.849 ...
##  $ tBodyAcc-min()-Y                    : num  0.636 0.684 0.668 0.668 0.671 ...
##  $ tBodyAcc-min()-Z                    : num  0.789 0.797 0.822 0.822 0.83 ...
##  $ tBodyAcc-sma()                      : num  -0.878 -0.969 -0.977 -0.974 -0.975 ...
##  $ tBodyAcc-energy()-X                 : num  -0.998 -1 -1 -1 -1 ...
##  $ tBodyAcc-energy()-Y                 : num  -0.998 -1 -1 -0.999 -0.999 ...
##  $ tBodyAcc-energy()-Z                 : num  -0.934 -0.998 -0.999 -0.999 -0.999 ...
##  $ tBodyAcc-iqr()-X                    : num  -0.976 -0.994 -0.993 -0.995 -0.993 ...
##  $ tBodyAcc-iqr()-Y                    : num  -0.95 -0.974 -0.974 -0.979 -0.967 ...
##  $ tBodyAcc-iqr()-Z                    : num  -0.83 -0.951 -0.965 -0.97 -0.976 ...
##  $ tBodyAcc-entropy()-X                : num  -0.168 -0.302 -0.618 -0.75 -0.591 ...
##  $ tBodyAcc-entropy()-Y                : num  -0.379 -0.348 -0.695 -0.899 -0.74 ...
##  $ tBodyAcc-entropy()-Z                : num  0.246 -0.405 -0.537 -0.554 -0.799 ...
##  $ tBodyAcc-arCoeff()-X,1              : num  0.521 0.507 0.242 0.175 0.116 ...
##  $ tBodyAcc-arCoeff()-X,2              : num  -0.4878 -0.1565 -0.115 -0.0513 -0.0289 ...
##  $ tBodyAcc-arCoeff()-X,3              : num  0.4823 0.0407 0.0327 0.0342 -0.0328 ...
##  $ tBodyAcc-arCoeff()-X,4              : num  -0.0455 0.273 0.1924 0.1536 0.2943 ...
##  $ tBodyAcc-arCoeff()-Y,1              : num  0.21196 0.19757 -0.01194 0.03077 0.00063 ...
##  $ tBodyAcc-arCoeff()-Y,2              : num  -0.1349 -0.1946 -0.0634 -0.1293 -0.0453 ...
##  $ tBodyAcc-arCoeff()-Y,3              : num  0.131 0.411 0.471 0.446 0.168 ...
##  $ tBodyAcc-arCoeff()-Y,4              : num  -0.0142 -0.3405 -0.5074 -0.4195 -0.0682 ...
##  $ tBodyAcc-arCoeff()-Z,1              : num  -0.106 0.0776 0.1885 0.2715 0.0744 ...
##  $ tBodyAcc-arCoeff()-Z,2              : num  0.0735 -0.084 -0.2316 -0.2258 0.0271 ...
##  $ tBodyAcc-arCoeff()-Z,3              : num  -0.1715 0.0353 0.6321 0.4164 -0.1459 ...
##  $ tBodyAcc-arCoeff()-Z,4              : num  0.0401 -0.0101 -0.5507 -0.2864 -0.0502 ...
##  $ tBodyAcc-correlation()-X,Y          : num  0.077 -0.105 0.3057 -0.0638 0.2352 ...
##  $ tBodyAcc-correlation()-X,Z          : num  -0.491 -0.429 -0.324 -0.167 0.29 ...
##  $ tBodyAcc-correlation()-Y,Z          : num  -0.709 0.399 0.28 0.545 0.458 ...
##  $ tGravityAcc-mean()-X                : num  0.936 0.927 0.93 0.929 0.927 ...
##  $ tGravityAcc-mean()-Y                : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
##  $ tGravityAcc-mean()-Z                : num  0.115 0.153 0.146 0.143 0.138 ...
##  $ tGravityAcc-std()-X                 : num  -0.925 -0.989 -0.996 -0.993 -0.996 ...
##  $ tGravityAcc-std()-Y                 : num  -0.937 -0.984 -0.988 -0.97 -0.971 ...
##  $ tGravityAcc-std()-Z                 : num  -0.564 -0.965 -0.982 -0.992 -0.968 ...
##  $ tGravityAcc-mad()-X                 : num  -0.93 -0.989 -0.996 -0.993 -0.996 ...
##  $ tGravityAcc-mad()-Y                 : num  -0.938 -0.983 -0.989 -0.971 -0.971 ...
##  $ tGravityAcc-mad()-Z                 : num  -0.606 -0.965 -0.98 -0.993 -0.969 ...
##  $ tGravityAcc-max()-X                 : num  0.906 0.856 0.856 0.856 0.854 ...
##  $ tGravityAcc-max()-Y                 : num  -0.279 -0.305 -0.305 -0.305 -0.313 ...
##  $ tGravityAcc-max()-Z                 : num  0.153 0.153 0.139 0.136 0.134 ...
##  $ tGravityAcc-min()-X                 : num  0.944 0.944 0.949 0.947 0.946 ...
##  $ tGravityAcc-min()-Y                 : num  -0.262 -0.262 -0.262 -0.273 -0.279 ...
##  $ tGravityAcc-min()-Z                 : num  -0.0762 0.149 0.145 0.1421 0.1309 ...
##  $ tGravityAcc-sma()                   : num  -0.0178 0.0577 0.0406 0.0461 0.0554 ...
##  $ tGravityAcc-energy()-X              : num  0.829 0.806 0.812 0.809 0.804 ...
##  $ tGravityAcc-energy()-Y              : num  -0.865 -0.858 -0.86 -0.854 -0.843 ...
##  $ tGravityAcc-energy()-Z              : num  -0.968 -0.957 -0.961 -0.963 -0.965 ...
##  $ tGravityAcc-iqr()-X                 : num  -0.95 -0.988 -0.996 -0.992 -0.996 ...
##  $ tGravityAcc-iqr()-Y                 : num  -0.946 -0.982 -0.99 -0.973 -0.972 ...
##  $ tGravityAcc-iqr()-Z                 : num  -0.76 -0.971 -0.979 -0.996 -0.969 ...
##  $ tGravityAcc-entropy()-X             : num  -0.425 -0.729 -0.823 -0.823 -0.83 ...
##  $ tGravityAcc-entropy()-Y             : num  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
##  $ tGravityAcc-entropy()-Z             : num  0.219 -0.465 -0.53 -0.7 -0.302 ...
##  $ tGravityAcc-arCoeff()-X,1           : num  -0.43 -0.51 -0.295 -0.343 -0.482 ...
##  $ tGravityAcc-arCoeff()-X,2           : num  0.431 0.525 0.305 0.359 0.539 ...
##  $ tGravityAcc-arCoeff()-X,3           : num  -0.432 -0.54 -0.315 -0.375 -0.596 ...
##  $ tGravityAcc-arCoeff()-X,4           : num  0.433 0.554 0.326 0.392 0.655 ...
##  $ tGravityAcc-arCoeff()-Y,1           : num  -0.795 -0.746 -0.232 -0.233 -0.493 ...
##  $ tGravityAcc-arCoeff()-Y,2           : num  0.781 0.733 0.169 0.176 0.463 ...
##  $ tGravityAcc-arCoeff()-Y,3           : num  -0.78 -0.737 -0.155 -0.169 -0.465 ...
##  $ tGravityAcc-arCoeff()-Y,4           : num  0.785 0.749 0.164 0.185 0.483 ...
##  $ tGravityAcc-arCoeff()-Z,1           : num  -0.984 -0.845 -0.429 -0.297 -0.536 ...
##  $ tGravityAcc-arCoeff()-Z,2           : num  0.987 0.869 0.44 0.304 0.544 ...
##  $ tGravityAcc-arCoeff()-Z,3           : num  -0.989 -0.893 -0.451 -0.311 -0.553 ...
##  $ tGravityAcc-arCoeff()-Z,4           : num  0.988 0.913 0.458 0.315 0.559 ...
##  $ tGravityAcc-correlation()-X,Y       : num  0.981 0.945 0.548 0.986 0.998 ...
##  $ tGravityAcc-correlation()-X,Z       : num  -0.996 -0.911 -0.335 0.653 0.916 ...
##  $ tGravityAcc-correlation()-Y,Z       : num  -0.96 -0.739 0.59 0.747 0.929 ...
##  $ tBodyAccJerk-mean()-X               : num  0.072 0.0702 0.0694 0.0749 0.0784 ...
##  $ tBodyAccJerk-mean()-Y               : num  0.04575 -0.01788 -0.00491 0.03227 0.02228 ...
##  $ tBodyAccJerk-mean()-Z               : num  -0.10604 -0.00172 -0.01367 0.01214 0.00275 ...
##  $ tBodyAccJerk-std()-X                : num  -0.907 -0.949 -0.991 -0.991 -0.992 ...
##  $ tBodyAccJerk-std()-Y                : num  -0.938 -0.973 -0.971 -0.973 -0.979 ...
##  $ tBodyAccJerk-std()-Z                : num  -0.936 -0.978 -0.973 -0.976 -0.987 ...
##  $ tBodyAccJerk-mad()-X                : num  -0.916 -0.969 -0.991 -0.99 -0.991 ...
##  $ tBodyAccJerk-mad()-Y                : num  -0.937 -0.974 -0.973 -0.973 -0.977 ...
##  $ tBodyAccJerk-mad()-Z                : num  -0.949 -0.979 -0.975 -0.978 -0.985 ...
##  $ tBodyAccJerk-max()-X                : num  -0.903 -0.915 -0.992 -0.992 -0.994 ...
##  $ tBodyAccJerk-max()-Y                : num  -0.95 -0.981 -0.975 -0.975 -0.986 ...
##  $ tBodyAccJerk-max()-Z                : num  -0.891 -0.978 -0.962 -0.962 -0.986 ...
##  $ tBodyAccJerk-min()-X                : num  0.898 0.898 0.994 0.994 0.994 ...
##  $ tBodyAccJerk-min()-Y                : num  0.95 0.968 0.976 0.976 0.98 ...
##  $ tBodyAccJerk-min()-Z                : num  0.946 0.966 0.966 0.97 0.985 ...
##  $ tBodyAccJerk-sma()                  : num  -0.931 -0.974 -0.982 -0.983 -0.987 ...
##  $ tBodyAccJerk-energy()-X             : num  -0.995 -0.998 -1 -1 -1 ...
##   [list output truncated]
```
#### See a table of subject

```r
table(data$subject);
```

```
## 
##   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18 
## 347 302 341 317 302 325 308 281 288 294 316 320 327 323 328 366 368 364 
##  19  20  21  22  23  24  25  26  27  28  29  30 
## 360 354 408 321 372 381 409 392 376 382 344 383
```
#### See a table of activity

```r
table(data$activity);
```

```
## 
##             LAYING            SITTING           STANDING 
##               1944               1777               1906 
##            WALKING WALKING_DOWNSTAIRS   WALKING_UPSTAIRS 
##               1722               1406               1544
```
#### See a two dimensional table of subject and activity

```r
table(data$subject, data$activity);
```

```
##     
##      LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
##   1       0       0        0     347                  0                0
##   2       0       0        0     302                  0                0
##   3       0       0        0     341                  0                0
##   4       0       0        0     194                  0              123
##   5       0       0        0     302                  0                0
##   6       0       0        0     236                  0               89
##   7       0       0        0       0                  0              308
##   8       0       0        0       0                  0              281
##   9       0       0        0       0                  0              288
##   10      0       0        0       0                234               60
##   11      0       0        0       0                  0              316
##   12      0     134        0       0                186                0
##   13      0     327        0       0                  0                0
##   14      0       0        0       0                244               79
##   15      0       0        0       0                328                0
##   16      0       0        0       0                366                0
##   17      0     320        0       0                 48                0
##   18      0      30      334       0                  0                0
##   19      0     360        0       0                  0                0
##   20    156       0      198       0                  0                0
##   21      0     408        0       0                  0                0
##   22      0     198      123       0                  0                0
##   23      0       0      372       0                  0                0
##   24    381       0        0       0                  0                0
##   25      0       0      409       0                  0                0
##   26      0       0      392       0                  0                0
##   27    298       0       78       0                  0                0
##   28    382       0        0       0                  0                0
##   29    344       0        0       0                  0                0
##   30    383       0        0       0                  0                0
```
#### Check if there are any NAs

```r
sum(is.na(data))
```

```
## [1] 0
```
#### Check NA by columns, subset

```r
head(colSums(is.na(data)), 10)
```

```
##           subject          activity tBodyAcc-mean()-X tBodyAcc-mean()-Y 
##                 0                 0                 0                 0 
## tBodyAcc-mean()-Z  tBodyAcc-std()-X  tBodyAcc-std()-Y  tBodyAcc-std()-Z 
##                 0                 0                 0                 0 
##  tBodyAcc-mad()-X  tBodyAcc-mad()-Y 
##                 0                 0
```
