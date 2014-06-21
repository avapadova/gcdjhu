CodeBook.md
======

### Getting and Cleaning Data Course Project

- The source [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

- The R script  [run_analysis.R](https://github.com/avapadova/gcdjhu/blob/master/run_analysis.R) is reading the source data and is doing the following to process the tidy data:

1. Merges the training sets and the test sets in order to create one data set. 

        1.a Merges: X_train.txt and X_test.txt.

                The result is: X_merged,  a (10299 x 561) data frame.

        1.b Merges: y_train.txt and y_test.txt.

                The result is y_merged, a (10299 x 1) data frame.

        1.c Merges: subject_train.txt and subject_test.txt.
                
                The result is subject_merged, a (10299 x 1) data frame.

2. Reads the file features.txt and extracts only the measurements on the mean and standard deviation for each measurement.

        The result is:  X, a (10299 x 66) data frame, where we found measurements regarding  the mean and standard deviation.

3. Reads the file activity_labels.txt and assigns descriptive activity names to the activities in the y_merged data set:

                walking
                
                walkingupstairs
                
                walkingdownstairs
                
                sitting
                
                standing
                
                laying

4. The third and fourth section of the run_analysis script appropriately labels the data set with descriptive names. Activity names are converted to lower case and special characters like underscores and brackets are removed. A new data frame, processed, is created by merging subjects, activities and features.

        The processed (10299 x 68) data frame is saved in the file "./UCI HAR Dataset/merged/processed.txt". Its first column contains the subject, the second column contains the activity names and the other 66 columns are the measurements.


5. The fifth section of the run_analysis script creates the tidy data set with the average of each measurement for each subject and and each activity.

        The processed (180 x 68) data frame is saved in the file "./UCI HAR Dataset/merged/tidy.txt". Its first column contains the subject, the second column contains the activity name, and and the other 66 columns are the averages for each of the 66 variables(from column 3 to column 68). 