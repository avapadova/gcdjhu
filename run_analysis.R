# URL of the source data:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Unzip: getdata-projectfiles-UCI HAR Dataset.zip into your working directory
# The unziped directory containig the project data is: UCI HAR Dataset
# Create a new directory that will store the tidy data: UCI HAR Dataset\merged
#
# 1. Merges the training and the test sets to create one data set
#
# 1.a Merged: X_train.txt and X_test.txt.
#
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
str(X_train)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
str(X_test)
#
X_merged <- rbind(X_train, X_test)
str(X_merged)
#write.table(X_merged, "./UCI HAR Dataset/merged/X_merged.txt")
#list.files("./UCI HAR Dataset/merged/")
#
# 1.b Merged: y_train.txt and y_test.txt.
#
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
str(y_train)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
str(y_test)
#
y_merged <- rbind(y_train, y_test)
str(y_merged)
#write.table(y_merged, "./UCI HAR Dataset/merged/y_merged.txt")
#list.files("./UCI HAR Dataset/merged/")
#
# 1.c Merged: subject_train.txt and subject_test.txt.
#
subject_train<- read.table("./UCI HAR Dataset/train/subject_train.txt")
str(subject_train)
subject_test  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
str(subject_test)
#
subject_merged<- rbind(subject_train, subject_test)
str(subject_merged)
#write.table(subject_merged, "./UCI HAR Dataset/merged/subject_merged.txt")
#list.files("./UCI HAR Dataset/merged/")
#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
features <- read.table("./UCI HAR Dataset/features.txt")
index_of_interest <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
#
X <- X_merged[, index_of_interest]
names(X) <- features[index_of_interest, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))
#
# 3. Uses descriptive activity names to name the activities in the data set.
#
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities[, 2] <- gsub("_", "", tolower(as.character(activities[, 2])))
#
y_merged[,1] <-  activities[y_merged[,1], 2]
names(y_merged) <- "activity"
str(y_merged)
#
# 4. Appropriately labels the data set with descriptive activity names.
#
names(subject_merged) <- "subject"
processed <- cbind(subject_merged, y_merged, X)
write.table(processed, "./UCI HAR Dataset/merged/processed.txt")
#
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
#
unique_subjects <- unique(subject_merged)[,1]
unique_subjects <- sort(unique_subjects)
num_subjects <- length(unique(subject_merged)[,1])
num_activities <- length(activities[,1])
num_columns <- dim(processed)[2]
tidy <- processed[1:(num_subjects*num_activities), ]

row <- 1
for (subject in 1:num_subjects) {
        for (activity in 1:num_activities) {
                tidy[row, 1] = unique_subjects[subject]
                tidy[row, 2] = activities[activity, 2]
                tmp <- processed[(processed$subject==subject & processed$activity==activities[activity, 2]), ]
                tidy[row, 3:num_columns] <- colMeans(tmp[, 3:num_columns])
                row <- row+1
        }
}
write.table(tidy, "./UCI HAR Dataset/merged/tidy.txt")
