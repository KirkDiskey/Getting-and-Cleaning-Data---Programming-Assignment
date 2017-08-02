Course Project - Getting and Cleaning Data

The run_analysis.R, does the following:

1. Downloads the .zip file (dataset) into the working directory
2. Loads the activity and feature info
3. Loads both the training and test datasets
4. on the training and test datasets, filters for only data related to mean or standard deviation
5. Loads the activity and subject datasets
6. Merges the train and test datasets and adds labels
7. create factors from subjects and activities
8. Creates a tidy dataset (tidy.txt) that contains the mean value of each variable for each subject and activity combination
