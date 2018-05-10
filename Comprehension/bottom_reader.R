#' CMU MSP 36726 Project
#' Junyi Zhang
#'
#' April, 2018
#'
#' Create a dataframe consists of the bad reader in each trial 
#' and each condition. The bad reader is defined by the five  
#' participants with the lowest retelling score.


library(xlsx)
library(dplyr)
library(tidyr)
setwd("~/Desktop/36726 Statistical Practice/Project/data/behavioral data/")
# read in the behavioral data
data = read.xlsx("BehavioralData.xlsx", 2, startRow = 2)
data2 = read.xlsx("BehavioralData.xlsx", 4, startRow = 2)
# join them together
data = rbind(data, data2)

# divide them into retell questions and comprehension questions
data_retell = select(data, c(ID, Version, Events.1.5, X..out.of.5, Events.6.10, X..out.of.5.1, Total, Total..))
names(data_retell) = c("Participant", "Version", "Events_1_5", "pct_1_5", "Events_6_10", "pct_6_10", "total", "total_pct")
data_comprehension = select(data, c(ID, Version, Q1, Q2, Q3, 
                                    Points.out.of.7, X., Q4, Q5, Q6, Points.out.of.7.1,
                                    X..1, Total.1, Total...1))
names(data_comprehension) = c("Participant", "Version", "Q1", "Q2", "Q3", "pts_1_3", "pct_1_3", "Q4", "Q5", "Q6",
                              "pts_4_6", "pct_4_6", "total", "total_pct")

# find top performer in each condition based on story retelling
# standard
standard_version = data.frame(Version = c(1, 2, 3, 4, 5, 6),
                              Trial = I(list(1:4, 9:12, 1:4, 5:8, 1:3, 3:6)))
standard_retell_1 = data_retell %>%
                      filter(Version %in% c(1, 3, 5)) %>%
                      select(Participant, pct_1_5, Version)
names(standard_retell_1)[2] = "Pct"
standard_retell_2 = data_retell %>%
                      filter(Version %in% c(2, 4, 6)) %>%
                      select(Participant, pct_6_10, Version)
names(standard_retell_2)[2] = "Pct"
standard_retell = rbind(standard_retell_1, standard_retell_2)
bottom_standard = top_n(standard_retell, n = 5, wt = -Pct) %>%
                    arrange(by = Pct) %>%
                    left_join(standard_version, by = "Version") %>%
                    unnest(Trial) %>%
                    mutate(Cluster = "Standard") %>%
                    select(-c(Pct))

# seprated
separated_version = data.frame(Version = c(1, 2),
                               Trial = I(list(5:12, 1:8)))
separated_retell_1 = data_retell %>%
                        filter(Version == 1) %>%
                        select(Participant, pct_6_10, Version)
names(separated_retell_1)[2] = "Pct"
separated_retell_2 = data_retell %>%
                        filter(Version == 2) %>%
                        select(Participant, pct_1_5, Version)
names(separated_retell_2)[2] = "Pct"
separated_retell = rbind(separated_retell_1, separated_retell_2)
bottom_separated = top_n(separated_retell, n = 5, wt = -Pct) %>%
                    arrange(by = Pct) %>%
                    left_join(separated_version, by = "Version") %>%
                    unnest(Trial) %>%
                    mutate(Cluster = "Separated") %>%
                    select(-c(Pct))

# Partial
partial_version = data.frame(Version = c(3, 4),
                             Trial = I(list(5:8, 1:4)))
partial_retell_1 = data_retell %>%
                      filter(Version == 3) %>%
                      select(Participant, pct_6_10, Version)
names(partial_retell_1)[2] = "Pct"
partial_retell_2 = data_retell %>%
                      filter(Version == 4) %>%
                      select(Participant, pct_1_5, Version)
names(partial_retell_2)[2] = "Pct"
partial_retell = rbind(partial_retell_1, partial_retell_2)
bottom_partial = top_n(partial_retell, n = 5, wt = -Pct) %>%
                  arrange(by = Pct) %>%
                  left_join(partial_version, by = "Version") %>%
                  unnest(Trial) %>%
                  mutate(Cluster = "Partial") %>%
                  select(-c(Pct))

# Clean
clean_version = data.frame(Version = c(5, 6),
                           Trial = I(list(4:6, 1:3)))
clean_retell_1 = data_retell %>%
                    filter(Version == 5) %>%
                    select(Participant, pct_6_10, Version)
names(clean_retell_1)[2] = "Pct"
clean_retell_2 = data_retell %>%
                    filter(Version == 6) %>%
                    select(Participant, pct_1_5, Version)
names(clean_retell_2)[2] = "Pct"
clean_retell = rbind(clean_retell_1, clean_retell_2)
bottom_clean = top_n(clean_retell, n = 5, wt = -Pct) %>%
                arrange(by = Pct) %>%
                left_join(clean_version, by = "Version") %>%
                unnest(Trial) %>%
                mutate(Cluster = "Clean") %>%
                select(-c(Pct))

# join all the bottom reteller together
bottom_reteller = do.call(rbind, list(bottom_standard, bottom_separated, bottom_partial, bottom_clean))
write.csv(bottom_reteller, 
          file = "~/Desktop/36726 Statistical Practice/Project/data/Cluster/Top Retell/bottom_retller.csv",
          row.names = FALSE)
