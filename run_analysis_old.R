## Coursera: Getting and Cleaning Data ##
## Course Project ##
## Programmer: Bruce Walthers ##

## set working directory
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/course_project")
## load packages
library(tidyr)
library(dplyr)

## Pre-work ## Read in the data for each item
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
train_data<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_data_labels<-read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
test_data<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_data_labels<-read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")

##### Step #1 - Merge training and test Datasets
merged_train_data<-cbind(train_subject, train_data_labels, train_data) ## merge train data into one data frame
merged_test_data<-cbind(test_subject, test_data_labels, test_data) ## merge train data into one data frame
merged_data<-rbind(merged_train_data, merged_test_data)   ## merged of full train and test dataset
rm(train_data) ## free up memory by removing data that is no longer needed
rm(train_data_labels) ## free up memory by removing data that is no longer needed
rm(train_subject) ## free up memory by removing data that is no longer needed
rm(test_data) ## free up memory by removing data that is no longer needed
rm(test_data_labels) ## free up memory by removing data that is no longer needed
rm(test_subject) ## free up memory by removing data that is no longer needed
rm(merged_test_data) ## free up memory by removing data that is no longer needed
rm(merged_train_data) ## free up memory by removing data that is no longer needed

 
##### Step #2 - Extract only the measurements on the mean and standard deviation
#####    Note: I am adding the variable names (column names) here in step #2 to 
#####    to make the filtering of my variables easier.
## find columns with mean and std in the name      
feature_names<-features$V2 ## pull variable names from feature data frame
feature_names<-as.character(feature_names) ## convert to character
subject_activity_vector<-c("subject", "activity") ## create a temporary vector of variable names
feature_names2<-c(subject_activity_vector, feature_names) ## add subject and activity to feature_names character vector
feature_names2<-gsub("\\()","",feature_names2)  ## remove paratheses from feature names
feature_names2<-gsub("^f","freq-",feature_names2) ##replace initial f with "freq"
feature_names2<-gsub("^t","time-",feature_names2) ##replace initial t with "time"
feature_names2<-make.names(feature_names2, unique =T, allow_ = TRUE) ## removes illegal characters and makes colnames unique
table(duplicated(feature_names2)) ## check for duplicate column names
names(merged_data)<-feature_names2 ## add feature names to column for train data
rm(subject_activity_vector) ## free up memory by removing data that is no longer needed
filtered_var<-merged_data[,grepl("mean|std", colnames(merged_data), ignore.case=TRUE)]
## merged_data2 is the output of the measurement extraction process in step #2
merged_data2<-cbind(merged_data[,1:2],filtered_var) ## added "subject" and "activity" variable to measurement data frame
merged_data2[,1] <- as.factor(merged_data2[,1]) ## convert the "subject" column to a factor
merged_data2[,2] <- as.factor(merged_data2[,2]) ## convert the "activity" column to a factor
rm(filtered_var)

##### Step #3 - Use descriptive activity names to name the activities in the data set
merged_data2[,2]<-gsub("1","WALKING",merged_data2[,2])
merged_data2[,2]<-gsub("2","WALKING_UPSTAIRS",merged_data2[,2])
merged_data2[,2]<-gsub("3","WALKING_DOWNSTAIRS",merged_data2[,2])
merged_data2[,2]<-gsub("4","SITTING",merged_data2[,2])
merged_data2[,2]<-gsub("5","STANDING",merged_data2[,2])
merged_data2[,2]<-gsub("6","LAYING",merged_data2[,2])

##### Step #4 - Appropriately label the data set with descriptive variable names
## This was done as part of Step #2 to make it easier for me to filter variables.

##### Step #5 Create a second, independent tidy data set with the average for each variable for each activity and each subject


