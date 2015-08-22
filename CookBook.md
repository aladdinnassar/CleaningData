# Getting & Cleaning Data Project Cook Book

# Variables
- Feature: the variable measured, e.g., BodyAcc, GravityAcc, BodyAccJerk, BodyGyro, BodyGyroJery, ...
- Domain: whether the Value is measured on the Time/Frequency domain.
- Stat: whether the Value reported is mean/std.
- Axis: the axis the measure is taken on = X/Y/Z.
- Group: whether this is the Train/Test Group of measurements.
- Activity: the kind of activity the person/subject is engaged in: Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing, Laying.
- SubjectID: a number from 1 to 30 anonymously representing the person/subject.
- Value: the normalized unitless values ranging from [-1,1].  The original values are normalized to the min/max per measure to avoid data skewness.

# Procedure
- Read the activity_lables.txt file
- Read the features.txt file
- Read the following for the Test and Training Groups separately:
	- Read the group/subject_group.txt file
	- Read the Labels in group/y_group.txt
	- Read the Values in group/x_group.txt
	- Transpose columns to rows
	- Add a Column specifying the Group = Test/Train
- Append the Test + Training datasets
- Remove the V from the FeatureID column
- Join table with the Feature List on FeatureID
- Join table with the Activity List on ActivityID
- Select the columns we need
- Filter only Features that contain mean() and std()
- Split the Feature Column into Feature, Domain, Stat, Axis
- See inline comments in the R code