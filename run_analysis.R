## Getting & Cleaning Data Project

## One of the most exciting areas in all of data science right now is wearable 
## computing - see for example this article . Companies like Fitbit, Nike, and 
## Jawbone Up are racing to develop the most advanced algorithms to attract new
## users. The data linked to from the course website represent data collected 
## from the accelerometers from the Samsung Galaxy S smartphone. A full 
## description is available at the site where the data was obtained:
        
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:
        
##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with
##    the average of each variable for each activity and each subject.

## dir is an arguement with the working directory to be used
run_analysis <- function (dir) {
        
        ## Dependencies
        library (plyr)
        library (dplyr)
        library (reshape2)
        ## Variables
        oldwd<-getwd()
 
        ## Load Data
        
        setwd(dir)
        print("Reading Features table (1/22")
        features<-read.table("features.txt")
        print("Reading Activites table (2/22)")
        activities<-read.table("activity_labels.txt")
        setwd("test")
        print("Reading X_test (3/22)")
        testx<-read.table("X_test.txt")
        print("Reading Y_test (4/22)")
        testy<-read.table("y_test.txt")
        print("reading Test subjects (5/22)")
        testsubject <- read.table("subject_test.txt")
        setwd("..")
        setwd("train")
        print("Reading X_Train (6/22)")
        trainx<-read.table("X_train.txt")
        print("Reading Y_Train (7/22)")
        trainy<-read.table("y_train.txt")
        print("Reading Train subjects.txt (8/22)")
        trainsubject<-read.table("subject_train.txt.")

        setwd(oldwd)
        
        ## first, join the activities and subjects
        print("Joining activities & subjects (9/22)")
        testx$activity <- testy
        trainx$activity <- trainy
        testx$subject <- testsubject
        trainx$subject <- trainsubject
                
        ## then, assign column names to x_test and x_train
        print("Assigning column names (10/22)")
        names(testx) <- features[,2]
        names(trainx) <- features[,2]
        names(activities) <- c("activity","activitydescription")
        names(testsubject) <- "subject"
        names(trainsubject) <- "subject"
        
        
        ## next, find the names of the columns with standard deviation and mean
        print("Selecting columns (11/22)")
        testxindx <- grep("[Mm]ean\\(\\)|std\\(\\)",names(testx))
        trainxindx <- grep("[Mm]ean\\(\\)|std\\(\\)",names(trainx))       
        
        ## then select only those columns
        
        testxtemp <- testx[testxindx]
        trainxtemp <- trainx[trainxindx]
       
        testxtemp <- cbind(testxtemp,testy)
        trainxtemp <- cbind(trainxtemp,trainy)
        testxtemp <- cbind(testxtemp,testsubject)
        trainxtemp <- cbind(trainxtemp,trainsubject)
        
        
        ## add activity column name
        print("adding column names (12/22)")
        names(testxtemp)[length(testxtemp)-1]="activity"
        names(trainxtemp)[length(trainxtemp)-1]="activity"
        

        ## Split these names up so that we can break out by body and by dimension
        print("Splitting names (13/22)")
        testxsplit <- strsplit(names(testxtemp),"-")
        trainxsplit <- strsplit(names(testxtemp),"-")
        
        ## Melt the data
        print("Melting... (14/22)")
        meltedtestx<-melt(testxtemp,id = c("activity","subject"))
        meltedtrainx<-melt(trainxtemp,id = c("activity","subject"))
        
        ## Add the source 
        print("adding source (15/22)")
        meltedtestx$source <- rep("test",nrow(meltedtestx))
        meltedtrainx$source <- rep("train",nrow(meltedtrainx))
        
  
        
        ## Merge the two datasets
        print("Merging (16/22)")
        data <- rbind(meltedtestx,meltedtrainx)
        
        ## split the data that is in the variable column up
        print("splitting (17/22)")
        splitter <- sapply(as.character(data$variable), function(x) strsplit(x,"-"))
       
        ## add new columns
        print("adding new columns (18/22)")
        
        dimfactor <- sapply(splitter,function(x) x[3])
        data$dimension <- dimfactor
        calculationfactor <- sapply(splitter,function(x) x[2])
        data$calculation <- calculationfactor
        bodyfactor <- sapply(splitter,function(x) substring(x[1],1,1))
        data$domain <- bodyfactor
        newvarfactor1<-sapply(splitter,function(x) substring(x[1],2,nchar(x)))
        newvarfactor2<-sapply(newvarfactor1,function(x) x[1])
        data$readingtype<-newvarfactor2
        
        ## merge activity descriptions
        
        print("merging activity descriptions (19/22)")
        data<-merge(data,activities,by="activity")
       
        ## remove unnecessary columns & reorder
        print("cleaning up the table (20/22)")
        data<-subset(data,select = -variable)
        data<-subset(data,select = -activity)
        data$calculation<-sapply(data$calculation,function(x) substring(x,1,nchar(x)-2))
        data$readingtype <-sapply(data$readingtype, function (x) if (substring(x,1,3) == "ity") paste0("Grav",x) else x)
        data$domain <-sapply(data$domain, function (x) if (x=="t") "time" 
                                 else if (x=="f") "frequency")
        
        ##  AT THIS POINT WE HAVE THROUGH #4
        ## 5. From the data set in step 4, creates a second, independent tidy data set with
        ##    the average of each variable for each activity and each subject.
        
        print("creating second dataset (21/22)")
        data5<-select(data,subject,calculation,readingtype,activitydescription,value)
        data52<-ddply(data5, .(subject,calculation,readingtype,activitydescription),summarize,average=mean(value))
        
        print("writing files (22/22)")
        setwd(dir)
        write.table(data,file="dataset1.txt",row.names = FALSE)
        write.table(data52,file="dataset2.txt",row.names = FALSE)
        setwd(oldwd)
        print("DONE!")
}

