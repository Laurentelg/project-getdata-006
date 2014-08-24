
project-getdata-006
===================
- Only one scrip needs to be run to go through 5 steps described in the project assignment test.
- Prerequisite : The package "reshape" should be installed before running the script
- In order to run the script just clone the repository and run run_analysis.R this will produce
the file tidy_data_set.txt

The Analysis script goes through the following phases (more details int CodeBook.md): 
- using read.table to load the raw files from the train and test directories.
- Combines the subject and activity labels with the main data set for the training and test data sets. Starting with the Activities and the subject ID (using cbind)
- Binds the training and test data sets as one dataframe using rbind.
- Extracts only the measurements on the mean and standard deviation for each measurement.
  - Note I have chosen only the faetures that ends with mean() and  std() in their names (including features that ends 
with spatial coordinates)
- Replaces the activity labels by their names
- Labels all the columns with appropriate names based on the original columns names from features.txt
- finally using the powerful reshape library and the melt and cast function to compute the mean for each columns based on the Subject.Id and Activity. This last step produce the tidy data set.

The repository is organized as follow : 
- test and train directory : contains the raw data to be analyzed.
- CodeBook.md : The features and script description
- Coursera_UCI_HAR_Dataset.Rproj : RStudio project
- README.md : This file
- README.txt: Readme file for the HAR Data Set
- activity_labels.txt : Activity labels
- features.txt : List of features from the raw unprocessed data files
- features_info.txt : Features explanations from the raw unprocessed data files
- run_analysis.R : Script to be run to get to the raw data
- tidy_data_set.txt : Tidy data set