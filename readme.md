# Getting and Reading Data Course Project
Submitted on June 4, 2016 using data downloaded on June 2,2016

## How to run run_analysis script

### Dependencies
The following packages must be installed prior to running:
 * plyr
 * dplyr
 * reshape2

### Instructions

To run the script:

1. Load the script into R studio
2. Source the script
3.  Call run_analysis, using the directory containing the data as the dir argument
4. Results will be in the directory passed as the argument
 
### Process followed
This is a duplicate of some information that is contained in other files  
I didn't realize I needed it here until I started reviewing other projects.

Here are the steps used to create the first dataset: 

	1.The subjects (from subject_test.txt and subject_train.txt) and activities (from y_test.txt and 
	  ytrain.txt) were joined to their respective reading tables (x_test and x_train).

	2. The features.txt was used to name the columns of the data from x_test and x_train.

	3. The columns that contained "mean()" and "std()" in the variable name were selected

	4. The data was "melted" into data frames containing the activity, the subject, the variable, and the value.

	5. The source of the data was added to the melted tables (train or test)

	6. The two datasets were merged together to make one consolidated dataset

	7. The variable was split into 4 variables, dimension, calculation, domain, and reading type

	8. An ActivityDescription column was created by merging the activity_description.txt based on the activity column

	9. Unneccessary columns were removed from the dataset (activity, variable)

	10. Data values were cleaned up by:
		a. removing the parenthesis '()' from the calculationtype
		b. changing the signaltype from "t" to "time" and "f" to "frequency"

 Here are the steps to create the second dataset:
	1. select only the relevent columns from dataset1 (subject,calculation,readingtype,activitydescription,value)
	2. apply the "ddply" functin in R to create a mean value for each combination of subject,calculation,readingtype,
	   and activitydescription  
 
 ## Manifest

## Tidy Data

* Readme.md - this file
* TidyDataOverview.txt - an overview of the data tidying project, and a description of the run_analysis script
* dataset1_description - a description of the process used to generate and the data provided in the first dataset
* dataset2_description - a description of the process used to generate and the data provided in the second dataset
* dataset1.csv - the first tidied dataset
* dataset2.csv - the second tidied dataset
* tidyDataProject.R - the R script used to generate the two datasets

## Original Data

### In subdirectory UCI HAR Dataset:

* README.txt - data and experiment description
* features_info.txt - a description of the data collected
* features.txt - a list of the variable names
* activity_labels.txt - a list of activity codes and descriptions
* test directory - containing the data on the test group
* train directory - containing the data on the train group

#### In subdirectory test

* X_test.txt - the data from the experiments
* Y_test.txt - the data describing what activity occured in the experiments
* subject_test.txt - the data describing which subject performed the activity
* Inertial Signals directory - not used in this project

#### In subdirectory train

* X_train.txt - the data from the experiments
* Y_train.txt - the data describing what activity occured in the experiments
* subject_train.txt - the data describing which subject performed the activity
* Inertial Signals directory - not used in this project