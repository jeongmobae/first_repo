---
title: "readme"
output: html_document
---
Readme file for Course Project in Getting and cleaning data
==============================================================

This "readme" file explains how "run_analysis.R" script works. 
--------------------------------------------------------------

Read data from "X_train", "subject_train" and "y_train"" and merge them into "train_data""
```{r}
X_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
train_data <- cbind(subject_train, y_train, X_train)
```


Read data from "X_test", "subject_test"" and "y_test" and merge them into "test_data"
```{r}
X_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")
test_data <- cbind(subject_test, y_test, X_test)
```


Extract variable names from "features.txt". We have to discard first column of "featurex.txt" to remove column numbers. 
```{r}
col_name <- read.table("features.txt")
col_name <- as.vector(col_name[, -1])
```


Merge "train_data"" and "test_data"" to myData, and assign column names to myData.
```{r}
myData <- rbind(train_data, test_data)
colnames(myData) <- c("subject", "activity", col_name)
```


Extract columns which have "mean" and "std" in their column names. 
```{r}
myData_mean_std <- myData[, grepl("mean|std", ignore.case=TRUE, colnames(myData))]
```


Attach "subject" and "activity" columns to extracted data.
```{r}
myData_mean_std <- cbind(myData[, 1:2], myData_mean_std)
```


Factorize "activity" column with appropriate labels. 
```{r}
myData_mean_std$activity <- factor(myData_mean_std$activity, levels = c(1:6), \n
                        labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                "SITTING", "STANDING", "LAYING"))
```


Summarize the data using average of each variables according to "subject" and "activity" columns.
```{r}
data_average <- myData_mean_std %>% group_by(subject, activity) %>% summarise_each("mean")
```


Save the summarized data into text file. 
```{r}
write.table(data_average, "data_average.txt", sep="\t", row.name=FALSE)
```





