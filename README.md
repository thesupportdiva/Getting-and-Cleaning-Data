Libraries Used
=======================
- data.table
- dplyr

Steps to Use
=======================
1. Set your working directory to the correct filepath you want to use before running this program - ```setwd("your filepath")```
2. Run ```source("run_analysis.R")```
3. This will create a Donna_Project directory in your set file path, download the needed raw data, display the merged and transformed data using View in R and then create a tidy.txt file in the Donna_Project directory.
4. To read the CSV file in R use data <- read.csv("<filepath>/tidy.txt", header = TRUE, sep=",")
