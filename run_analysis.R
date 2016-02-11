# Import Libraries
library(dplyr)
library(tidyr)

# 1. Merge the training and test sets to create one data set.

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
subject_combined <- rbind(subject_test, subject_train)
names(subject_combined) <- c('subject')

features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
x_combined <- rbind(x_test, x_train)
names(x_combined) <- make.names(features$V2, unique = TRUE)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
y_combined <- rbind(y_test, y_train)
names(y_combined) <- c('ActivityLabel')

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
names(activity_labels) <- c('ActivityLabel', 'ActivityName')


# 2. Extracts columns containing mean and standard deviation for each measurement

x_slim <- select(x_combined, matches("(mean|std)"))

# 3. Creates variables called ActivityLabel and ActivityName that label all
#    observations with the corresponding activity labels and names respectively

final_data <- cbind(subject_combined, y_combined) %>%
  left_join(activity_labels) %>%
  cbind(x_slim)

# 4. From the data set in step 3, creates a second, independent tidy data set with
#    the average of each variable for each activity and each subject.

tidy_data <- final_data %>%
  group_by(subject, ActivityName) %>%
  summarise_each(funs(mean), -one_of(c('subjet', 'ActivityLabel', 'ActivityName')))