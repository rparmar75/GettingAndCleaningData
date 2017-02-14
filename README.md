# "Getting And Cleaning Data" Assignment

## The Assignment

I was supposed to create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   
## Files 
* README.md: This document
* CodeBook.md: Codebook describing variables, data, and transformations
* ```run_analysis.R```: R code

## Steps 

1. Run ```source("run_analysis.R")```. 
2. The script creates "data" folder under the current working directory, that is "./data".
3. The script downloads the data (a zip file) and unzips under the "./data" folder.
4. The script loads data from various text files, merges and aggregates data  in memory as needed.
4. Finally, a tidy data file, ```tidy.txt```, is created under the current working directory.

## Dependencies

```run_analysis.R``` uses ```dplyr``` and ```data.table``` packages. The script installs them if not already installed.
