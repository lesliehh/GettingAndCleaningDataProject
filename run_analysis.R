setwd("C:/Base/Education/MOOC/Johns Hopkins - Data Science Specialization/Getting and Cleaning Data/GettingAndCleaningDataProject");


### Download and unzip the files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
file <- "../ProjectData.zip";
download.file(url, destfile = file);
unzip(file);


### Load the files into R
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


### Merges the training and the test sets to create one data set.
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



### Extracts only the measurements on the mean and standard deviation for each measurement. 
avg <- apply(data[,3:562], 2, mean)
std <- apply(data[,3:562], 2, sd)
avg <- as.data.frame(avg);
std <- as.data.frame(std);
avg_sd <- cbind(avg, std);
# Output sample data, make sure it works
head(avg_sd)

### Uses descriptive activity names to name the activities in the data set
# Done

### Appropriately labels the data set with descriptive variable names. 
# Done

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2);
data_melt <- melt(data, id = c("subject", "activity"));
avg <- dcast(data_melt, subject + activity ~ variable, mean);
# Output sample data, make sure it works
head(data_melt)
head(avg[,1:4], 10)


### Write the tidy data to a file
write.table(avg, file = "avg.txt", row.name=FALSE);


library(knitr)
knit("README.Rmd")
