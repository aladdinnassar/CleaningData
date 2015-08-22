run_analysis <- function(){
    
    options(warn=-1)
    
    # library(dplyr)
    # library(tidyr)
    # setwd("work/coursera/Cleaning Data/UCI HAR Dataset")
    
    activities <- read.table("activity_labels.txt", col.names = c("ActivityID", "Activity"))
    features <- read.table("features.txt", col.names = c("FeatureID", "Feature"))
    
    subject_train <- read.table("train/subject_train.txt", col.names = c("SubjectID"))
    y_train <- read.table("train/y_train.txt", col.names = c("ActivityID"))
    x_train <- read.table("train/x_train.txt")
    
    train <- cbind(subject_train, y_train, x_train)
    
    train <- gather(train, FeatureID, Value, -SubjectID, -ActivityID)
    train <- mutate(train, Group = "Train")
   
    subject_test <- read.table("test/subject_test.txt", col.names = c("SubjectID"))
    y_test <- read.table("test/y_test.txt", col.names = c("ActivityID"))
    x_test <- read.table("test/x_test.txt")
    
    test <- cbind(subject_test, y_test, x_test)
    
    test <- gather(test, FeatureID, Value, -SubjectID, -ActivityID)
    test <- mutate(test, Group = "Test")
    
    data <- rbind(train, test)
    
    data <- mutate(data, FeatureID = as.numeric(substring(FeatureID,2,10)))
    data <- inner_join(data, features)
    data <- inner_join(data, activities)
    data <- select(data, Feature, Group, Activity, SubjectID, Value)
    
    data1 <- filter(data, grepl("mean()", Feature, ignore.case = TRUE, fixed = TRUE))
    data2 <- filter(data, grepl("std()", Feature, ignore.case = TRUE, fixed = TRUE))
    
    data <- rbind(data1, data2)
    
    # x <- unique(select(all, Feature))
    data <- separate(data, Feature, c("FreqMeasure","Stat","Axis"), extra = "merge")
    data <- mutate(data, Domain = ifelse(substring(FreqMeasure,1,1) == "t", "Time", "Frequency"))
    data <- mutate(data, Feature = substring(FreqMeasure,2,50))
    data <- select(data, Feature, Domain, Stat, Axis, Group, Activity, SubjectID, Value)
    
    write.table(data, file = "Getting and Cleaning Data Project.txt", row.name = FALSE)
    
    avg <- filter(data, Stat == "mean")
}