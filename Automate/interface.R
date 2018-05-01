#' CMU MSP 36726 Project
#' Junyi Zhang, Rebecca Gu, Dejia Su
#' 
#' April, 2018
#' 
#' Version 2.0
#' 
#' This script is the interface for the whole data cleaning process.

# STEP 0: Specifiy which version we are working on, which eye we want to foccus and the export file name
version = as.integer(readline(prompt = "Please enter version number and press [enter] to continue: "))
eye = readline(prompt = "Please enter eye we want to focus (left or right) and press [enter] to continue: ")
export_name = readline(prompt = "Please enter the export file name (without extension) and press [enter] to continue: ")
sep = readline(prompt = "Please enter last trial for the first condition and press [enter] to continue: ")
cond1 = readline(prompt = "Please enter the first condition name and press [enter] to continue: ")
cond2 = readline(prompt = "Please enter the second condition name and press [enter] to continue: ")

# STEP 1: select all the data needed for the cleaning purpose
invisible(readline(prompt = "Pleae choose AOI Blank file in the next dialogue window. Press [enter] to continue"))
blanks = read.table(file.choose(), sep = "\t", header = TRUE, encoding = "UTF-8")

invisible(readline(prompt = "Pleae choose AOI Fixation file in the next dialogue window. Press [enter] to continue"))
fixation = read.table(file.choose(), sep = "\t", header = TRUE, encoding = "UTF-8")

invisible(readline(prompt = "Pleae choose Fixations, saccades, and blink counts file in the next dialogue window. Press [enter] to continue"))
fsb_counts = read.table(file.choose(), sep = "\t", header = TRUE, encoding = "UTF-8")

invisible(readline(prompt = "Pleae choose Trial Duration file in the next dialogue window. Press [enter] to continue"))
trial_dur = read.table(file.choose(), sep = "\t", header = TRUE, encoding = "UTF-8")

invisible(readline(prompt = "Pleae choose raw file in the next window. Press [enter] to continue"))
data = read.table(file.choose(), sep = "\t", header = TRUE, as.is = TRUE, encoding = "UTF-8")

# STEP 2: let it run
source("./functions/auto_functions.R")
