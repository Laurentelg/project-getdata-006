## -------- Step 1 : Merging the training and the test sets to create one data set. -----
#The R working directory is relative to where the script is located.
#First step is to load all the raw data 

#Common data 
#Loading the activity labels
#activity_labels <- read.table("./activity_labels.txt",stringsAsFactors = FALSE)
#Test Data  
#Loading the test data set X_test.txt
X_test <- read.table("./test/X_test.txt",stringsAsFactors = FALSE)
#Loading Subject Test list
subject_test <- read.table("./test/subject_test.txt",stringsAsFactors = FALSE)
y_test <- read.table("./test/y_test.txt",stringsAsFactors = FALSE)


#Train data

#Loading the train data set X_train.txt
X_train <- read.table("./train/X_train.txt",stringsAsFactors = FALSE)
#Loading Subject Test list
subject_train <- read.table("./train/subject_train.txt",stringsAsFactors = FALSE)
y_train <- read.table("./train/y_train.txt",stringsAsFactors = FALSE)

#Combining the subject and activity labels with the main data set for TEST
#Starting with the Activities and the subject ID
subject_test <- cbind(subject_test,y_test)
#Renaming the columnes for better visibility
names(subject_test) <- c("Subject.Id","Activity.Id")
#Finaly binding the Subjects Id / Activities Id with the main Data set
X_test <- cbind(subject_test,X_test)

#Combining the subject and activity labels with the main data set for TRAIN
#Starting with the Activities and the subject ID
subject_train <- cbind(subject_train,y_train)
#Renaming the columnes for better visibility
names(subject_train) <- c("Subject.Id","Activity.Id")
#Finaly binding the Subjects Id / Activities Id with the main Data set
X_train <- cbind(subject_train,X_train)

#Appending the test data set to the train data set to have only one data set.
X <- rbind(X_test,X_train)

## -------- Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement.
## I have chosen only the faetures that ends with mean() and std() in their names (including features that ends 
## with spatial coordinates)
X <- X[,c(1,2,3,4,5,6,7,8,43,44,45,46,47,48,83,84,85,86,87,88,123,124,125,126,127,128,163,164,165,166,167,168,203,204,216,217,229,230,242,243,255,256,268,269,270,271,272,273,347,348,349,350,351,352,426,427,428,429,430,431,505,506,518,519,531,532,544,545)]
## -------- Step 3 : Replacing the activity labels by their names
X$Activity.Id[X$Activity.Id == 1] <- "WALKING"
X$Activity.Id[X$Activity.Id == 2] <- "WALKING_UPSTAIRS"
X$Activity.Id[X$Activity.Id == 3] <- "WALKING_DOWNSTAIRS"
X$Activity.Id[X$Activity.Id == 4] <- "SITTING"
X$Activity.Id[X$Activity.Id == 5] <- "STANDING"
X$Activity.Id[X$Activity.Id == 6] <- "LAYING"
# ---------- Step 4 : Appropriately labels the data set with descriptive variable names.
names(X) <- c("Subject.Id","Activity",
              "tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z",
              "tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z",
              "tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z",
              "tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z",
              "tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z",
              "tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z",
              "tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z",
              "tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z",
              "tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z",
              "tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z",
              "tBodyAccMag-mean()","tBodyAccMag-std()",
              "tGravityAccMag-mean()","tGravityAccMag-std()",
              "tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()",
              "tBodyGyroMag-mean()","tBodyGyroMag-std()",
              "tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()",
              "fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z",
              "fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z",
              "fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z",
              "fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z",
              "fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z",
              "fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z",    
              "fBodyAccMag-mean()","fBodyAccMag-std()",
              "fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()",
              "fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()",
              "fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()")

# # ---------- Step 5 : Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

##Using melt and cast to run the mean on the full data set 
#First installing the reshape package
#install.packages("reshape")
#Loading the library
library("reshape")
#Melting X
X_mt <- melt(X,id=(c("Subject.Id","Activity")))
#Casting with mean as aggregation
X_tidy <- cast(X_mt,Subject.Id+Activity ~ variable,mean)
#Writting the clean data set to a file named : tidy_data_set.txt
write.table(X_tidy,file="tidy_data_set.txt",row.names=FALSE)