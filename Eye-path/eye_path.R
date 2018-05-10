#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' This script draws all the eye movement path from version 1 to 6


source("~/Desktop/36726 Statistical Practice/Project/code/Eye-path/eye_path_functions.R")
source("~/Desktop/36726 Statistical Practice/Project/code/Altertation/alternation_functions.R")
# read the data
setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw data/")
files = dir()
files = sort(files)
Y_LIM = 1000

v = 1
for (file in files){
  setwd("~/Desktop/36726 Statistical Practice/Project/data/Raw data/")
  data = read.table(file, sep = "\t", header = TRUE, as.is = TRUE) %>%
          trial_num_fix_raw()
  # convert to numerical and flip the y_axis
  data$Point.of.Regard.Left.X..px. = suppressWarnings(as.numeric(data$Point.of.Regard.Left.X..px.))
  data$Point.of.Regard.Left.Y..px. = Y_LIM - suppressWarnings(as.numeric(data$Point.of.Regard.Left.Y..px.))
  data$Point.of.Regard.Right.X..px. = suppressWarnings(as.numeric(data$Point.of.Regard.Right.X..px.))
  data$Point.of.Regard.Right.Y..px. = Y_LIM - suppressWarnings(as.numeric(data$Point.of.Regard.Right.Y..px.))
  max_x = max(max(data$Point.of.Regard.Left.X..px., na.rm = TRUE), max(data$Point.of.Regard.Right.X..px., na.rm = TRUE))
  min_x = min(min(data$Point.of.Regard.Left.X..px., na.rm = TRUE), min(data$Point.of.Regard.Right.X..px., na.rm = TRUE))
  max_y = max(max(data$Point.of.Regard.Left.Y..px., na.rm = TRUE), max(data$Point.of.Regard.Right.Y..px., na.rm = TRUE))
  min_y = min(min(data$Point.of.Regard.Left.Y..px., na.rm = TRUE), min(data$Point.of.Regard.Right.Y..px., na.rm = TRUE))
  setwd(paste0("~/Desktop/36726 Statistical Practice/Project/data/Eye path/Version ", v))
  p_list = unique(data$Participant)
  t_list = unique(data$Trial)
  # loop through each participant and each trial
  # draw the eye movement path for both left and right eye
  for (p in p_list){
    for (t in t_list){
      # extract the left eye data from raw data
      cur_left_data = data %>%
                         filter(Participant == p & Trial == t) %>%
                         select("Point.of.Regard.Left.X..px.", "Point.of.Regard.Left.Y..px.")
      #cur_left_data = suppressWarnings(sapply(cur_left_data, as.numeric)) %>% 
                         #as.data.frame()
      colnames(cur_left_data) = c("x", "y")
      
      # extract the right eye data from raw data
      cur_right_data = data %>%
                          filter(Participant == p & Trial == t) %>%
                          select("Point.of.Regard.Right.X..px.", "Point.of.Regard.Right.Y..px.")
      colnames(cur_right_data) = c("x", "y")
      
      # plot the eye movement path
      plot(eye_path(cur_left_data, p, v, t, "left", min_x, max_x, min_y, max_y))
      ggsave(paste0(p, " ", t, " left", ".png"), width = 16, height = 9)
      plot(eye_path(cur_right_data, p, v, t, "right", min_x, max_x, min_y, max_y))
      ggsave(paste0(p, " ", t, " right", ".png"), width = 16, height = 9)
    }
  }
  
  v = v + 1
}



