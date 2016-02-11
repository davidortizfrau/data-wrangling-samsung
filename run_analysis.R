# Import Libraries
library(dplyr)
library(tidyr)


# Merge the training and test sets to create one data set.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c('ActivityLabel', 'ActivityName')

features <- read.table("UCI HAR Dataset/features.txt")

subject_combined <- rbind(subject_test, subject_train)
names(subject_combined) <- c('subject')

x_combined <- rbind(x_test, x_train)
names(x_combined) <- make.names(features$V2, unique = TRUE)

y_combined <- rbind(y_test, y_train)
names(y_combined) <- c('ActivityLabel')

gross_data <- cbind(subject_combined, y_combined) %>%
  left_join(activity_labels) %>%
  cbind(x_combined)


# Extract columns containing mean and standard deviation for each measurement
slim_data <- gross_data %>% select( -matches("(mean|std)"))


# Summary
tidy_data <- slim_data %>%
  group_by(subject, ActivityName) %>%
  summarise_each(funs(mean), -one_of(c('subjet', 'ActivityLabel', 'ActivityName')))
