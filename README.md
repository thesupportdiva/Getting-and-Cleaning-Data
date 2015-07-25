Files Included
=======================
- Codebook.md - Codebook for this project
- README.md - README file for this project
- run_analysis.R - R script that tidies UCSI Samsung Phone test and training data

Libraries Used
=======================
- data.table
- dplyr

If you do not have these installed, you will need to run the following:
- install.packages("dplyr")
- install.packages("data.table")

Steps to Use
=======================
1. Clone this repo ```git clone https://github.com/thesupportdiva/Getting-and-Cleaning-Data.git```
2. Set your working directory in R to the correct filepath you want to use before running this program. This filepath should be to the ```Getting-and-Cleaning-Data``` directory you've just cloned from my Git repo - ```setwd("your filepath to Getting-and-Cleaning-Data")```
2. Run ```source("run_analysis.R")```
3. This will create a Clean_Data directory in the ```Getting-and-Cleaning-Data``` directory , download the needed raw data, display the merged and transformed data using View in R and then create a tidy.txt file in the Clean_Data directory.
4. To read the tidy.txt file in R use ```finalData <- read.csv("<filepath>/tidy.txt", header = TRUE, sep=",")```.  You can then view this in R using ```View(finalData)```.
