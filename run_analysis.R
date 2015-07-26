#Load Package
library(plyr)

#Download Source Files and unzip the file to the SourceData Folder
SourceFileDir <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\Dataset.zip"

if(!file.exists(SourceFileDir)) {
        dir.create(SourceFileDir)}

download.file(fileUrl, destfile=zipfile)
unzip(zipfile=zipfile,exdir=SourceFileDir)

#Read data
SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\train\\X_train.txt"
FeaturesTrain <- read.table(SourceFile, header = F)
SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\test\\X_test.txt"
FeaturesTest <- read.table(SourceFile, header = F)

SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\train\\subject_train.txt"
SubjectTrain <- read.table(SourceFile, header = F)
SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\test\\subject_test.txt"
SubjectTest <- read.table(SourceFile, header = F)

SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\train\\y_train.txt"
ActivityTrain <- read.table(SourceFile, header = F)
SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\test\\y_test.txt"
ActivityTest <- read.table(SourceFile, header = F)

SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\features.txt"
FeaturesName <- read.table(SourceFile, header = F)

SourceFile <- "C:\\Users\\zhangle2\\Documents\\Coursera\\GettingAndCleaningData\\Project\\SourceData\\UCI HAR Dataset\\activity_labels.txt"
ActivityLabels <- read.table(SourceFile, header = F)

#Merge Train and Test Dataset
Features <- rbind(FeaturesTrain, FeaturesTest)
Subject <- rbind(SubjectTrain, SubjectTest)
Activity <- rbind(ActivityTrain, ActivityTest)

#Rename the column name of the Dataset
names(Features) <- FeaturesName$V2
names(Subject) <- c("Subject")
names(Activity) <- c("Activity")

#Combine the Subject, Activity and Features column together
Data <- cbind(Subject, Activity)
Data <- cbind(Features, Data)


#Extracts only the measurements on the mean and standard deviation for each measurement
FeaturesNameExtracted <- FeaturesName$V2[grep("mean\\(\\)|std\\(\\)", FeaturesName$V2)]
FeaturesNameExtracted <- c(as.character(FeaturesNameExtracted), "Subject", "Activity" )
Data <- subset(Data,select=FeaturesNameExtracted)

#Use descriptive activity names to name the activities in the data set
Data$Activity <- factor(Data$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])


#Appropriately labels the data set with descriptive variable names
names(Data) = gsub('-mean', 'Mean', names(Data))
names(Data) = gsub('-std', 'Std', names(Data))
names(Data) <- gsub('[()]', '', names(Data))


#Creates a second,independent tidy data set and ouput it
DataMean<-aggregate(. ~Subject + Activity, Data, mean)
DataMean<-DataMean[order(DataMean$Subject,DataMean$Activity),]
write.table(DataMean, file = "tidydata.txt",row.name=FALSE)


