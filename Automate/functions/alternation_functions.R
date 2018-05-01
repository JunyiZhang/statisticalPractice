#' CMU MSP 36726 Project
#' Junyi Zhang
#' 
#' April, 2018
#' 
#' This file contains all the necessary functions that are used to generate
#' the alternation plots



# load all the necessary packages
if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}

if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}

if (!require("ggforce")) {
  install.packages("ggforce")
  library(ggforce)
}

if (!require("ggthemes")) {
  install.packages("ggthemes")
  library(ggforce)
}

if (!require("RColorBrewer")) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}

if(!require("stringr")) {
  install.packages("stringr")
  library(stringr)
}


alt_plot_trial = function(data, eye, version, trial){
  #' plot the alternation of each participant of a trial
  #' e.g. from text to image
  #' only fixation is considered all the other status are ignored
  #' 
  #' @param data: raw data used to generate the plot
  #' @param eye: the eye we focused on in the alternation plot
  #'             It should be "left" or "right"
  #' @param version: An int. the version number of the data.
  #' @param trial: An int. The trial number.
  #' 
  #' @return Print an alternation plot.
  
  # the interval between two records
  # 1/60 seconds which is 16.7 ms
  INTERVAL = 16.7
  
  # filter the data and only keep the data with desired eye
  # stop the program if wrong eye input is given
  if(eye == "left") {
    data = select(data, c(RecordingTime..ms., Trial, 
                          Participant, Category.Left, AOI.Name.Left, 
                          Tracking.Ratio....)) 
  }else if (eye == "right") {
    data = select(data, c(RecordingTime..ms., Trial, 
                          Participant, Category.Right, AOI.Name.Right, 
                          Tracking.Ratio....)) 
  }else{
    stop("Eye option could only be left or right.")
  }
  
  # rename the data
  names(data) = c("Record_time", "Trial", "Participant",
                  "Category", "AOI", "Tracking_ratio")
  # filter the data and only keep the desired trial
  data$Trial = as.numeric(gsub("Trial", "", data$Trial))
  data = filter(data, Category == "Fixation" & Trial == trial)
  # generate a list of participant in the raw data
  participant_list = unique(data$Participant)
  
  # initiliaze all the lists
  # list of coordinates of rect
  xmin = c() # start of fixation
  xmax = c() # end of fixation
  ymin = c()
  ymax = c()
  # list of aoi
  aoi = c()
  # the end x coordinates of each participant
  end = c()
  # list of tracking ratio
  tr = c()
  
  index = 0
  # loop through all the participants
  for (participant in participant_list) {
    # data of current participant
    p_data = filter(data, Participant == participant)
    # find the start and end of each fixation
    mark = cumsum(rle(p_data$AOI)$length) * INTERVAL
    end = c(end, mark[length(mark)])
    xmax = c(xmax, mark)
    # accomadate the situation of participant only focus
    # on one thing
    if (length(mark) != 1){
      xmin = c(xmin, 0, mark[1:(length(mark) - 1)])
    } else {
      xmin = c(xmin, 0)
    }
    ymin = c(ymin, rep(index, length(mark)))
    ymax = c(ymax, rep(index + 1, length(mark)))
    aoi = c(aoi, rle(p_data$AOI)$values)
    tr = c(tr, mean(p_data$Tracking_ratio))
    index = index + 1
  }
  
  tr = as.integer(tr)
  # concatenate the participant id with tracking ratio
  label = paste(participant_list, tr)
  
  # df stores all the coordinates for rect
  df = data.frame(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, AOI = aoi)
  # df stores all the corrdinates for text (id + tr)
  df_text = data.frame(x = end + max(df$xmax) * 0.05, 
                       y = seq(0.5, (0.5 + 1 * (length(participant_list) - 1)), 1), 
                       label = label)
  # define the color for each group 
  # define blue and purplr
  blue = c("cadetblue1", "blue", "deepskyblue3", "navyblue", "royalblue1", "turquoise3", "lightseagreen")
  red = c("red", "darkorange", "tomato1", "violetred4", "mediumorchid2", "violetred2", "sienna3")
  
  aoi_cate = unique(aoi)
  text_cate = aoi_cate[grep("Text", aoi_cate)]
  text_col = blue[1:length(text_cate)]
  image_cate = aoi_cate[grep("Image", aoi_cate)]
  image_col = red[1:length(image_cate)]
  # the first two colors are for - and white space
  df_color = c("palegreen", "white", text_col, image_col)
  names(df_color) = c("-", "White Space", text_cate, image_cate)
  
  
  # make the plot
  ggplot() + 
    geom_rect(data = df, 
              mapping = aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = AOI), 
              alpha = 0.5) +
    scale_fill_manual(values = df_color) +
   # scale_fill_brewer(palette = "Paired") + 
    geom_text(data = df_text, mapping = aes(x = x, y = y, label = label), 
              size = 4, col = "gray30", family = "Times") +
    xlab("Time (ms)") +
    ylab("Participants") + 
    labs(title = paste("Alternation for version", version, "tiral", trial),
         caption = "Tracking ratio is appended after ID") 
}

alt_plot_participant = function(data, eye, id, version){
  #' plot the alternation of each trial of a participant
  #' e.g. from text to image
  #' only fixation is considered all the other status are ignored
  #' 
  #' @param data: raw data used to generate the plot
  #' @param eye: the eye we focused on in the alternation plot
  #'             It should be "left" or "right"
  #' @param id: The participant id.
  #' 
  #' @return Print an alternation plot.
  
  # the interval between two records
  # 1/60 seconds which is 16.7 ms
  INTERVAL = 16.7
  
  # filter the data and only keep the data with desired eye
  # stop the program if wrong eye input is given
  if(eye == "left") {
    data = select(data, c(RecordingTime..ms., Trial, 
                          Participant, Category.Left, AOI.Name.Left,
                          Tracking.Ratio....)) 
  }else if (eye == "right") {
    data = select(data, c(RecordingTime..ms., Trial, 
                          Participant, Category.Right, AOI.Name.Right,
                          Tracking.Ratio....)) 
  }else{
    stop("Eye option could only be left or right.")
  }
  
  # rename the data
  names(data) = c("Record_time", "Trial", "Participant", "Category", "AOI", "Tracking_ratio")
  # filter the data and only keeps the desired participant
  data$Trial = as.numeric(gsub("Trial", "", data$Trial))
  data = filter(data, Category == "Fixation" & Participant == id)
  
  # list of trials
  trial_list = unique(data$Trial)
  
  # initiliaze all the lists
  # list of coordinates of rect
  xmin = c() # start of fixation
  xmax = c() # end of fixation
  ymin = c()
  ymax = c()
  aoi = c() # list of aoi
  end = c()
  tr = c() # list of tracking ratio
  
  index = 0
  # loop through all the trials
  for(t in trial_list){
    # data for desired trial
    t_data = filter(data, Trial == t)
    # find the start and end of the fixation
    mark = cumsum(rle(t_data$AOI)$length) * INTERVAL
    end = c(end, mark[length(mark)])
    xmax = c(xmax, mark)
    # accomadate the situation of participant only focus
    # on one thing
    if (length(mark) != 1){
      xmin = c(xmin, 0, mark[1:(length(mark) - 1)])
    } else {
      xmin = c(xmin, 0)
    }
    ymin = c(ymin, rep(index, length(mark)))
    ymax = c(ymax, rep(index + 1, length(mark)))
    aoi = c(aoi, rle(t_data$AOI)$values)
    tr = c(tr, mean(t_data$Tracking_ratio))
    index = index + 1
  }
  
  tr = as.integer(tr)
  
  # concatenate the trial number with tracking ratio
  label = paste("Trial", trial_list, tr)
  
  # df stores all the coordinates for rect
  df = data.frame(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, AOI = aoi)
  # df stores all the corrdinates for text (trial + tr)
  df_text = data.frame(x = end + max(df$xmax) * 0.05, 
                       y = seq(0.5, (0.5 + 1 * (length(trial_list) - 1)), 1), 
                       label = label)
  
  # define the color for each group 
  # define blue and purplr
  blue = c("cadetblue1", "blue", "deepskyblue3", "navyblue", "royalblue1", "turquoise3", "lightseagreen")
  red = c("red", "darkorange", "tomato1", "violetred4", "mediumorchid2", "violetred2", "sienna3")
  
  aoi_cate = unique(aoi)
  text_cate = aoi_cate[grep("Text", aoi_cate)]
  text_col = blue[1:length(text_cate)]
  image_cate = aoi_cate[grep("Image", aoi_cate)]
  image_col = red[1:length(image_cate)]
  # the first two colors are for - and white space
  df_color = c("palegreen", "white", text_col, image_col)
  names(df_color) = c("-", "White Space", text_cate, image_cate)
  
  # make the plot
  ggplot() + 
    geom_rect(data = df, 
              mapping = aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = AOI), 
              alpha = 0.5) +
    scale_fill_manual(values = df_color) +
    geom_text(data = df_text, mapping = aes(x = x, y = y, label = label), size = 4) +
    xlab("Time (ms)") +
    ylab("Trial") + 
    labs(title = paste("Alternation for participant", id, "Version", version),
         caption = "Tracking ratio is appended after trial number") 
}

trial_num_fix_raw = function(data){
  #' fix the trial number for any dataset. The idea is the number of stimulus 
  #' and trial number should be same. Find a participant who has correct trial 
  #' number and stimulus. Replace all the incorrect trial numbers based on the 
  #' correct one-to-one map we found.
  #' 
  #' @param data: the dataframed to be fixed
  #' 
  #' @return data: the fixed dataframe
  
  # get a unique participant list
  participant_list = unique(data$Participant)
  # loop through all the participants and find the first one
  # with correct trial number and stimulus
  for (par in participant_list) {
    p_data = filter(data, Participant == par)
    if (length(unique(p_data$Trial)) == length(unique(p_data$Stimulus))) {
      ts_df = as.character(unique((p_data$Trial)))
      names(ts_df) = unique(p_data$Stimulus)
      break
    }
  }
  # loop through all the participant
  for (par in participant_list) {
    p_data = filter(data, Participant == par)
    # if the trial number is wrong, fix the trial number based on the correct 
    # one we found
    if (length(unique(p_data$Trial)) != length(unique(p_data$Stimulus))) {
      p_data$Trial = sapply(as.character(p_data$Stimulus), function(x) ts_df[[x]])
      data = rbind(filter(data, Participant != par), p_data)
    }
  }
  return(data)
}


alt_stats = function(data, eye, version){
  #' Calculate the alternation (i.e. the alternation from one AOI to another) 
  #' stats using the raw data
  #' 
  #' @param data: the raw data
  #' @param eye: the eye we focus on, either left or right
  #' @param version: the version of the study
  #' 
  #' @return df: the dataframe contains all the alternation stats
  
  # the interval between two records
  # 1/60 seconds which is 16.7 ms
  INTERVAL = 16.7
  
  # filter the data and only keep the data with desired eye
  # stop the program if wrong eye input is given
  if( eye == "left") {
    data = select(data, c(Trial, Participant, 
                          Category.Left, AOI.Group.Left,
                          Tracking.Ratio....)) 
  }else if (eye == "right") {
    data = select(data, c(Trial, Participant, 
                          Category.Right, AOI.Group.Right,
                          Tracking.Ratio....)) 
  }else{
    stop("Eye option could only be left or right.")
  }
  
  # rename the variables
  names(data) = c("Trial", "Participant", "Category","AOI", "Tracking_ratio")
  data = filter(data, data$Category == "Fixation")
  data$AOI[data$AOI == ""] = "ws"
  data$AOI[data$AOI == "-"] = "dash"
  data$AOI = trimws(data$AOI, which = "both")
  data$Trial = as.numeric(gsub("Trial", "", data$Trial))
  
  p_list = unique(data$Participant)
  t_list = unique(data$Trial)
  
  # initialize the return dataframe
  df = data.frame(Participant = character(),
                  Trial = character(),
                  max_text_time = double(),
                  ws_Text = integer(),
                  ws_Image = integer(),
                  ws_dash = integer(),
                  Text_Image = integer(),
                  Text_ws = integer(),
                  Text_dash = integer(),
                  Image_Text = integer(),
                  Image_ws = integer(),
                  Image_dash = integer(),
                  dash_Image = integer(),
                  dash_Text = integer(),
                  dash_ws = integer(),
                  weighted_text_image = double(),
                  weighted_alt = double(), 
                  total_alt = integer())
  # loop through all the participants and all the trials
  for (p in p_list) {
    for (t in t_list){
      cur = filter(data, Trial == t & Participant == p)
      shift_rle = rle(cur$AOI)
      shift = shift_rle$values
      cur_df = data.frame(Participant = p,
                          Trial = paste0("Trial", sprintf("%03d", t)),
                          max_text_time = 0,
                          ws_Text = 0,
                          ws_Image = 0,
                          ws_dash = 0,
                          Text_Image = 0,
                          Text_ws = 0,
                          Text_dash = 0,
                          Image_Text = 0,
                          Image_ws = 0,
                          Image_dash = 0,
                          dash_Image = 0,
                          dash_Text = 0,
                          dash_ws = 0,
                          weighted_text_image = 0,
                          weighted_alt = 0,
                          total_alt = 0)
      
      text_image_index = c()
      
      # calculate the alternations among different AOIs
      if (nrow(cur) != 0 & length(shift) > 1){
        for (index in 1:(length(shift) - 1)){
          shift_name = paste0(shift[index], "_", shift[index + 1])
          if(shift_name == "Text_Image"){
            text_image_index = c(text_image_index, index)
          }
          cur_df[shift_name] = cur_df[shift_name] + 1
        }
      }
      
      # calculate the total alternations
      cur_df$total_alt = length(shift) + 1
      
      # calculate the max text time
      max_text_time = shift_rle$lengths[which(shift_rle$values == "Text")]
      cur_df$max_text_time = ifelse(length(max_text_time) != 0, INTERVAL * max(max_text_time), 0)
      
      # calculate the weighted text to image
      cur_df$weightted_text_image = sum(1 - cumsum(shift_rle$lengths)[text_image_index] / length(cur$AOI))
      
      
      # calculate the weighted alternation counts
      weighted_alt = sum(1 - cumsum(shift_rle$lengths) / length(cur$AOI))
      cur_df$weighted_alt = weighted_alt
      
      # bind the data frame
      df = rbind(df, cur_df)
    }
  }
  return(df)
}


alt_plot_cluster = function(data, eye, cur_cluster, good=NA) {
  #' Plot the alternation plots based on the clustering result
  #' 
  #' @param data: the raw data
  #' @param eye: the eye we focus on, either left or right
  #' @param cur_cluster: the clustering dataframe. Should have participant id,
  #'              cluster, version, trial
  #' @param good: optional argument. TRUE if the clustering is for good reader
  #'                                 FALSE if the clustering is for bad reader
  #'                                 NA if not applicable
  #' 
  #' @return print the alternation plot
  #' 
  #'              
  
  # the interval between two records
  # 1/60 seconds which is 16.7 ms
  INTERVAL = 16.7
  
  if  (good == TRUE) {
    good = "Good Reader"
  } else if(good == FALSE) {
    good = "Bad Reader"
  } else {
    good = ""
  }
  
  # filter the data and only keep the data with desired eye
  # stop the program if wrong eye input is given
  if(eye == "left") {
    data = select(data, c(RecordingTime..ms., Trial, 
                          Participant, Category.Left, AOI.Name.Left,
                          Tracking.Ratio....)) 
  }else if (eye == "right") {
    data = select(data, c(RecordingTime..ms., Trial, 
                          Participant, Category.Right, AOI.Name.Right,
                          Tracking.Ratio....)) 
  }else{
    stop("Eye option could only be left or right.")
  }
  # rename the data
  names(data) = c("Record_time", "Trial", "Participant", "Category", "AOI", "Tracking_ratio")
  data = filter(data, Category == "Fixation")
  data$Trial = as.numeric(gsub("Trial", "", data$Trial))
  
  if (typeof(cur_cluster$Trial) != "integer"){
    cur_cluster$Trial = as.numeric(gsub("Trial", "", cur_cluster$Trial))
  }

  
  # initiliaze all the lists
  # list of coordinates of rect
  xmin = c() # start of fixation
  xmax = c() # end of fixation
  ymin = c()
  ymax = c()
  aoi = c() # list of aoi
  end = c()
  tr = c() # list of tracking ratio
  label = c()
  
  index = 0
  valid = 0
  
  for (row in 1:nrow(cur_cluster)) {
    c_data = filter(data, Participant == cur_cluster$Participant[row] & Trial == cur_cluster$Trial[row])
    if (length(c_data$AOI) != 0) { 
      mark = cumsum(rle(c_data$AOI)$length) * INTERVAL
      end = c(end, mark[length(mark)])
      xmax = c(xmax, mark)
      # accomadate the situation if participant only focus
      # on one thing
      if (length(mark) != 1){
        xmin = c(xmin, 0, mark[1:(length(mark) - 1)])
      } else {
        xmin = c(xmin, 0)
      }
      ymin = c(ymin, rep(index, length(mark)))
      ymax = c(ymax, rep(index + 1, length(mark)))
      aoi = c(aoi, rle(c_data$AOI)$values)
      tr = c(tr, round(mean(c_data$Tracking_ratio, 0)))
      index = index + 1
      label = c(label, paste(c_data$Participant[1],
                             c_data$Trial[1],
                             tr[length(tr)]))
      valid = valid + 1
    }
  }
  
  # df stores all the coordinates for rect
  df = data.frame(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, AOI = aoi)
  # df stores all the corrdinates for text (trial + tracking ratio)
  df_text = data.frame(x = end + max(df$xmax) * 0.05, 
                       y = seq(0.5, (0.5 + 1 * (valid - 1)), 1), 
                       label = label)
  
  # define the color for each group 
  # define blue and purplr
  blue = c("cadetblue1", "blue", "deepskyblue3", 
           "navyblue", "royalblue1", "turquoise3", "lightseagreen")
  red = c("red", "darkorange", "tomato1", "violetred4", 
          "mediumorchid2", "violetred2", "sienna3")
  
  aoi_cate = unique(aoi)
  text_cate = aoi_cate[grep("Text", aoi_cate)]
  text_col = blue[1:length(text_cate)]
  image_cate = aoi_cate[grep("Image", aoi_cate)]
  image_col = red[1:length(image_cate)]
  # the first two colors are for - and white space
  df_color = c("palegreen", "white", text_col, image_col)
  names(df_color) = c("-", "White Space", text_cate, image_cate)
  
  # make the plot
  ggplot() + 
    geom_rect(data = df, 
              mapping = aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = AOI), 
              alpha = 0.5) +
    scale_fill_manual(values = df_color) +
    geom_text(data = df_text, mapping = aes(x = x, y = y, label = label), size = 4) +
    xlab("Time (ms)") +
    ylab("Trial") + 
    labs(title = paste("Alternation for cluster", cur_cluster$Cluster[1], " ", good),
         caption = "Tracking ratio is appended after trial number") 
}
