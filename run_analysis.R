#You should create one R script called run_analysis.R that does the following. 

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("/Users/dmcgahan/Desktop")

directory <- "Donna_Project"
if (!file.exists(directory)){
  dir.create(directory)      
}

setwd(directory)

#Download the data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
unzip("Dataset.zip")

library(data.table)
library(dplyr)

#Merges the training and the test sets to create one data set.

featureLabels <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)


subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)

subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(activityTest, activityTrain)
features <- rbind(featuresTest, featuresTrain)

colnames(subject) <- c("Subject")
colnames(activity) <- c("Activity")
colnames(features) <- featureLabels$V2

mergeData <- cbind(activity, subject)
data <- cbind(mergeData, features)

wantedFeatures <-featureLabels$V2[grep("mean|std", featureLabels$V2)]
#Can I use a select?

selectedNames <- c("Activity", "Subject", as.character(wantedFeatures))

data <- subset(data, select = selectedNames)

data$Activity <- factor(data$Activity,levels=activityLabels$V1,labels=activityLabels$V2)

colnames(data) <- gsub("^t", "Time", colnames(data))
colnames(data) <- gsub("^f", "Frequency", colnames(data))
colnames(data) <- gsub("Acc", "Accelerometer", colnames(data))
colnames(data) <- gsub("Gyro", "Gyroscope", colnames(data))
colnames(data) <- gsub("Mag", "Magnitude", colnames(data)) 
colnames(data) <- gsub("BodyBody", "Body", colnames(data))

data <- aggregate(. ~Subject + Activity, data, mean)
        
View(data)

write.table(data,file="tidy.csv",sep=",",row.names = FALSE)
