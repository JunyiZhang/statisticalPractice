#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' This file contain all the functions used to calculate the condition
#' summary stats based on the reformatted data

if (!require("dplyr")) {
  install.packages("dplyr")
  suppressMessages(library(dplyr))
}

condition_summary = function(data, sep) {
  #' Separate the reformatted data into two conditions (standard vs other)
  #' aggregate all the stats based on the condition. Two return files are written
  #' in csv.
  #'
  #' @param data: the reformatted data
  #' @param sep: the last trial of first condition
  #'
  #' @return a list of condition summary

  # convert trial number to numeric
  data$Trial_num = as.numeric(gsub("Trial", "", data$Trial))
  # separate tew conditions
  con1 = filter(data, Trial_num <= sep)
  con2 = filter(data, Trial_num > sep)

  # aggregate variables based on condition over participant
  con1 = con1 %>%
          group_by(Participant) %>%
          summarise(Avg_trial_dur = mean(Trial_dur, na.rm = TRUE),
                    Avg_blank_fix_count = mean(Blank_fix_count, na.rm = TRUE),
                    Avg_blank_fix_time = mean(Blank_fix_time, na.rm = TRUE),
                    Avg_blank_fix_time_pct = mean(Blanks_fix_time_pct, na.rm = TRUE),
                    Avg_image_fix_count = mean(Image_fix_count, na.rm = TRUE),
                    Avg_image_fix_time = mean(Image_fix_time, na.rm = TRUE),
                    Avg_image_fix_time_pct = mean(Image_fix_time_pct, na.rm = TRUE),
                    Avg_text_fix_count = mean(Text_fix_count, na.rm = TRUE),
                    Avg_text_fix_time = mean(Text_fix_time, na.rm = TRUE),
                    Avg_text_fix_time_pct = mean(Text_fix_time_pct, na.rm = TRUE),
                    Avg_fix_count = mean(Fix_count, na.rm = TRUE),
                    Avg_total_fix_dur = mean(Total_fix_dur, na.rm = TRUE),
                    Avg_saccade_count = mean(Saccade_count, na.rm = TRUE),
                    Avg_total_saccade_dur = mean(Total_saccade_dur, na.rm = TRUE),
                    Avg_total_saccade_amp = mean(Total_saccade_amp, na.rm = TRUE),
                    Avg_total_saccade_velocity = mean(Total_saccade_velocity, na.rm = TRUE),
                    Avg_blink_count = mean(Blink_count, na.rm = TRUE),
                    Avg_extraneous_fix_count = mean(Extraneous_fix_count, na.rm = TRUE),
                    Avg_relevant_fix_count = mean(Relevant_fix_count, na.rm = TRUE),
                    Avg_extraneous_fix_time = mean(Extraneous_fix_time, na.rm = TRUE),
                    Avg_relevant_fix_time = mean(Relevant_fix_time, na.rm = TRUE),
                    Avg_ws_Text = mean(ws_Text, na.rm = TRUE),
                    Avg_ws_Image = mean(ws_Image, na.rm = TRUE),
                    Avg_ws_dash = mean(ws_dash, na.rm = TRUE),
                    Avg_ws_Relevant = mean(ws_Relevant, na.rm = TRUE),
                    Avg_ws_Extraneous = mean(ws_Extraneous, na.rm = TRUE),
                    Avg_Text_Image = mean(Text_Image, na.rm = TRUE),
                    Avg_Text_ws = mean(Text_ws, na.rm = TRUE),
                    Avg_Text_dash = mean(Text_dash, na.rm = TRUE),
                    Avg_Text_Relevant = mean(Text_Relevant, na.rm = TRUE),
                    Avg_Text_Extraneous = mean(Text_Extraneous, na.rm = TRUE),
                    Avg_Image_Text = mean(Image_Text, na.rm = TRUE),
                    Avg_Image_ws = mean(Image_ws, na.rm = TRUE),
                    Avg_Image_dash = mean(Image_dash, na.rm = TRUE),
                    Avg_Relevant_Text = mean(Relevant_Text, na.rm = TRUE),
                    Avg_Relevant_ws = mean(Relevant_ws, na.rm = TRUE),
                    Avg_Relevant_dash = mean(Relevant_dash, na.rm = TRUE),
                    Avg_Relevant_Extraneous = mean(Relevant_Extraneous, na.rm = TRUE),
                    Avg_Extraneous_Text = mean(Extraneous_Text, na.rm = TRUE),
                    Avg_Extraneous_ws = mean(Extraneous_ws, na.rm = TRUE),
                    Avg_Extraneous_dash = mean(Extraneous_dash, na.rm = TRUE),
                    Avg_Extraneous_Relevant = mean(Extraneous_Relevant, na.rm = TRUE),
                    Avg_dash_Image = mean(dash_Image, na.rm = TRUE),
                    Avg_dash_Text = mean(dash_Text, na.rm = TRUE),
                    Avg_dash_ws = mean(dash_ws, na.rm = TRUE),
                    Avg_dash_Relevant = mean(dash_Relevant, na.rm = TRUE),
                    Avg_dash_Extraneous = mean(dash_Extraneous, na.rm = TRUE),
                    Avg_total_alt = mean(total_alt, na.rm = TRUE),
                    Avg_weighted_text_image = mean(weighted_text_image, na.rm = TRUE),
                    Avg_weighted_image_ws = mean(weighted_image_ws, na.rm = TRUE),
                    Avg_weighted_alt = mean(weighted_alt, na.rm = TRUE),
                    Version = as.integer(mean(Version, na.rm = TRUE)))

  con2 = con2 %>%
          group_by(Participant) %>%
          summarise(Avg_trial_dur = mean(Trial_dur, na.rm = TRUE),
                    Avg_blank_fix_count = mean(Blank_fix_count, na.rm = TRUE),
                    Avg_blank_fix_time = mean(Blank_fix_time, na.rm = TRUE),
                    Avg_blank_fix_time_pct = mean(Blanks_fix_time_pct, na.rm = TRUE),
                    Avg_image_fix_count = mean(Image_fix_count, na.rm = TRUE),
                    Avg_image_fix_time = mean(Image_fix_time, na.rm = TRUE),
                    Avg_image_fix_time_pct = mean(Image_fix_time_pct, na.rm = TRUE),
                    Avg_text_fix_count = mean(Text_fix_count, na.rm = TRUE),
                    Avg_text_fix_time = mean(Text_fix_time, na.rm = TRUE),
                    Avg_text_fix_time_pct = mean(Text_fix_time_pct, na.rm = TRUE),
                    Avg_fix_count = mean(Fix_count, na.rm = TRUE),
                    Avg_total_fix_dur = mean(Total_fix_dur, na.rm = TRUE),
                    Avg_saccade_count = mean(Saccade_count, na.rm = TRUE),
                    Avg_total_saccade_dur = mean(Total_saccade_dur, na.rm = TRUE),
                    Avg_total_saccade_amp = mean(Total_saccade_amp, na.rm = TRUE),
                    Avg_total_saccade_velocity = mean(Total_saccade_velocity, na.rm = TRUE),
                    Avg_blink_count = mean(Blink_count, na.rm = TRUE),
                    Avg_extraneous_fix_count = mean(Extraneous_fix_count, na.rm = TRUE),
                    Avg_relevant_fix_count = mean(Relevant_fix_count, na.rm = TRUE),
                    Avg_extraneous_fix_time = mean(Extraneous_fix_time, na.rm = TRUE),
                    Avg_relevant_fix_time = mean(Relevant_fix_time, na.rm = TRUE),
                    Avg_ws_Text = mean(ws_Text, na.rm = TRUE),
                    Avg_ws_Image = mean(ws_Image, na.rm = TRUE),
                    Avg_ws_dash = mean(ws_dash, na.rm = TRUE),
                    Avg_ws_Relevant = mean(ws_Relevant, na.rm = TRUE),
                    Avg_ws_Extraneous = mean(ws_Extraneous, na.rm = TRUE),
                    Avg_Text_Image = mean(Text_Image, na.rm = TRUE),
                    Avg_Text_ws = mean(Text_ws, na.rm = TRUE),
                    Avg_Text_dash = mean(Text_dash, na.rm = TRUE),
                    Avg_Text_Relevant = mean(Text_Relevant, na.rm = TRUE),
                    Avg_Text_Extraneous = mean(Text_Extraneous, na.rm = TRUE),
                    Avg_Image_Text = mean(Image_Text, na.rm = TRUE),
                    Avg_Image_ws = mean(Image_ws, na.rm = TRUE),
                    Avg_Image_dash = mean(Image_dash, na.rm = TRUE),
                    Avg_Relevant_Text = mean(Relevant_Text, na.rm = TRUE),
                    Avg_Relevant_ws = mean(Relevant_ws, na.rm = TRUE),
                    Avg_Relevant_dash = mean(Relevant_dash, na.rm = TRUE),
                    Avg_Relevant_Extraneous = mean(Relevant_Extraneous, na.rm = TRUE),
                    Avg_Extraneous_Text = mean(Extraneous_Text, na.rm = TRUE),
                    Avg_Extraneous_ws = mean(Extraneous_ws, na.rm = TRUE),
                    Avg_Extraneous_dash = mean(Extraneous_dash, na.rm = TRUE),
                    Avg_Extraneous_Relevant = mean(Extraneous_Relevant, na.rm = TRUE),
                    Avg_dash_Image = mean(dash_Image, na.rm = TRUE),
                    Avg_dash_Text = mean(dash_Text, na.rm = TRUE),
                    Avg_dash_ws = mean(dash_ws, na.rm = TRUE),
                    Avg_dash_Relevant = mean(dash_Relevant, na.rm = TRUE),
                    Avg_dash_Extraneous = mean(dash_Extraneous, na.rm = TRUE),
                    Avg_total_alt = mean(total_alt, na.rm = TRUE),
                    Avg_weighted_text_image = mean(weighted_text_image, na.rm = TRUE),
                    Avg_weighted_image_ws = mean(weighted_image_ws, na.rm = TRUE),
                    Avg_weighted_alt = mean(weighted_alt, na.rm = TRUE),
                    Version = as.integer(mean(Version, na.rm = TRUE)))
  return(list(con1, con2))
}


stimulus_summary = function(data, file_name) {
  #' Aggregate all the variables in reformatted data over participant and condition
  #' Write the export file in csv
  #'
  #' @param data: the reformatted data
  #' @param file_name: the export file name

  data = data %>%
          group_by(Participant, Condition) %>%
          summarise(Avg_trial_dur = mean(Trial_dur, na.rm = TRUE),
                    Avg_blank_fix_count = mean(Blank_fix_count, na.rm = TRUE),
                    Avg_blank_fix_time = mean(Blank_fix_time, na.rm = TRUE),
                    Avg_blank_fix_time_pct = mean(Blanks_fix_time_pct, na.rm = TRUE),
                    Avg_image_fix_count = mean(Image_fix_count, na.rm = TRUE),
                    Avg_image_fix_time = mean(Image_fix_time, na.rm = TRUE),
                    Avg_image_fix_time_pct = mean(Image_fix_time_pct, na.rm = TRUE),
                    Avg_text_fix_count = mean(Text_fix_count, na.rm = TRUE),
                    Avg_text_fix_time = mean(Text_fix_time, na.rm = TRUE),
                    Avg_text_fix_time_pct = mean(Text_fix_time_pct, na.rm = TRUE),
                    Avg_fix_count = mean(Fix_count, na.rm = TRUE),
                    Avg_total_fix_dur = mean(Total_fix_dur, na.rm = TRUE),
                    Avg_saccade_count = mean(Saccade_count, na.rm = TRUE),
                    Avg_total_saccade_dur = mean(Total_saccade_dur, na.rm = TRUE),
                    Avg_total_saccade_amp = mean(Total_saccade_amp, na.rm = TRUE),
                    Avg_total_saccade_velocity = mean(Total_saccade_velocity, na.rm = TRUE),
                    Avg_blink_count = mean(Blink_count, na.rm = TRUE),
                    Avg_ws_Text = mean(ws_Text, na.rm = TRUE),
                    Avg_ws_Image = mean(ws_Image, na.rm = TRUE),
                    Avg_ws_dash = mean(ws_dash, na.rm = TRUE),
                    Avg_ws_Relevant = mean(ws_Relevant, na.rm = TRUE),
                    Avg_ws_Extraneous = mean(ws_Extraneous, na.rm = TRUE),
                    Avg_Text_Image = mean(Text_Image, na.rm = TRUE),
                    Avg_Text_ws = mean(Text_ws, na.rm = TRUE),
                    Avg_Text_dash = mean(Text_dash, na.rm = TRUE),
                    Avg_Text_Relevant = mean(Text_Relevant, na.rm = TRUE),
                    Avg_Text_Extraneous = mean(Text_Extraneous, na.rm = TRUE),
                    Avg_Image_Text = mean(Image_Text, na.rm = TRUE),
                    Avg_Image_ws = mean(Image_ws, na.rm = TRUE),
                    Avg_Image_dash = mean(Image_dash, na.rm = TRUE),
                    Avg_Relevant_Text = mean(Relevant_Text, na.rm = TRUE),
                    Avg_Relevant_ws = mean(Relevant_ws, na.rm = TRUE),
                    Avg_Relevant_dash = mean(Relevant_dash, na.rm = TRUE),
                    Avg_Relevant_Extraneous = mean(Relevant_Extraneous, na.rm = TRUE),
                    Avg_Extraneous_Text = mean(Extraneous_Text, na.rm = TRUE),
                    Avg_Extraneous_ws = mean(Extraneous_ws, na.rm = TRUE),
                    Avg_Extraneous_dash = mean(Extraneous_dash, na.rm = TRUE),
                    Avg_Extraneous_Relevant = mean(Extraneous_Relevant, na.rm = TRUE),
                    Avg_dash_Image = mean(dash_Image, na.rm = TRUE),
                    Avg_dash_Text = mean(dash_Text, na.rm = TRUE),
                    Avg_dash_ws = mean(dash_ws, na.rm = TRUE),
                    Avg_dash_Relevant = mean(dash_Relevant, na.rm = TRUE),
                    Avg_dash_Extraneous = mean(dash_Extraneous, na.rm = TRUE),
                    Avg_total_alt = mean(total_alt, na.rm = TRUE),
                    Avg_weighted_text_image = mean(weighted_text_image, na.rm = TRUE),
                    Avg_weighted_image_ws = mean(weighted_image_ws, na.rm = TRUE),
                    Avg_weighted_alt = mean(weighted_alt, na.rm = TRUE),
                    Version = as.integer(mean(Version, na.rm = TRUE)))
  write.csv(data, paste0(file_name, ".csv"))
}
