#reading train data set
xtrainData <- read.table("./specdata/UCI HAR Dataset/train/X_train.txt")

#reading train data set labels
ytrainLabel <- read.table("./specdata/UCI HAR Dataset/train/y_train.txt")

#reading test data set
xtestData <- read.table("./specdata/UCI HAR Dataset/test/X_test.txt")

#reading test data set labels
ytestLabel <- read.table("./specdata/UCI HAR Dataset/test/y_test.txt")

#reading train data subjects
trainsubject <- read.table("./specdata/UCI HAR Dataset/train/subject_train.txt")

#reading test data subjects
testsubject <- read.table("./specdata/UCI HAR Dataset/test/subject_test.txt")

#reading activity labels
activityLabels <- read.table("./specdata/UCI HAR Dataset/activity_labels.txt")

#reading features
features <- read.table("./specdata/UCI HAR Dataset/features.txt")

#reading features info 
featuresInfo <- read.table("./specdata/UCI HAR Dataset/features_info.txt")

#merging two data sets
mergedData <- rbind(xtrainData,xtestData)

#merging subject data
mergedSubject <- rbind(trainsubject,testsubject)

#merging labels data
mergedLabels <- rbind(ytrainLabel,ytestLabel)

#Extracts only the measurements on the mean and standard deviation for each measurement
posMeanStd <- grep("-mean\\(\\)|-std\\(\\)", features[,"V2"])
mergedData <- mergedData[,posMeanStd]
variableNames <- features[posMeanStd,"V2"]
names(mergedData) <- tolower(variableNames)

#Uses descriptive activity names to name the activities in the data set
activityNames <-  gsub("_", "", tolower(as.character(activityLabels[, "V2"])))
activityLabels[,"V2"]<- activityNames
mergedLabels[,1] <- activityLabels[mergedLabels[,1],"V2"]

#Appropriately labels the data set with descriptive variable names. 
names(mergedLabels) <- "Activity"
names(mergedSubject) <- "Subject"

#independent tidy data set with the average of each variable for each activity and each subject.
consolidatedData <- cbind(mergedData,mergedLabels,mergedSubject)

distinctSubjects = unique(mergedSubject)[,"Subject"]
noSubjects = length(unique(mergedSubject)[,"Subject"])
noActivities = length(mergedLabels[,"Activity"])
noCols = dim(consolidatedData)[2]
averageData = consolidatedData[1:(noSubjects*noActivities), ]
row = 1
for (sub in 1:noSubjects) {
       for (activity in 1:noActivities) {
              averageData[row, 1] = distinctSubjects[sub]
              averageData[row, 2] = mergedLabels[activity,"Activity"]
              data <- consolidatedData[consolidatedData$subject==sub & consolidatedData$activity==mergedLabels[activity, "Activity"], ]
              averageData[row, 3:noCols] <- colMeans(data[, 3:noCols])
              row = row+1
       }
}
write.table(averageData, "./specdata/UCI HAR Dataset/averageData.txt")
