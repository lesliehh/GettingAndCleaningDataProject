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
