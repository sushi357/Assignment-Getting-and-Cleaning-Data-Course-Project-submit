The script “run_analyis” takes data contained in the “Human Activity Recognition Using Smartphones Dataset” and produces an output .txt table containing averages of mean and standard deviation measurements contained in the original data set.

The script operates as follows:

Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Place the unzipped content into your current working directory.

Run the script to produce a data frame output as a text file. The output is an average of the mean and standard deviation measurements contained in the data for each test subject and activity level. The file is output to the work directory.

The script “run_analysis” performs the following tasks:

-loads the data set “train.txt” from its directory 

-labels the variable names in the “train.txt” data set to correspond to the descriptive variable names contained in "features.txt"

-adds the “activity” and “subject” variables contained in "y_train.txt" and “subject_train.txt”, respectively, to the “train.txt” data set

-the entries in the “activity” variable are converted from a numeric value to a descriptive character value according to the conversion contained in the “activity_labels” document

-the same above-mentioned steps are performed on the “test.txt” data set

-the “train.txt” and “test.txt” data sets are combined into a single data set

-a subset of the combined data set is taken containing only those variables that are a mean or standard deviation of a measurement

-the average of each remaining variable is calculated for each test subject and each activity level

-a new data frame is produced containing the averages of each variable for each test subject and each activity level
this data frame is output as .txt table
