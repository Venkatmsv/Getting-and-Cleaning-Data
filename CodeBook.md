---
title: "Getting and Cleaning Data"
author: "Venkat"
date: "Thursday, March 16, 2016"
output: html_document
---

Read all the different flat files data into a variables. Namely x_train.txt, y_train.txt, subject_train.txt, x_test.txt, y_test.txt, subject_train.txt and features.txt, activity_labels.txt.

Once read all the above data into separate variables, both train and test data sets should be merged together. The mergerd datasets are mergedData, mergedSubject, mergedLabels.

Extract only the mean and standard deviation related measures only from the merged dataset

Using the descriptive names for the activities in the merged activity data set.

Appropriately name the merged data sets.

Merged the above tidy dataset and create one consolidate dataset. 

From the above consolidated data set, create another data set called tidyFinalData with the mean of each variable for each activity and each subject and write into a text file.
