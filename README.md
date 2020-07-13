# getting-and-cleaning-data-final-project

Final project for the course of Getting and Cleaning Data

The final result is shown in the data set tidy.txt after following the next steps on the R script run_analysis.R:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Merges the two datasets
6. Converts the activity and subject columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
