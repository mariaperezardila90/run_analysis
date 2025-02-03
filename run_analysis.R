file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" #loadfile
download.file(file_url, destfile = "UCI_HAR_Dataset.zip", method = "curl")
unzip("UCI_HAR_Dataset.zip", exdir = "UCI_HAR_Dataset")  
list.files("UCI_HAR_Dataset") # Step 4: Verify that the files have been extracted
features <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
head(features) 


features <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE) # Load features and activity labels
activity_labels <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
colnames(activity_labels) <- c("ActivityID", "ActivityLabel")


X_train <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt") # Load training data
y_train <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt")


X_test <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt") # Load test data
y_test <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt")


colnames(X_train) <- features$V2 # Assign feature names to columns in X_train and X_test
colnames(X_test) <- features$V2


colnames(subject_train) <- "Subject" # Name the columns for subjects and activities
colnames(subject_test) <- "Subject"
colnames(y_train) <- "Activity"
colnames(y_test) <- "Activity"


train_data <- cbind(subject_train, y_train, X_train) # Combine training data
test_data <- cbind(subject_test, y_test, X_test) # Combine test data


train_data_combined <- rbind(train_data, test_data) # Merge training and test data into one dataset


mean_std_features <- grep("-(mean|std)\\(\\)", features$V2, value = TRUE) # Identify features with mean() or std()
train_data_mean_std <- train_data_combined[, c("Subject", "Activity", mean_std_features)] # Subset the data with only Subject, Activity, and the selected features
train_data_mean_std <- merge(train_data_mean_std, activity_labels, by.x = "Activity", by.y = "ActivityID") # Merge to get descriptive activity names instead of numeric codes
train_data_mean_std <- train_data_mean_std[, c("Subject", "ActivityLabel", mean_std_features)] # Reorder columns to place Subject and ActivityLabel at the front

head(train_data_mean_std) # View the final dataset

#Rename the variables descriptively
current_names <- colnames(train_data_mean_std)
descriptive_names <- current_names
descriptive_names <- gsub("^t", "TimeDomain_", descriptive_names) # Replace prefixes 't' and 'f' with descriptive labels
descriptive_names <- gsub("^f", "FrequencyDomain_", descriptive_names)

descriptive_names <- gsub("Acc", "Accelerometer", descriptive_names) #No abbreviations
descriptive_names <- gsub("Gyro", "Gyroscope", descriptive_names)
descriptive_names <- gsub("Mag", "Magnitude", descriptive_names)
descriptive_names <- gsub("BodyBody", "Body", descriptive_names)

descriptive_names <- gsub("-mean\\(\\)", "_Mean", descriptive_names) # Replace mean() and std() with descriptive names
descriptive_names <- gsub("-std\\(\\)", "_StandardDeviation", descriptive_names)

descriptive_names <- gsub("\\()", "", descriptive_names) # Remove any remaining parentheses and dashes for clarity
descriptive_names <- gsub("-", "_", descriptive_names)

colnames(train_data_mean_std) <- descriptive_names
head(train_data_mean_std)


library(dplyr)


tidy_data <- train_data_mean_std %>% #Create a tidy dataset with the average of each variable for each subject and activity
  group_by(Subject, ActivityLabel) %>%
  summarise(across(everything(), mean), .groups = "drop")
head(tidy_data)


write.table(tidy_data, "tidy_data.txt", row.names = FALSE) #Save the tidy dataset to a file (optional)

# Read the tidy dataset back into R
tidy_data_loaded <- read.table("tidy_data.txt", header = TRUE)
head(tidy_data_loaded)
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
list.files() 

 