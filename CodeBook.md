# CodeBook

This describes the variables, the data, and transformations that I performed to clean up the data.

## Data source

* Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Input files

Unzipped from the downloaded zip file and stored under "./data" folder:
- features.txt
- activity_labels.txt
- train/X_train.txt
- train/Y_train.txt
- test/X_test.txt
- test/Y_test.txt
- train/subject_train.txt
- train/subject_test.txt

## Variables and Transformations

Initialized from text files:
- dfSubjectTrain - this data frame table stores subject train data, read from subject_train.txt
- dfSubjectTest - this data frame table stores subject test data, read from subject_test.txt
- dfXTrain - this data frame table stores X (features) train data, read from X_train.txt
- dfXTest - this data frame table stores X (features) test data, read from X_test.txt
- dfYTrain - this data frame table stores Y (activity) train data, read from Y_train.txt
- dfYTest - this data frame table stores Y (activity) test data, read from Y_train.txt
- dfFeatures - this data frame table stores features data (feature codes and names), read from features.txt
- dfActivityLabels - this data frame table stores activity labels data, read from activity_labels.txt


Merged:
- dfSubjectTrain - this data frame table stores subject train + test data, formed by merging rows 
- dfXTrain - this data frame table stores X (features) train + test data, formed by merging rows
- dfYTrain - this data frame table stores Y (activity) train + test data, formed by merging rows
- dfMerged - this data frame table stores all data, formed by merging columns of previous 3 data frame tables


Processed:
- dfMerged - this data frame table (created above) is processed to add one more column (activity name) and then columns are reordered and renamed properly
- dfMean -  this data frame table is the aggregated view (mean by subject and activity name) of dfMerged

## Output file
- tidy.txt - dfMean (aggregated view of processed data) is stored to local disk under the current working folder
