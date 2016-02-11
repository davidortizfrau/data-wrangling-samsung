==================================================================
Datasets are stored in two different directories, /test and /train.

Variables that end with '*_combined' are the datasets test & train combined into one.

I used the rbind() method to do combine them.

Then, I named each varaible within the data frames with the names() method.

*Some of the variable names come from other datasets

==================================================================
KEY VARIABLES

gross_data - data frame that contains all varaibles including subject, activity label, activity name, and all features measured. The cbind() method was used mostly to unite the data frames. To add the activity labes and names I used a left_join() method using the the ActivityLabel variable as the joining variable.

slim_data - took the gross_data data frame and extracted some colums using the select() method in conjunction with the matches() helper method and a regular expresion.

tidy_data - Is a summary of the data set grouped by subject and activy with corresponding means for each variable.
