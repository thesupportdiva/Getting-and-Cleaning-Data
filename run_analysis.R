#Set directory and warning values
options( warn = -1 )

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

#Merge the training and the test sets to create one data set.

#Labels
featureLabels <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Training data
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

#Test data
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)

#Combine training and test data by subject, activity and features
subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(activityTest, activityTrain)
features <- rbind(featuresTest, featuresTrain)

#Set column names
colnames(subject) <- c("Subject")
colnames(activity) <- c("Activity")
colnames(features) <- featureLabels$V2

#Combine subject, activity and features into final data set
mergeData <- cbind(activity, subject)
data <- cbind(mergeData, features)

#Extract only the mean and standard deviation columns for the final data set.
wantedFeatures <-featureLabels$V2[grep("mean|std", featureLabels$V2)]
selectedNames <- c("Activity", "Subject", as.character(wantedFeatures))
data <- subset(data, select = selectedNames)

#Use descriptive activity names to name the activities in the data set
data$Activity <- factor(data$Activity,levels=activityLabels$V1,labels=activityLabels$V2)

#Appropriately label the data set with descriptive variable names. 
colnames(data) <- gsub("^t", "Time", colnames(data))
colnames(data) <- gsub("^f", "Frequency", colnames(data))
colnames(data) <- gsub("Acc", "Accelerometer", colnames(data))
colnames(data) <- gsub("Gyro", "Gyroscope", colnames(data))
colnames(data) <- gsub("Mag", "Magnitude", colnames(data)) 
colnames(data) <- gsub("BodyBody", "Body", colnames(data))

#Aggregate the data by subject and activity and find the mean for each measurement
data <- aggregate(. ~Subject + Activity, data, mean)

#Display the resulting data in R 
View(data)

#Create a tidy.csv file that contains the mean data for subject and activity
write.table(data,file="tidy.csv",sep=",",row.names = FALSE)
