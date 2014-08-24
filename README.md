---
title: "README"
date: "Sunday, August 24, 2014"
output: html_document
---

# Files
- run_analysis.R
- avg.txt
- CodeBook.md
- README.md


# run_analysis.R



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
data_melt <- melt(data, id = c("subject", "activity"));
avg <- dcast(data_melt, activity + subject ~ variable, mean);
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
head(avg[,1:4])
```

```
##   activity subject tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1   LAYING      20            0.2682          -0.01544
## 2   LAYING      24            0.2768          -0.01768
## 3   LAYING      27            0.2778          -0.01694
## 4   LAYING      28            0.2775          -0.01917
## 5   LAYING      29            0.2791          -0.01847
## 6   LAYING      30            0.2763          -0.01759
```


### Write the tidy data to a file

```r
write.table(avg, file = "avg.txt", row.name=FALSE);
```
