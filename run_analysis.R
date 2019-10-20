## Load training data
trainingset <- read.table("dataset/train/X_train.txt")
traininglabels <- read.table("dataset/train/y_train.txt")
trainingsubjects <- read.table("dataset/train/subject_train.txt")

## Load test data
testsets <- read.table("dataset/test/X_test.txt")
testlabels <- read.table("dataset/test/y_test.txt")
testsubjects <- read.table("dataset/test/subject_test.txt")

## Merge column to identify activity and subject of the training
trainingdata <- cbind(trainingsubjects, traininglabels, trainingset)

## Merge column to identify activity and subject of the test
testdata <- cbind(testsubjects, testlabels, testsets)

## Bind rows to merge all the data from the tests and trainings
data <- rbind(trainingdata, testdata)

features <- read.table("dataset/features.txt", colClasses = c("numeric", "character"))

features <-rbind(c(1,"subject"), c(2, "activity"),features)
names(data) <- features$V2

cols <- c(1,2,which(grepl("std()", names(data))),which(grepl("mean()", names(data))))
cols <- sort(cols)
data <- subset(data, select = cols)

activiylabels <- read.table("dataset/activity_labels.txt", colClasses = c("numeric", "character"))

data$activity <- factor(data$activity, levels = c(1:6), labels = activiylabels$V2)

write.csv(data, file ="cleandata.txt")

avarages <- split(data, d$activity)

for (i in 1:6) {
  avarages[[i]] <- lapply(c[[i]][,-(1:2)], mean)
}

write.csv(avarages, file = "avarages.txt")
