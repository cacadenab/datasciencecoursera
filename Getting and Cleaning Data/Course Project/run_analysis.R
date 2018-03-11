library(plyr)

##Download and unzip data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","run_analysis.zip") 

unzip("run_analysis.zip")

## STEP 1: Merges the training and the test sets to create one data set
#Read data files into data frames

subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table(file = "UCI HAR Dataset/test/Y_test.txt")

subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")

#Bind subject, features and activity data into a data set for train and another for test

test_data <- cbind(subject_test,Y_test,X_test)
train_data <- cbind(subject_train,Y_train,X_train)

#Bind train and test data into a single data set

all_data <- rbind(train_data,test_data)






##STEP 4: Appropriately labels the data set with descriptive
#Read Labels and activity names Data

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])


#Assing names to data set

colnames(all_data) <- c("subject","activity",features[,2])



##STEP 3: Uses descriptive activity names to name the activities
#Make activiy a Factor and assigning labels with activity data
all_data$activity <- factor(all_data$activity, levels = activityLabels[,1], labels = activityLabels[,2])



## STEP 2: Extracts only the measurements on the mean and standard
#Select features wanted

featuresWanted <- grep(".*-mean.).*|.*-std.).*", features[,2])
colsWanted.names <- c("subject","activity",features[featuresWanted,2])

#subset data according to features required

 sub<- all_data[,colsWanted.names]

 
 ## STEP 5: Creates a second, independent tidy data set with the
 
 #Reshape data
tidy_data <-  ddply(sub, c("subject","activity"), numcolwise(mean))

#writing final file
write.table(tidy_data,file="tidy_data.txt")
