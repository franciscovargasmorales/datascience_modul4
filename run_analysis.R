#Load packages if they are not installed already
install.packages(c('dplyr','data.table','plyr','tidyverse')) 

# 1) Specify your own directory after you extract and unzip the documents from the following website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
directory <- "Set own directory/UCI HAR Dataset"
setwd(directory)

# 2) Import labels and features 
activities <- read.table("./activity_labels.txt")
features <-read.table("./features.txt")

# 3.1)Keep only variables for measuring means and stardar deviations
features_mean_std <- grep("mean[(][)]|std[(][)]", features[,2]) 
final_features <- features[features_mean_std, 2] %>% gsub("mean[(][)]", "Mean", .) %>% gsub("std[(][)]", "Std", .) %>% as.data.frame(.)

#3.2) Train and  test datasets
train_x <- read.table("./train/x_train.txt") %>% .[, C(as.factor(features_mean_std))] 

test_x <- read.table("./test/x_test.txt") %>% .[, C(as.factor(features_mean_std))] 

#4.1) Activity and subject for train and test datasets
train_subject <- read.table("./train/subject_train.txt") 
train_y <- read.table("./train/y_train.txt")  

test_subject <- read.table("./test/subject_test.txt")  
test_y <- read.table("./test/y_test.txt")  

#4.2) Merge all data for train and for test
train <- cbind(train_subject, train_y, train_x)

test <- cbind(test_subject, test_y, test_x)

#5) Merge all data together
all_data <- rbind(train, test)
colnames(all_data) <- c("subject", "activity", final_features[1:nrow(final_features),])
View(all_data) 

#6) Activity labels and subjects into factors
all_data$activity <- factor(all_data$activity, levels = activities[,1], labels=activities[,2])
all_data$subject <- as.factor(all_data$subject)

#7) Tidy data 
final_data <- all_data %>% group_by(subject, activity) %>%  summarise_each(mean)
write.table(final_data, "tidy.txt", row.names = F, col.names = T)