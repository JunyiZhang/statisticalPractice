#' CMU MSP 36726 Project
#' Junyi Zhang
#' 
#' April, 2018
#' 
#' This script calculates the condition summary for version 1 to 6

# version 1
setwd("~/Desktop/36726 Statistical Practice/Project/data/clean data/")
source("~/Desktop/36726 Statistical Practice/Project/code/Condition Summary/condition_summary_functions.R")

data = read.csv("clean_data_v1.csv")
condition_summary(data, 4, "Verson 1 Standard", "Version 1 Separated")
stimulus_summary(data, "clean_stimulus_v1")

# version 2
data = read.csv("clean_data_v2.csv")
condition_summary(data, 8, "Verson 2 Separated", "Version 2 Standard")
stimulus_summary(data, "clean_stimulus_v2")

# version 3
data = read.csv("clean_data_v3.csv")
condition_summary(data, 4, "Verson 3 Standard", "Version 3 Partial")
stimulus_summary(data, "clean_stimulus_v3")

# version 4
data = read.csv("clean_data_v4.csv")
condition_summary(data, 4, "Verson 4 Partial", "Version 4 Standard")
stimulus_summary(data, "clean_stimulus_v4")

# version 5
data = read.csv("clean_data_v5.csv")
condition_summary(data, 3, "Verson 5 Standard", "Version 5 Clean")
stimulus_summary(data, "clean_stimulus_v5")

# version 6
data = read.csv("clean_data_v6.csv")
condition_summary(data, 3, "Verson 6 Clean", "Version 6 Standard")
stimulus_summary(data, "clean_stimulus_v6")

