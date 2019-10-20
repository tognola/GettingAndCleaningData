---
title: "README"
author: "Gastón Tognola"
date: "20/10/2019"
output: html_document
---

## Data

The "raw" data for this assignment are available for [download here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Files

**CodeBook.md**  
Describes the variables, data and transformations needed to clean up the dataset.

**run_analysis.R**  
The R-script that contains all of the steps necessary to get a tidy dataset from the provided "raw" data.


## Course Project

#### Loading training data
Read the training data from the dataset.
```
trainingset <- read.table("dataset/train/X_train.txt")
traininglabels <- read.table("dataset/train/y_train.txt")
trainingsubjects <- read.table("dataset/train/subject_train.txt")
```

#### Loading test data
Read the test data from the data set.
```
testsets <- read.table("dataset/test/X_test.txt")
testlabels <- read.table("dataset/test/y_test.txt")
testsubjects <- read.table("dataset/test/subject_test.txt")
```

#### Merging data
Binding columns to identify the activity and subject of the training and test data.
```
trainingdata <- cbind(trainingsubjects, traininglabels, trainingset)
```
```
testdata <- cbind(testsubjects, testlabels, testsets)
```

Then bind the rows to merge the training and the test sets to create one data set.

```
data <- rbind(trainingdata, testdata)
```

#### Activity names
Uses descriptive activity names to name the activities in the data set
```
features <- read.table("dataset/features.txt", colClasses = c("numeric", "character"))
features <-rbind(c(1,"subject"), c(2, "activity"),features)
names(data) <- features$V2
```

#### Mean and standard variables
Extracts only the measurements on the mean and standard deviation for each measurement.

```
cols <- c(1,2,which(grepl("std()", names(data))),which(grepl("mean()", names(data))))
cols <- sort(cols)
data <- subset(data, select = cols)
```

#### Activity labels
Appropriately labels the data set with descriptive variable names.
```
activiylabels <- read.table("dataset/activity_labels.txt", colClasses = c("numeric", "character"))

data$activity <- factor(data$activity, levels = c(1:6), labels = activiylabels$V2)

write.csv(data, file ="cleandata.txt")
```

#### Avarages
From the previous data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```
avarages <- split(data, d$activity)

for (i in 1:6) {
  avarages[[i]] <- lapply(c[[i]][,-(1:2)], mean)
}

write.csv(avarages, file = "avarages.txt")
```
