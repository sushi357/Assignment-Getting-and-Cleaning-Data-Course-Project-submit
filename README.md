# Assignment-Getting-and-Cleaning-Data-Course-Project-submit

The script “run_analysis” performs the following tasks:

-loads the data set “train.txt” from its directory 

-labels the variable names in the “train.txt” data set to correspond to the descriptive variable names contained in "features.txt"
adds the “activity” and “subject” variables contained in "y_train.txt" and “subject_train.txt”, respectively, to the “train.txt” data set

-the entries in the “activity” variable are converted from a numeric value to a descriptive character value according to the conversion contained in the “activity_labels” document

-the same above-mentioned steps are performed on the “test.txt” data set

-the “train.txt” and “test.txt” data sets are combined into a single data set

-a subset of the combined data set is taken containing only those variables that are a mean or standard deviation of a measurement

-the average of each remaining variable is calculated for each test subject and each activity level

-a new data frame is produced containing the averages of each variable for each test subject and each activity level

-this data frame is output as .txt table
