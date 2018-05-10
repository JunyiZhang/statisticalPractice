#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' This file contains all the functions required to 
#' draw the eye movement path based on raw data
#' 

if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}

if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}

eye_path = function(data, participant, version, trial, eye, x_min, x_max, y_min, y_max){
  #' draw the eye movement path for a given participant in a given page
  #' with a given eye. A ggplot will be produced.
  #' 
  #' @param data: the raw data 
  #' @param participant: the participant id
  #' @param version: the version number
  #' @param trial: the trial number
  #' @param eye: left eye or right eye
  
  # crate the label so the first 10 percent of the rows have label 1
  # the second 10 percent of the rows have label 2, etc
  # when we plot the eye movement path, the color corresponds to the label
  # could tell us the eye movement order.
  order = as.numeric(cut_number(c(1:nrow(data)), 10))
  data = cbind(data, order)
  ggplot(data, aes(x = x, y = y)) + 
    geom_point(alpha = 0.5, na.rm = TRUE, aes(color = factor(order))) +
    xlim(x_min, x_max) + 
    ylim(y_min, y_max) +
    ggtitle(paste0("Version: ", version, " ", trial, " ", participant, " ", eye))
}

