# Load de plyr library
library(plyr)
library(reshape2)
#Unzip the Samsung Data as long as the zip file is in the working directory
unzip("getdata_projectfiles_UCI HAR Dataset.zip")


####################### COMMON DATA ################################

#Load the features data
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
gsub(" ", "_", features[,2], fixed = TRUE)

#Load the activiy labels data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE)
names(activity_labels) <- c("Activity_id","Activity_name")





#################### TESTS DATA ####################

#load the subjects data to a dataset
subject_tests <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)



#Load the results of tests
X_tests <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
names(X_tests)  <- t(features[,2])

Y_tests <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

tests <- cbind(subject_tests,Y_tests,X_tests)
names(tests) <- c("Subject_id","Activity_id",names(X_tests))

data_tests <- arrange(join(tests,activity_labels),Activity_id)



#################### TRAIN DATA ####################


subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)

X_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
names(X_train)  <- t(features[,2])

Y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

train <- cbind(subject_train,Y_train,X_train)
names(train) <- c("Subject_id","Activity_id",names(X_train))

data_train <- arrange(join(train,activity_labels),Activity_id)



######## MERGE TRAIN AND TETS DATA ############
data_total <- rbind(data_train,data_tests)


########### SELECTING AVG AND STD DATA ##########

selected_data<- data_total[, names(data_total) == "Subject_id" | names(data_total) == "Activity_id"
                                 | names(data_total) == "Activity_name"
                                 |  grepl("mean(",names(data_total),fixed = TRUE)  
                                 |  grepl("std(",names(data_total),fixed = TRUE)]



############# GENERATE TIDY DATASET ################################


melted_data <- melt(selected_data,id=c("Subject_id","Activity_id","Activity_name"),measure.vars = names(selected_data)[3:68])

tidy_data <- dcast(melted_data, Subject_id+Activity_id+Activity_name ~ variable,mean)


############ EXPORT TIDY DATASET ##############

write.table(tidy_data,file="Course_Project_Tidy_Data.txt",row.names = FALSE)
