# 
# Peer-graded Assignment: Getting and Cleaning Data Course Project
#

# Install required packages if not already installed
requiredPackages <- c("data.table", "dplyr")
newPackages <- requiredPackages[!(requiredPackages %in% installed.packages()[,"Package"])]
if(length(newPackages)) install.packages(newPackages)

# load required packages
library(data.table)
library(dplyr)

############################################################################################ 
# Step 0. Download data for this project, unzip locally, and load data
############################################################################################ 

if (!file.exists("./data")) { dir.create("./data") }
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./data/Dataset.zip") # This works fine on Windows
unzip("./data/Dataset.zip", exdir="./data", overwrite = TRUE)
path <- file.path("./data" , "UCI HAR Dataset")

# Load various train, test, features, and labels data from unzipped text files
dfSubjectTrain <- tbl_df(read.table(file.path(path, "train", "subject_train.txt")))
dfSubjectTest  <- tbl_df(read.table(file.path(path, "test" , "subject_test.txt")))
dfXTrain <- tbl_df(read.table(file.path(path, "train", "X_train.txt")))
dfXTest  <- tbl_df(read.table(file.path(path, "test" , "X_test.txt" )))
dfYTrain <- tbl_df(read.table(file.path(path, "train", "Y_train.txt")))
dfYTest  <- tbl_df(read.table(file.path(path, "test" , "Y_test.txt" )))
dfFeatures <- tbl_df(read.table(file.path(path, "features.txt")))
dfActivityLabels <- tbl_df(read.table(file.path(path, "activity_labels.txt")))


############################################################################################ 
# Step 1. Merges the training and the test sets to create one data set.
############################################################################################ 

# For each type, merge train and test data using row binding
dfSubject <- rbind(dfSubjectTrain, dfSubjectTest)
dfY <- rbind(dfYTrain, dfYTest)
dfX <- rbind(dfXTrain, dfXTest)

# Set meaningful column names for data frames
colnames(dfSubject) <- "subject"   
colnames(dfY) <- "activityCode"
colnames(dfFeatures) <- c("featureCode", "featureName")  
colnames(dfX) <- make.names(dfFeatures$featureName, unique = TRUE)   # column names of dfX set using features data
colnames(dfActivityLabels) <- c("activityCode", "activityName")

# Merge train and test data using column binding
dfMerged <- cbind(dfSubject, dfX, dfY) 


################################################################################################# 
# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
################################################################################################# 

# Extract subset for only those feature names matching select key words
dfMerged <- select(dfMerged, matches("mean|std|subject|activityCode"))


################################################################################################# 
# Step 3. Uses descriptive activity names to name the activities in the data set
################################################################################################# 

dfMerged <- merge(dfMerged, dfActivityLabels, by = "activityCode")

# reorder columns to make subject, activityCode, and activityName the first 3 columns
dfMerged <- dfMerged[, c(2, 1, 89, 3:88)]
              

################################################################################################# 
# Step 4. Appropriately labels the data set with descriptive variable names.
################################################################################################# 

names(dfMerged) <- gsub("^t|^f", "", names(dfMerged))     # strip leading 't' and 'f'
names(dfMerged) <- gsub("tBody", "Body", names(dfMerged))    # 'tBody' sandwiched inside -> 'Body'  
names(dfMerged) <- gsub("std()", "StdDev", names(dfMerged))
names(dfMerged) <- gsub("mean()", "Mean", names(dfMerged))
names(dfMerged) <- gsub("Acc", "Accelerometer", names(dfMerged))
names(dfMerged) <- gsub("Gyro", "Gyroscope", names(dfMerged))
names(dfMerged) <- gsub("Mag", "Magnitude", names(dfMerged))
names(dfMerged) <- gsub("BodyBody", "Body", names(dfMerged))
names(dfMerged) <- gsub("\\.", " ", names(dfMerged)) # replace period by a single space
names(dfMerged) <- gsub("\\s+", " ", names(dfMerged)) # remove extra spaces, keep just one
names(dfMerged) <- gsub("^\\s+|\\s+$", "", names(dfMerged)) # remove leading/trailing spaces


################################################################################################# 
# Step 5. From the data set in step 4, creates a second, independent tidy data set with 
#         the average of each variable for each activity and each subject.
################################################################################################# 

# aggregate with mean function, then sort
dfMean <- tbl_df(aggregate(. ~ subject + activityName, dfMerged, mean)) 
dfMean <- arrange(dfMean, subject, activityName)


################################################################################################# 
# Please upload your data set as a txt file created with write.table() using row.name=FALSE 
################################################################################################# 

write.table(dfMean, file = "tidy.txt", row.name = FALSE)

# yay! I did it! :-)
