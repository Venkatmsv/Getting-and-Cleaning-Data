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

#merge all the clean data sets
consolidatedData <- cbind(mergedData,mergedLabels,mergedSubject)

##independent tidy data set with the average of each variable for each activity and each subject.
tidyFinalData <- aggregate(consolidatedData,list(activity=consolidatedData$Activity,subject=consolidatedData$Subject),mean)

#writing final tidy data into a file
write.table(tidyFinalData, "./specdata/UCI HAR Dataset/TidyFinalData.txt")

#write.table(tidyFinalData, "./specdata/TidyFinalData.txt",row.names=FALSE)
