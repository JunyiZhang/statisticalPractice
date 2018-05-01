#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' This file contains all the necessary functions that are used to reformat the
#' exported data.


# load the required packages
if( !require("dplyr")) {
  install.packages("dplyr")
  library("dplyr")
}


reformat = function(blanks, fix_image, fix_text, fsb_counts, trial_dur){
  #' join blanks, image fixation, text fixation, fixation saccade and blinks counts
  #' and trial duration together based on participant id, stimulus and trial number.
  #'
  #' The output is a dataframe contains all the information in five files mentioned above,
  #' where each row is a particular participant in a particular trial.
  #'
  #' @param blanks: a dataframe. Output of proc_blanks function
  #' @param fix_image: a dataframe. Output of proc_image function
  #' @param fix_text: a dataframe. Output of proc_text function
  #' @param fsb_counts: a dataframe. Output of proc_fsb_counts function
  #' @param trial_dur: a dataframe. Output of proc_trial_dur funtion
  #'
  #' @return ret: a dataframe.
  #'

  # check and extract a unique list of participant id
  participants_id = participants_check(blanks, fix_image, fix_text, fsb_counts, trial_dur)

  # initialize the return dataframe
  ret = data.frame(Participant = participants_id)

  # join the dataframe together
  ret = ret %>%
    full_join(trial_dur, by = "Participant") %>%
    full_join(blanks, by = c("Participant", "Stimulus")) %>%
    full_join(fix_image, by = c("Participant", "Trial", "Stimulus")) %>%
    full_join(fix_text, by = c("Participant", "Trial", "Stimulus")) %>%
    full_join(fsb_counts, by = c("Participant", "Trial", "Stimulus"))
  # add the condition based on the stimulus
  ret$Condition = condition_extract(ret)
  return(ret)
}

participants_check = function(blanks, fix_image, fix_text, fsb_counts, trial_dur){
  #' helper function to check whether participant are the same
  #' in all the dataframes (i.e. blanks, image fixation, text fixation, fixation saccade and blinks counts
  #' and trial duration) Output the unique participant id list.
  #'
  #' @param blanks: a dataframe. Output of proc_blanks function
  #' @param fix_image: a dataframe. Output of proc_image function
  #' @param fix_text: a dataframe. Output of proc_text function
  #' @param fsb_counts: a dataframe. Output of proc_fsb_counts function
  #' @param trial_dur: a dataframe. Output of proc_trial_dur funtion
  #'
  #' @return base: a list of unique participant id.

  # retreive unique participant id in blanks
  base = levels(blanks$Participant)

  # retreive unique particiopant id in rest of the datasets
  data_list = c(levels(fix_image$Participant),
                levels(fix_text$Participant),
                levels(fsb_counts$Participant),
                levels(trial_dur$Participant),
                levels(blanks$Participant))
  # compare if any two of them are different
  if (sum(base == unique(data_list)) != length(base)) {
    stop("[ERROR] Participants should be the same in all datasets!")
  }

  return(base)
}


check_blanks = function(blanks){
  #' Fix the trial number of AOI Blanks. Check whether the datasets includes all 
  #' the variables needed and ignore unnecessary variables. Renamme all the variables. 
  #' 
  #' The required variables are:
  #'  -Trial
  #'  -Stimulus
  #'  -Participant
  #'  -AOI.Name
  #'  -Fixation Count
  #'  -Fixation Time
  #'  -Fixation Time Percent
  #'  
  #'  @param blanks: the dataframe to be checked and renamed
  #'  
  #'  @return blanks: checked and renamed dataframe

  # fix the trial number
  blanks = trial_num_fix(blanks)
  # check whether we have all the variables needed
  # raise the error if we miss any variables
  # ignore all the unnecessary variables
  blanks = tryCatch(select(blanks, c("Trial", "Stimulus",
                       "Participant", "AOI.Name",
                       "Fixation.Count", "Fixation.Time..ms.",
                       "Fixation.Time...." )),
                    error = function(x) print("[ERROR] Variable missing in AOI Blanks"))
  names(blanks) = c("Trial", "Stimulus",
                    "Participant", "AOI.Name",
                    "Blank_fix_count", "Blank_fix_time",
                    "fix_time_pct")
  return(blanks)
}

proc_blanks = function(blanks){
  #' Process the AOI blanks. Sum all the variables over the rows
  #' with same trial, stimulus and participant. Recalculate fix time percent.
  #' 
  #' @param blanks: dataframe to be processed
  #' 
  #' @return blanks: the processed dataframe 

  # calculate the helper variable
  blanks$total_time = blanks$Blank_fix_time / (blanks$fix_time_pct / 100)
  blanks = select(blanks, -c(AOI.Name, fix_time_pct))
  # aggregate the variables
  blanks = blanks %>%
             group_by(Trial, Stimulus, Participant) %>%
             summarise(Blank_fix_count = sum(Blank_fix_count),
                       Blank_fix_time = sum(Blank_fix_time),
                       total_time = sum(total_time))
  # recalculate the fix time percent
  blanks$Blanks_fix_time_pct = blanks$Blank_fix_time / blanks$total_time * 100
  blanks$Blanks_fix_time_pct = replace(blanks$Blanks_fix_time_pct,
                                       is.na(blanks$Blanks_fix_time_pct), 0)
  blanks = select(blanks, -c(total_time))
  blanks$Trial = as.character(blanks$Trial)

  return(blanks)
}

check_fix_image = function(fix_image){
  #' Fix the trial number of image fixation. Check whether the datasets contains all the variables
  #' we need and ignore unnecessary variables. Rename all the variables. 
  #' 
  #' The required variables are:
  #'  -Trial
  #'  -Stimulus
  #'  -Participant
  #'  -AOI Group
  #'  -Fixation Count
  #'  -Fixation time 
  #'  -Fixation time percent
  #' 
  #' @param fix_image: the dataframe to be checked and renamed
  #' 
  #' @return fix_image: checked and renamed dataframe
  
  # fix the trial number
  fix_image = trial_num_fix(fix_image)
  # check the required variables
  # raise error if any is missing
  # ignore all the unecessary variables
  fix_image = tryCatch(select(fix_image, c("Trial", "Stimulus",
                                           "Participant", "AOI.Group",
                                           "Fixation.Count", "Fixation.Time..ms.",
                                           "Fixation.Time...." )),
                       error = function(x) print("[ERROR] Column missing in AOI Fixations"))
  # rename all the variables
  names(fix_image) = c("Trial", "Stimulus",
                       "Participant", "AOI.Name",
                       "Image_fix_count", "Image_fix_time",
                       "fix_time_pct")
  return(fix_image)
}

proc_fix_image = function(fix_image){
  #' Process the fix image dataframe. Sum all the variables over the trial,
  #' stimulus and participant. Recalculate the image fixation time percent.
  #' 
  #' @param fix_image: the dataframe to be processed
  #' 
  #' @return fix_image: the processed dataframe
  
  # calculate the helper variable 
  fix_image$total_time = fix_image$Image_fix_time / (fix_image$fix_time_pct / 100)
  fix_image = select(fix_image, -c(AOI.Name, fix_time_pct))
  # aggregate the variables
  fix_image = fix_image %>%
             group_by(Trial, Stimulus, Participant) %>%
             summarise(Image_fix_count = sum(Image_fix_count),
                       Image_fix_time = sum(Image_fix_time),
                       total_time = sum(total_time))
  # recalculate the image fixation time percent
  fix_image$Image_fix_time_pct = fix_image$Image_fix_time / fix_image$total_time * 100
  fix_image$Image_fix_time_pct = replace(fix_image$Image_fix_time_pct,
                                       is.na(fix_image$Image_fix_time_pct), 0)
  fix_image = select(fix_image, -c(total_time))
  fix_image$Trial = as.character(fix_image$Trial)
  return(fix_image)
}

check_fix_text = function(fix_text){
  #' Fix the trial number of text fixation. Check whether the datasets contains all the variables
  #' we need and ignore unnecessary variables. Rename all the variables.
  #' 
  #' The required variables are:
  #'  -Trial
  #'  -Stimulus
  #'  -Participant
  #'  -AOI Group
  #'  -Fixation Count
  #'  -Fixation time 
  #'  -Fixation time percent
  #' 
  #' @param fix_text: the dataframe to be checked and renamed
  #' 
  #' @return fix_text: checked and renamed dataframe
  
  # fix the trial number of text fixation
  fix_image = trial_num_fix(fix_text)
  # check if we have all the variables needed
  # raise error if we miss any
  # ingore all the unnecessary variables
  fix_text = tryCatch(select(fix_text, c("Trial", "Stimulus",
                                           "Participant", "AOI.Group",
                                           "Fixation.Count", "Fixation.Time..ms.",
                                           "Fixation.Time...." )),
                       error = function(x) print("[ERROR] Column missing in AOI Fixations"))
  # rename all the variables
  names(fix_text) = c("Trial", "Stimulus",
                      "Participant", "AOI.Name",
                      "Text_fix_count", "Text_fix_time",
                      "fix_time_pct" )
  return(fix_text)
}

proc_fix_text = function(fix_text){
  #' Process the text fixation dataframe. Aggregrate the variables over
  #' trial, stimulus and participant. Recalculate the text fixation time percent
  #' 
  #' @param fix_text: the dataframe to be processed
  #' 
  #' @return fix_text: processed dataframe
  
  # calculate the helper variable
  fix_text$total_time = fix_text$Text_fix_time / (fix_text$fix_time_pct / 100)
  fix_text = select(fix_text, -c(AOI.Name, fix_time_pct))
  # aggregate the variables
  fix_text = fix_text %>%
             group_by(Trial, Stimulus, Participant) %>%
             summarise(Text_fix_count = sum(Text_fix_count),
                       Text_fix_time = sum(Text_fix_time),
                       total_time = sum(total_time))
  # recalculate the text fixation time percent
  fix_text$Text_fix_time_pct = fix_text$Text_fix_time / fix_text$total_time * 100
  fix_text$Text_fix_time_pct = replace(fix_text$Text_fix_time_pct,
                                       is.na(fix_text$Text_fix_time_pct), 0)
  fix_text = select(fix_text, -c(total_time))
  fix_text$Trial = as.character(fix_text$Trial)
  return(fix_text)
}

check_fsb_counts = function(fsb_counts){
  #' Fix the trial number of fixation, saccade and blink counts. Check if we have all 
  #' required variables in the dataset. Ingore all the unnecessary variables. Rename all 
  #' the variables.
  #' 
  #' The required variables are:
  #'  -Trial
  #'  -Stimulus
  #'  -Participant
  #'  -Fixation Count Total
  #'  -Fixation Durating
  #'  -Saccade Count
  #'  -Saccade Duration Total
  #'  -Saccade Amplitude Total
  #'  -Saccade Velocity Total
  #'  -Blink Count
  #'  
  #' @param fsb_counts: the dataframe to be checked
  #'  
  #' @return fsb_counts: the checked dataframe
  
  # fix the trial number
  fsb_counts = trial_num_fix(fsb_counts)
  # check if we have all the variables needed
  # raise error if we miss any
  # ingore all the unnecessary variables
  fsb_counts = tryCatch(select(fsb_counts, c("Trial", "Stimulus",
                                             "Participant", "Fixation.Count",
                                             "Fixation.Duration.Total..ms.", "Saccade.Count",
                                             "Saccade.Duration.Total..ms.", "Saccade.Amplitude.Total....",
                                             "Saccade.Velocity.Total....s.", "Blink.Count")),
                        error = function(x) print("[ERROR] Column missing in Fixations, saccades, and blink counts"))
  # rename all the variables
  names(fsb_counts) = c("Trial", "Stimulus", "Participant", "Fix_count",
                        "Total_fix_dur", "Saccade_count", "Total_saccade_dur",
                        "Total_saccade_amp", "Total_saccade_velocity",
                        "Blink_count")
  return(fsb_counts)
}

proc_fsb_counts = function(fsb_counts){
  #' Process the fixation, saccade and blink counts dataframe. Aggregate the variabkles
  #' over trial, stimulus and participant.
  #' 
  #' @param fsb_counts: the dataframe to be processed
  #' 
  #' @return fsb_counts: the processed dataframe
  
  fsb_counts = fsb_counts %>%
                  group_by(Trial, Stimulus, Participant) %>%
                  summarise(Fix_count = sum(Fix_count),
                            Total_fix_dur = sum(Total_fix_dur),
                            Saccade_count = sum(Saccade_count),
                            Total_saccade_dur = sum(Total_saccade_dur),
                            Total_saccade_amp = sum(Total_saccade_amp),
                            Total_saccade_velocity = sum(Total_saccade_velocity),
                            Blink_count = sum(Blink_count))
  fsb_counts$Trial = as.character(fsb_counts$Trial)
  return(fsb_counts)
}

check_trial_dur = function(trial_dur){
  #' Fix the trial number of trial duration. Check if we have all the required variables.
  #' Ignore all the unnecessary variables. Rename all the variables.
  #' 
  #' The required variables are:
  #'  -Stimulus
  #'  -Trial Duration 
  #'  -Participant
  #'  -Tracking Ratio
  #'  
  #' @param trial_dur: the dataframe to be checked
  #' 
  #' @return trial_dur: the checked dataframe
  #' 
  
  trial_dur = tryCatch(select(trial_dur, c("Stimulus",  "Trial.Duration..ms.",
                                           "Participant","Tracking.Ratio....")),
                       error = function(x) print("[ERROR] Column missing in trial duratuion"))
  names(trial_dur) = c("Stimulus", "Trial_dur", "Participant", "Tracking_ratio")
  return(trial_dur)
}

proc_trial_dur = function(trial_dur){
  #' Process the trial duration dataframe. Trial duration is sumed over the same participant
  #' and stimulus. The tracking ratio is weighted averaged (based on the trial duration) 
  #' over the same participant and stimulus.
  #' 
  #' @param trial_dur: the dataframe to be processed
  #' 
  #' @return trial_dur: the processed dataframe
  
  dup_index = anyDuplicated(select(trial_dur, c(Stimulus, Participant)))
  
  # aggregate the variables 
  # tracking ratio is weighted averaged. The weight is trial duration
  # continue the process as long as we have any duplicated stimulus and participant
  while (dup_index != 0) {
    df = data_frame(Stimulus = trial_dur$Stimulus[dup_index],
                    Trial_dur = sum(trial_dur$Trial_dur[(dup_index - 1):dup_index]),
                    Participant = trial_dur$Participant[dup_index],
                    Tracking_ratio = trial_dur$Tracking_ratio[dup_index - 1] *
                      (trial_dur$Trial_dur[dup_index - 1] /
                         sum(trial_dur$Trial_dur[(dup_index - 1):dup_index])) +
                       trial_dur$Tracking_ratio[dup_index] *
                      (trial_dur$Trial_dur[dup_index] /
                         sum(trial_dur$Trial_dur[(dup_index - 1):dup_index])))

   if (dup_index == 2) {
     trial_dur = rbind(df, trial_dur[3:nrow(trial_dur),])
   } else if (dup_index == nrow(trial_dur)) {
     trial_dur = rbind(trial_dur[1:(dup_index - 2),])
   } else {
     trial_dur = rbind(trial_dur[1:(dup_index - 2),],
                       df, trial_dur[(dup_index + 1):nrow(trial_dur),])
   }

    dup_index = anyDuplicated(select(trial_dur, c(Stimulus, Participant)))
  }

  return(trial_dur)
}

trial_num_fix = function(data){
  #' fix the trial number for any dataset. The idea is the number of stimulus 
  #' and trial number should be same. Find a participant who has correct trial 
  #' number and stimulus. Replace all the incorrect trial numbers based on the 
  #' correct one-to-one map we found.
  #' 
  #' @param data: the dataframed to be fixed
  #' 
  #' @return data: the fixed dataframe

  # get a unique participant list
  participant_list = levels(data$Participant)
  # loop through all the participants and find the first one
  # with correct trial number and stimulus
  for (par in participant_list) {
    p_data = filter(data, Participant == par)
    if (length(unique(p_data$Trial)) == length(unique(p_data$Stimulus))) {
      ts_df = as.character(p_data$Trial)
      names(ts_df) = p_data$Stimulus
      break
    }
  }

  # fix all the trial numbers based on the correct one we found
  data$Trial = sapply(as.character(data$Stimulus), function(x) ts_df[[x]])

  return(data)
}

condition_extract = function(data){
  #' Extract the page condition based on the stimulus
  #' The condition we have are standard, image, text, 
  #' partially and clean. Raise error if unknown condition
  #' found.
  #' 
  #' @param data: the dataframe 
  #' 
  #' @return con: a list of condition extract from data
  
  con = data$Stimulus
  con = ifelse(grepl("standard", con), "standard",
               ifelse(grepl("image", con), "image",
               ifelse(grepl("text", con), "text",
               ifelse(grepl("partially", con), "partial",
               ifelse(grepl("clean", con), "clean", "NA")))))
  if (any(is.na(con))) {
    stop("[ERROR] Unknown condition detected.")
  }
  return(con)
}


