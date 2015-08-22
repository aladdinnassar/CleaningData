run_analysis <- function(){
    # Assumes dplyr and tidyr packages are installed, otherwise uncomment the following
	# library(dplyr)
    # library(tidyr)
	
	# Assumes working directory = UCI HAR Dataset, otherwise uncomment the following
	# setwd("coursera/Cleaning Data/UCI HAR Dataset")
	
	# Turn off verbose warnings
    options(warn=-1)
    
	# Read the list of Activities = ActivityID, Activity
    activities <- read.table("activity_labels.txt", col.names = c("ActivityID", "Activity"))
	
	# Read the list of Features = FeatureID, Feature
    features <- read.table("features.txt", col.names = c("FeatureID", "Feature"))
    
	# Read Training Dataset:
	# ----------------------
	# Read Training SubjectID
    subject_train <- read.table("train/subject_train.txt", col.names = c("SubjectID"))
	
	# Read Training Labels
    y_train <- read.table("train/y_train.txt", col.names = c("ActivityID"))
	
	# Read Training set
    x_train <- read.table("train/x_train.txt")
    
	# Bind Training Dataset Columns
    train <- cbind(subject_train, y_train, x_train)
    
	# Transpose columns into rows
    train <- gather(train, FeatureID, Value, -SubjectID, -ActivityID)
	
	# Set the Group = Train
    train <- mutate(train, Group = "Train")
   
   	# Read Test Dataset:
	# ------------------
	# Read Test SubjectID
    subject_test <- read.table("test/subject_test.txt", col.names = c("SubjectID"))
	
	# Read Test Labels
    y_test <- read.table("test/y_test.txt", col.names = c("ActivityID"))
	
	# Read Test set
    x_test <- read.table("test/x_test.txt")
    
	# Bind Training Dataset Columns
    test <- cbind(subject_test, y_test, x_test)
    
	# Transpose columns into rows
    test <- gather(test, FeatureID, Value, -SubjectID, -ActivityID)
	
	# Set the Group = Test
    test <- mutate(test, Group = "Test")
    
	# Append Training + Test Datasets
    data <- rbind(train, test)
    
	# Remove the V from the VN Feature ID and convert to an integer
    data <- mutate(data, FeatureID = as.numeric(substring(FeatureID,2,10)))
	
	# Join on FeatureID to get Feature
    data <- inner_join(data, features)
	
	# Join on ActivityID to get Activity
    data <- inner_join(data, activities)
	
	# Select the columns we need
    data <- select(data, Feature, Group, Activity, SubjectID, Value)
    
	# Filter Features that contain mean() and std()
    data1 <- filter(data, grepl("mean()", Feature, ignore.case = TRUE, fixed = TRUE))
    data2 <- filter(data, grepl("std()", Feature, ignore.case = TRUE, fixed = TRUE))
    
	# Append the mean() and std() datasets
    data <- rbind(data1, data2)
    
	# Split tBodyAcc-mean()-X  -> FreqMeasure = tBodyAcc, Stat = mean, Axis = X
    data <- separate(data, Feature, c("FreqMeasure","Stat","Axis"), extra = "merge")
	
	# Read the Domain = Time/Frequency from FreqMeasure
    data <- mutate(data, Domain = ifelse(substring(FreqMeasure,1,1) == "t", "Time", "Frequency"))
	
	# Read Feature from FreqMeasure
    data <- mutate(data, Feature = substring(FreqMeasure,2,50))
	
	# Select the columns we need
    data <- select(data, Feature, Domain, Stat, Axis, Group, Activity, SubjectID, Value)
    
    # List means per Feature/Variable, Activity, Subject
    averages <- filter(data, Stat == "mean")
    
    # Write to file
    write.table(averages, file = "Getting and Cleaning Data Project.txt", row.name = FALSE)
    
    # Return results
    averages
}