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
3.  Call run_analysis, using the directory containing the data as the dir arguement
4. Results will be in the directory passed as the arguement
 
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