library(dplyr)

X_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
train_data <- cbind(subject_train, y_train, X_train)

X_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")
test_data <- cbind(subject_test, y_test, X_test)

col_name <- read.table("features.txt")
col_name <- as.vector(col_name[, -1]) # Remove numbers

myData <- rbind(train_data, test_data)
colnames(myData) <- c("subject", "activity", col_name)

myData_mean_std <- myData[, grepl("mean|std", ignore.case=TRUE, colnames(myData))]
myData_mean_std <- cbind(myData[, 1:2], myData_mean_std) # Recall subject and activity columns
myData_mean_std$activity <- factor(myData_mean_std$activity, levels = c(1:6),
                                   labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                              "SITTING", "STANDING", "LAYING"))
data_average <- myData_mean_std %>% group_by(subject, activity) %>% summarise_each("mean")

write.table(data_average, "data_average.txt", sep="\t", row.name=FALSE)