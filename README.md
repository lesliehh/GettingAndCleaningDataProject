---
title: "README"
date: "Sunday, August 24, 2014"
output: html_document
---

## Files

- README.md
- CodeBook.md
- avg.txt
- run_analysis.R


## 1. README.md

The README.md file is the file that you are currently reading. It is the file that describes the files that are in this directory. This file is created by the .Rmd version of itself (README.Rmd).

## 2. CodeBook.md

The CodeBook.md file describes the data and what transformations were done to the original data. This file is created by the .Rmd version of itself (CodeBook.Rmd).

## 2. avg.txt

This text file is the output of the run_analysis.R file. It contains the average of the variables for each subject/activity pair. In other words, for each subject and activity, there will be an average value for each variable measured. 

## 4. run_analysis.R

Below we describe what the run_analysis.R file does in each step.



### Download and unzip the files

```r
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
file <- "../ProjectData.zip";
download.file(url, destfile = file);
unzip(file);
```

### Load the files into R

```r
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

### Merges the training and the test sets to create one data set.

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
# Output sample data, make sure it works
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

### See how the data is structred (output is in the CodeBook.md file)

```r
# Get the size of the data
print(object.size(data), units="Mb")
# Get a summary of the data
summary(data);
# Get the structure of the data
str(data);
# See a table of subject
table(data$subject);
# See a table of activity
table(data$activity);
# See a two dimensional table of subject and activity
table(data$subject, data$activity);
# Check if there are any NAs
sum(is.na(data))
# Check NA by columns, subset
head(colSums(is.na(data)), 10)
```

### Extracts only the measurements on the mean and standard deviation for each measurement. 

```r
avg <- apply(data[,3:562], 2, mean)
std <- apply(data[,3:562], 2, sd)
avg <- as.data.frame(avg);
std <- as.data.frame(std);
avg_sd <- cbind(avg, std);
# Output sample data, make sure it works
head(avg_sd)
```

```
##                        avg     std
## tBodyAcc-mean()-X  0.27435 0.06763
## tBodyAcc-mean()-Y -0.01774 0.03713
## tBodyAcc-mean()-Z -0.10893 0.05303
## tBodyAcc-std()-X  -0.60778 0.43869
## tBodyAcc-std()-Y  -0.51019 0.50024
## tBodyAcc-std()-Z  -0.61306 0.40366
```

### Uses descriptive activity names to name the activities in the data set
This step was done above, during merging of the data sets

### Appropriately labels the data set with descriptive variable names. 
This step was done above, during merging of the data sets

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

```r
library(reshape2);
```

```
## Warning: package 'reshape2' was built under R version 3.0.3
```

```r
data_melt <- melt(data, id = c("subject", "activity"));
avg <- dcast(data_melt, subject + activity ~ variable, mean);
```
#### Output sample data, make sure it works

```r
head(data_melt)
```

```
##   subject activity          variable  value
## 1       2  WALKING tBodyAcc-mean()-X 0.2572
## 2       2  WALKING tBodyAcc-mean()-X 0.2860
## 3       2  WALKING tBodyAcc-mean()-X 0.2755
## 4       2  WALKING tBodyAcc-mean()-X 0.2703
## 5       2  WALKING tBodyAcc-mean()-X 0.2748
## 6       2  WALKING tBodyAcc-mean()-X 0.2792
```

```r
head(avg[,1:4], 10)
```

```
##    subject         activity tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1        1          WALKING            0.2657          -0.01830
## 2        2          WALKING            0.2731          -0.01913
## 3        3          WALKING            0.2734          -0.01786
## 4        4          WALKING            0.2770          -0.01335
## 5        4 WALKING_UPSTAIRS            0.2697          -0.01711
## 6        5          WALKING            0.2792          -0.01548
## 7        6          WALKING            0.2694          -0.01639
## 8        6 WALKING_UPSTAIRS            0.2802          -0.02069
## 9        7 WALKING_UPSTAIRS            0.2702          -0.01879
## 10       8 WALKING_UPSTAIRS            0.2708          -0.01819
```


### Write the tidy data to the avg.txt file

```r
write.table(avg, file = "avg.txt", row.name=FALSE);
```

### Create the .md version of the Rmd files

```r
library(knitr)
knit("README.Rmd")
knit("CodeBook.Rmd")
```
