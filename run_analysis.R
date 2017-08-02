library(reshape2)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

## Download and unzip the dataset:
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- file.path(getwd(), "getdata_projectfiles_UCI HAR Dataset.zip")
download.file(url, filename)
unzip(filename)


# Load activity labels
actlabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actlabels[,2] <- as.character(actlabels[,2])

# Load Features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# pull only the data that contains "mean" or "std"
mean_std <- grep(".*mean.*|.*std.*", features[,2])
mean_std_names <- features[mean_std,2]
mean_std_names = gsub('-mean', 'Mean', mean_std_names)
mean_std_names = gsub('-std', 'Std', mean_std_names)
mean_std_names <- gsub('[-()]', '', mean_std_names)


# Load the training datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[mean_std]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Combine train with train activities and train subjects
train <- cbind(train_subjects, train_activities, train)

# Load the testing datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[mean_std]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Combine test with test subjects and test activities
test <- cbind(test_subjects, test_activities, test)

# merge the train and test datasets 
all_data <- rbind(train, test)

# Add labels to the new dataset
colnames(all_data) <- c("subject", "activity", mean_std_names)

# turn activities & subjects into factors
all_data$activity <- factor(all_data$activity, levels = actlabels[,1], labels = actlabels[,2])
all_data$subject <- as.factor(all_data$subject)

all_data.melted <- melt(all_data, id = c("subject", "activity"))
all_data.mean <- dcast(all_data.melted, subject + activity ~ variable, mean)

write.table(all_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)