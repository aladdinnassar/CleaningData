# Getting & Cleaning Data Project Cook Book

# Variables
- Feature: the variable measured, e.g., BodyAcc, GravityAcc, BodyAccJerk, BodyGyro, BodyGyroJery, ...
- Domain: whether the Value is measured on the Time/Frequency domain
- Stat: whether the Value reported is mean/std
- Axis: the axis the measure is taken on = X/Y/Z
- Group: whether this is the Train/Test Group of measurements
- Activity: the kind of activity the person/subject is engaged in: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- SubjectID: a number from 1 to 30 anonymously representing the person/subject
- Value: the normalized values measured ranging from [-1,1]