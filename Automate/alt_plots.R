#' CMU MSP 36726 Project
#' Junyi Zhang, Rebecca Gu, Dejia Su
#' 
#' Update time : May 9th, 2018
#' 
#' Version 1.0
#' 
#' This script is the interface for creating alternation plots
#' 

# STEP 0: Autoset the working directory
if (!require("rstudioapi")) {
  install.packages("rstudioapi")
  suppressMessages(library("rstudioapi"))
}
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# STEP 1: Specify the version number and eye we should focus on
version = as.integer(readline(prompt = "Please enter version number and press [enter] to continue: "))
eye = readline(prompt = "Please enter eye we want to focus (left or right) and press [enter] to continue: ")

# STEP 2: Specify the type of the plot you want to create
cat("Please specify the type of the plot you want to create \n
     a. plot contains all trials(page) for one participant \n
     b. plot contains all the participants for one trial(page) \n
     c. Both")
type = readline(prompt = "Please enter 'a', 'b' or 'c' and press [enter] to continue: ")

# STEP 3: Load the data
invisible(readline(prompt = "Pleae choose raw file in the next window. Press [enter] to continue"))
data = read.table(file.choose(), sep = "\t", header = TRUE, as.is = TRUE, encoding = "UTF-8")

# STEP 4: let it run
source("./functions/alt_plots_process.R")