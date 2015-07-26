This is the course project for the Getting and Cleaning Data Coursera course. 
The R script, run_analysis.R, the function is as follows:

1. Download the dataset if it does not already exist in the working directory.
2. Load the activity, feature and Subject information for test and train dataset, and also load Feature name and ActivityLables.
3. Merge Train and Test Dataset.
4. Combine the Subject, Activity and Features column together.
5. Extracts only the measurements on the mean and standard deviation for each measurement.
6. Appropriately labels the data set with descriptive variable names.
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
8. The end result is shown in the file tidydata.txt.