## load in data
clean_datasets = list.files(pattern = "clean")
data_eye = NA
for(file in clean_datasets) {
  data_temp = read.csv(file)
  data_eye = rbind(data_eye, data_temp)
}
data_eye = data_eye[-1, ]

colnames(data_eye) = tolower(colnames(data_eye))
colnames(data_eye)[1] = "id"

data_compre = read.csv("compre_abv.csv")
data_reading = read.csv("reading_abv.csv")


## merge data
eye_id = unique(as.character(data_eye$id))
compre_id = unique(as.character(data_compre$id))
reading_id = unique(as.character(data_reading$id))

id = intersect(eye_id, compre_id)
id = intersect(id, reading_id)

data_compre = data_compre[!as.character(data_compre$id) %in% compre_id_diff, ]
data_eye = data_eye[!as.character(data_eye$id) %in% eye_id_diff, ]
data_reading = data_reading[!as.character(data_reading$id) %in% reading_id_diff, ]

data = merge(data_compre, data_eye, by = c("id", "version"))
data = merge(data, data_reading, by = "id")

data$trial = as.numeric(gsub("Trial", "", as.character(data$trial)))


## split the data by version
versions = split(data, data$version)

# version 1
v1 = versions[[1]]
v1$layout1 = "separated"
v1$layout1[v1$condition == "standard"] = "standard"
v1$layout2 = "separated"
v1$layout2[v1$trial %in% 1:4] = "standard"
all(v1$layout1 == v1$layout2) # check
v1$layout = v1$layout1

# version 2
v2 = versions[[2]]
v2$layout1 = "separated"
v2$layout1[v2$condition == "standard"] = "standard"
v2$layout2 = "separated"
v2$layout2[v2$trial %in% 9:12] = "standard"
all(v2$layout1 == v2$layout2) # check
v2$layout = v2$layout1

# version 3
v3 = versions[[3]]
v3$layout = "partial"
v3$layout[v3$trial %in% 1:4] = "standard"
all(v3$layout == v3$condition) # check

# version 4
v4 = versions[[4]]
v4$layout = "partial"
v4$layout[v4$trial %in% 5:8] = "standard"
all(v4$layout == v4$condition) # check

# version 5
v5 = versions[[5]]
v5$layout = "clean"
v5$layout[v5$trial %in% 1:3] = "standard"
all(v5$layout == v5$condition) # check

# version 6
v6 = versions[[6]]
v6$layout = "clean"
v6$layout[v6$trial %in% 4:6] = "standard"
all(v6$layout == v6$condition) # check

v1$id = as.character(v1$id)
v1_ids = split(v1, v1$id)

v2$id = as.character(v2$id)
v2_ids = split(v2, v2$id)

v3$id = as.character(v3$id)
v3_ids = split(v3, v3$id)

v4$id = as.character(v4$id)
v4_ids = split(v4, v4$id)

v5$id = as.character(v5$id)
v5_ids = split(v5, v5$id)

v6$id = as.character(v6$id)
v6_ids = split(v6, v6$id)


# function to reformat the data -- 2 lines of data per id
one_id = function(one, cond) {
  
  one_layouts = split(one, one$layout)

  one_standard = one_layouts$standard
  std_trial_dur = sum(one_standard$trial_dur, na.rm = TRUE)
  std_image_time = sum(one_standard$image_fix_time, na.rm = TRUE)
  std_text_time = sum(one_standard$text_fix_time, na.rm = TRUE)
  std_blank_time = sum(one_standard$blank_fix_time, na.rm = TRUE)
  std_text_pct = std_text_time/std_trial_dur ##
  std_image_pct = std_image_time/std_trial_dur ##
  std_blank_pct = std_blank_time/std_trial_dur ##
  std_text_ct = sum(one_standard$text_fix_count, na.rm = TRUE) ##
  std_image_ct = sum(one_standard$image_fix_count, na.rm = TRUE) ##
  std_blank_ct = sum(one_standard$blank_fix_count, na.rm = TRUE) ##
  std_text_image = sum(one_standard$text_image, na.rm = TRUE) 
  std_text_ws = sum(one_standard$text_ws, na.rm = TRUE) 
  std_image_text = sum(one_standard$image_text, na.rm = TRUE) 
  std_image_ws = sum(one_standard$image_ws, na.rm = TRUE) 
  std_saccade_count = sum(one_standard$saccade_count, na.rm = TRUE)
  std_weighted_text_image = sum(one_standard$weighted_text_image, na.rm = TRUE)
  
  one_other = one_layouts[[1]]
  cond_trial_dur = sum(one_other$trial_dur, na.rm = TRUE)
  cond_image_time = sum(one_other$image_fix_time, na.rm = TRUE)
  cond_text_time = sum(one_other$text_fix_time, na.rm = TRUE)
  cond_blank_time = sum(one_other$blank_fix_time, na.rm = TRUE)
  cond_text_pct = cond_text_time/cond_trial_dur ##
  cond_image_pct = cond_image_time/cond_trial_dur ##
  cond_blank_pct = cond_blank_time/cond_trial_dur ##
  cond_text_ct = sum(one_other$text_fix_count, na.rm = TRUE) ##
  cond_image_ct = sum(one_other$image_fix_count, na.rm = TRUE) ##
  cond_blank_ct = sum(one_other$blank_fix_count, na.rm = TRUE) ##
  cond_text_image = sum(one_other$text_image, na.rm = TRUE) 
  cond_text_ws = sum(one_other$text_ws, na.rm = TRUE) 
  cond_image_text = sum(one_other$image_text, na.rm = TRUE) 
  cond_image_ws = sum(one_other$image_ws, na.rm = TRUE) 
  cond_saccade_count = sum(one_other$saccade_count, na.rm = TRUE)
  cond_weighted_text_image = sum(one_other$weighted_text_image, na.rm = TRUE)

  id = c(unique(one$id), unique(one$id))
  condition = c("standard", cond)
  Q = c(unique(one$Q1_3), unique(one$Q4_6))
  E = c(unique(one$E1_5), unique(one$E6_10))
  fix_text_pct = c(std_text_pct, cond_text_pct)
  fix_image_pct = c(std_image_pct, cond_image_pct)
  fix_blank_pct = c(std_blank_pct, cond_blank_pct)
  fix_text_ct = c(std_text_ct, cond_text_ct)
  fix_image_ct = c(std_image_ct, cond_image_ct)
  fix_blank_ct = c(std_blank_ct, cond_blank_ct)
  text_image = c(std_text_image, cond_text_image)
  text_ws = c(std_text_ws, cond_text_ws)
  image_text = c(std_image_text, cond_image_text)
  image_ws = c(std_image_ws, cond_image_ws)
  saccade_count = c(std_saccade_count, cond_saccade_count)
  weighted_text_image = c(std_weighted_text_image, cond_weighted_text_image)
  quarter = as.character(one_layouts$standard$quarter)[1]
  
  one_new = as.data.frame(cbind(id, condition, quarter, Q, E, 
                                fix_text_pct, fix_image_pct, fix_blank_pct,
                                fix_text_ct, fix_image_ct, fix_blank_ct,
                                text_image, text_ws, image_text, image_ws,
                                saccade_count, weighted_text_image))
  
  return(one_new)
  
}


id = ""
condition = ""
quarter = ""
Q = 0
E = 0
fix_text_pct = 0
fix_image_pct = 0
fix_blank_pct = 0
fix_text_ct = 0
fix_image_ct = 0
fix_blank_ct = 0
text_image = 0
text_ws = 0
image_text = 0 
image_ws = 0
saccade_count = 0
weighted_text_image = 0

v1_new = as.data.frame(cbind(id, condition, quarter, Q, E,
                             fix_text_pct, fix_image_pct, fix_blank_pct,
                             fix_text_ct, fix_image_ct, fix_blank_ct,
                             text_image, text_ws, image_text, image_ws,
                             saccade_count,
                             weighted_text_image))
v2_new = v1_new
v3_new = v1_new
v4_new = v1_new
v5_new = v1_new
v6_new = v1_new

for(i in v1_ids){
  v1_new = rbind(v1_new, one_id(i, "separated"))
}
v1_new = v1_new[-1, ]

for(i in v2_ids){
  v2_new = rbind(v2_new, one_id(i, "separated"))
}
v2_new = v2_new[-1, ]

for(i in v3_ids){
  v3_new = rbind(v3_new, one_id(i, "partial"))
}
v3_new = v3_new[-1, ]

for(i in v4_ids){
  v4_new = rbind(v4_new, one_id(i, "partial"))
}
v4_new = v4_new[-1, ]

for(i in v5_ids){
  v5_new = rbind(v5_new, one_id(i, "clean"))
}
v5_new = v5_new[-1, ]

for(i in v6_ids){
  v6_new = rbind(v6_new, one_id(i, "clean"))
}
v6_new = v6_new[-1, ]


v1_new$version = 1
v2_new$version = 2
v3_new$version = 1
v4_new$version = 2
v5_new$version = 1
v6_new$version = 2


# combine all versions and separated by experiments
data_new = rbind(v1_new, v2_new, v3_new, v4_new, v5_new, v6_new)
data_new$Q = as.numeric(as.character(data_new$Q))
data_new$E = as.numeric(as.character(data_new$E))
data_new$fix_text_pct = as.numeric(as.character(data_new$fix_text_pct))
data_new$fix_image_pct = as.numeric(as.character(data_new$fix_image_pct))
data_new$fix_blank_pct = as.numeric(as.character(data_new$fix_blank_pct))
data_new$fix_text_ct = as.numeric(as.character(data_new$fix_text_ct))
data_new$fix_image_ct = as.numeric(as.character(data_new$fix_image_ct))
data_new$fix_blank_ct = as.numeric(as.character(data_new$fix_blank_ct))
data_new$text_image = as.numeric(as.character(data_new$text_image))
data_new$text_ws = as.numeric(as.character(data_new$text_ws))
data_new$image_text = as.numeric(as.character(data_new$image_text))
data_new$image_ws = as.numeric(as.character(data_new$image_ws))
data_new$saccade_count = as.numeric(as.character(data_new$saccade_count))
data_new$weighted_text_image = as.numeric(as.character(data_new$weighted_text_image))

data_exp1 = rbind(v1_new, v2_new)
data_exp1$Q = as.numeric(as.character(data_exp1$Q))
data_exp1$E = as.numeric(as.character(data_exp1$E))
data_exp1$fix_text_pct = as.numeric(as.character(data_exp1$fix_text_pct))
data_exp1$fix_image_pct = as.numeric(as.character(data_exp1$fix_image_pct))
data_exp1$fix_blank_pct = as.numeric(as.character(data_exp1$fix_blank_pct))
data_exp1$fix_text_ct = as.numeric(as.character(data_exp1$fix_text_ct))
data_exp1$fix_image_ct = as.numeric(as.character(data_exp1$fix_image_ct))
data_exp1$fix_blank_ct = as.numeric(as.character(data_exp1$fix_blank_ct))
data_exp1$text_image = as.numeric(as.character(data_exp1$text_image))
data_exp1$text_ws = as.numeric(as.character(data_exp1$text_ws))
data_exp1$image_text = as.numeric(as.character(data_exp1$image_text))
data_exp1$image_ws = as.numeric(as.character(data_exp1$image_ws))
data_exp1$saccade_count = as.numeric(as.character(data_exp1$saccade_count))
data_exp1$weighted_text_image = as.numeric(as.character(data_exp1$weighted_text_image))


data_exp2 = rbind(v3_new, v4_new)
data_exp2$Q = as.numeric(as.character(data_exp2$Q))
data_exp2$E = as.numeric(as.character(data_exp2$E))
data_exp2$fix_text_pct = as.numeric(as.character(data_exp2$fix_text_pct))
data_exp2$fix_image_pct = as.numeric(as.character(data_exp2$fix_image_pct))
data_exp2$fix_blank_pct = as.numeric(as.character(data_exp2$fix_blank_pct))
data_exp2$fix_text_ct = as.numeric(as.character(data_exp2$fix_text_ct))
data_exp2$fix_image_ct = as.numeric(as.character(data_exp2$fix_image_ct))
data_exp2$fix_blank_ct = as.numeric(as.character(data_exp2$fix_blank_ct))
data_exp2$text_image = as.numeric(as.character(data_exp2$text_image))
data_exp2$text_ws = as.numeric(as.character(data_exp2$text_ws))
data_exp2$image_text = as.numeric(as.character(data_exp2$image_text))
data_exp2$image_ws = as.numeric(as.character(data_exp2$image_ws))
data_exp2$saccade_count = as.numeric(as.character(data_exp2$saccade_count))
data_exp2$weighted_text_image = as.numeric(as.character(data_exp2$weighted_text_image))

data_exp3 = rbind(v5_new, v6_new)
data_exp3$Q = as.numeric(as.character(data_exp3$Q))
data_exp3$E = as.numeric(as.character(data_exp3$E))
data_exp3$fix_text_pct = as.numeric(as.character(data_exp3$fix_text_pct))
data_exp3$fix_image_pct = as.numeric(as.character(data_exp3$fix_image_pct))
data_exp3$fix_blank_pct = as.numeric(as.character(data_exp3$fix_blank_pct))
data_exp3$fix_text_ct = as.numeric(as.character(data_exp3$fix_text_ct))
data_exp3$fix_image_ct = as.numeric(as.character(data_exp3$fix_image_ct))
data_exp3$fix_blank_ct = as.numeric(as.character(data_exp3$fix_blank_ct))
data_exp3$text_image = as.numeric(as.character(data_exp3$text_image))
data_exp3$text_ws = as.numeric(as.character(data_exp3$text_ws))
data_exp3$image_text = as.numeric(as.character(data_exp3$image_text))
data_exp3$image_ws = as.numeric(as.character(data_exp3$image_ws))
data_exp3$saccade_count = as.numeric(as.character(data_exp3$saccade_count))
data_exp3$weighted_text_image = as.numeric(as.character(data_exp3$weighted_text_image))


## correlation plot
data_cor = data_new[, 4:17]
cor(data_cor)
if(!require("corrplot")){
  install.packages("corrplot")
  library("corrplot")
}
corrplot(cor(data_cor), method = "circle", type = "upper")

# save(data_new, file = "model_data.RData")

#######################################################################
# model part

if(!require("lme4")){
  install.packages("lme4")
  library("lme4")
}

if(!require("lmerTest")){
  install.packages("lmerTest")
  library("lmerTest")
}



# initial modeling (check version, quarter)
# quarter is sig, version is not
md_E11 = lmer(E ~ quarter + version + condition + scale(image_ws) + (1|id), data_new)
summary(md_E11) 
BIC(md_E11) # 677
md_E12 = lm(E ~ quarter + version + condition + scale(image_ws), data = data_new)
summary(md_E12) 
BIC(md_E12) # 662

md_Q111 = lmer(Q ~ quarter + version + condition + scale(image_ws) + (1|id), data = data_exp1)
summary(md_Q111)
BIC(md_Q111) # 266
md_Q112 = lm(Q ~ quarter + version + condition + scale(image_ws), data = data_exp1)
summary(md_Q112)
BIC(md_Q112) # 258

md_Q211 = lmer(Q ~ quarter + version + condition + scale(image_ws) + (1|id), data = data_exp2)
summary(md_Q211)
BIC(md_Q211) # 245
md_Q212 = lm(Q ~ quarter + version + condition + scale(image_ws), data = data_exp2)
summary(md_Q212)
BIC(md_Q212) # 235

md_Q311 = lmer(Q ~ quarter + version + condition + scale(image_ws) + (1|id), data = data_exp3)
summary(md_Q311)
BIC(md_Q311) # 268
md_Q312 = lm(Q ~ quarter + version + condition + scale(image_ws), data = data_exp3)
summary(md_Q312)
BIC(md_Q312) # 235










## using text_image as representative for eye-tracking data
# only focus on exp2 and exp3, b/c fully-separated condition don't have text_image alternation
# model exp2 and exp3 together
# E model
# hierarchical linear model for E ~ text_image 
md_E11 = lmer(E ~ scale(text_image) + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E11) # p = 0.07 -
BIC(md_E11) # 420
# Linear model for E ~ text_image (better)
md_E12 = lm(E ~ scale(text_image), data = rbind(data_exp2, data_exp3))
summary(md_E12) # p = 0.04 -
BIC(md_E12) # 412

# hierarchical linear model for text_image ~ cond (better)
md_E21 = lmer(text_image ~ relevel(condition, "standard") + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E21) # sig
BIC(md_E21) # 1188
# linear model for text_image ~ cond
md_E22 = lm(text_image ~ relevel(condition, "standard"), data = rbind(data_exp2, data_exp3))
summary(md_E22) # sig
BIC(md_E22) # 1202

# hierarchical linear model for E ~ cond
md_E1 = lmer(E ~ relevel(condition, "standard") + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E1) # not sig
BIC(md_E1) # 426
# linear model for E ~ cond (better)
md_E2 = lm(E ~ relevel(condition, "standard"), data = rbind(data_exp2, data_exp3))
summary(md_E2) # not sig
BIC(md_E2) # 419


# Q model
# model exp2 and exp3 separately
# Q exp2
# hierarchical linear model for Q2 ~ text_image 
md_Q211 = lmer(Q ~ scale(text_image) + (1|id), data = data_exp2)
summary(md_Q211) # p = 0.0193 -
BIC(md_Q211) # 265
# linear model for Q2 ~ text_image (better)
md_Q212 = lm(Q ~ scale(text_image), data = data_exp2)
summary(md_Q212) # p = 0.0193 -
BIC(md_Q212) # 258

# hierarchical linear model for text_image ~ cond (better)
md_Q221 = lmer(text_image ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q221) # sig -
BIC(md_Q221) # 635
# linear model for text_image ~ cond
md_Q222 = lm(text_image ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q222) # sig -
BIC(md_Q222) # 644

# hierarchical linear model for Q2 ~ cond
md_Q21 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q21) # sig
BIC(md_Q21) # 232
# linear model for Q2 ~ cond (better)
md_Q22 = lm(Q ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q22) # sig
BIC(md_Q22) # 225

# check mediation
md_Q2 = lm(Q ~ relevel(condition, "standard") + scale(text_image), data = data_exp2)
summary(md_Q2) # condition sig; text_image not sig

# Q exp3
# hierarchical linear model for Q3 ~ text_image
md_Q311 = lmer(Q ~ scale(text_image) + (1|id), data = data_exp3)
summary(md_Q311) # not sig
BIC(md_Q311) # 261
# linear model for Q3 ~ text_image (better)
md_Q312 = lm(Q ~ scale(text_image), data = data_exp3)
summary(md_Q312) # not sig
BIC(md_Q312) # 255

# hierarchical & normal linear model for text_image ~ cond (better)
md_Q321 = lmer(text_image ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q321) # sig
BIC(md_Q321) # 552
# linear model for text_image ~ cond
md_Q322 = lm(text_image ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q322) # sig
BIC(md_Q322) # 559

# hierarchical linear model for Q3 ~ cond 
md_Q31 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q31) # sig
BIC(md_Q31) # 255
# linear model for Q3 ~ cond (better)
md_Q32 = lm(Q ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q32) # sig
BIC(md_Q32) # 249



## using image_text as representative for eye-tracking data
# only focus on exp2 and exp3, b/c fully-separated condition don't have image_text alternation
# model exp2 and exp3 together
# E model
# hierarchical linear model for E ~ image_text 
md_E11 = lmer(E ~ scale(image_text) + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E11) # p = 0.0717 -
BIC(md_E11) # 420
# Linear model for E ~ image_text (better)
md_E12 = lm(E ~ scale(image_text), data = rbind(data_exp2, data_exp3))
summary(md_E12) # p = 0.0433 -
BIC(md_E12) # 412

# hierarchical linear model for image_text ~ cond (better)
md_E21 = lmer(image_text ~ relevel(condition, "standard") + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E21) # sig
BIC(md_E21) # 1188
# linear model for image_text ~ cond
md_E22 = lm(image_text ~ relevel(condition, "standard"), data = rbind(data_exp2, data_exp3))
summary(md_E22) # sig
BIC(md_E22) # 1196

# hierarchical linear model for E ~ cond
md_E1 = lmer(E ~ relevel(condition, "standard") + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E1) # not sig
BIC(md_E1) # 426
# linear model for E ~ cond (better)
md_E2 = lm(E ~ relevel(condition, "standard"), data = rbind(data_exp2, data_exp3))
summary(md_E2) # not sig
BIC(md_E2) # 419


# Q model
# model exp2 and exp3 separately
# Q exp2
# hierarchical linear model for Q2 ~ image_text 
md_Q211 = lmer(Q ~ scale(image_text) + (1|id), data = data_exp2)
summary(md_Q211) # p = 0.00825 -
BIC(md_Q211) # 264
# linear model for Q2 ~ image_text (better)
md_Q212 = lm(Q ~ scale(image_text), data = data_exp2)
summary(md_Q212) # p = 0.00825 -
BIC(md_Q212) # 256

# hierarchical linear model for image_text ~ cond (better)
md_Q221 = lmer(image_text ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q221) # sig -
BIC(md_Q221) # 634
# linear model for image_text ~ cond
md_Q222 = lm(image_text ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q222) # sig -
BIC(md_Q222) # 641

# hierarchical linear model for Q2 ~ cond
md_Q21 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q21) # sig
BIC(md_Q21) # 232
# linear model for Q2 ~ cond (better)
md_Q22 = lm(Q ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q22) # sig
BIC(md_Q22) # 225

# check mediation
md_Q2 = lm(Q ~ relevel(condition, "standard") + scale(image_text), data = data_exp2)
summary(md_Q2) # condition sig; image_text not sig

# Q exp3
# hierarchical linear model for Q3 ~ image_text
md_Q311 = lmer(Q ~ scale(image_text) + (1|id), data = data_exp3)
summary(md_Q311) # not sig
BIC(md_Q311) # 261
# linear model for Q3 ~ image_text (better)
md_Q312 = lm(Q ~ scale(image_text), data = data_exp3)
summary(md_Q312) # not sig
BIC(md_Q312) # 255

# hierarchical & normal linear model for image_text ~ cond (better)
md_Q321 = lmer(image_text ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q321) # sig
BIC(md_Q321) # 548
# linear model for image_text ~ cond
md_Q322 = lm(image_text ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q322) # sig
BIC(md_Q322) # 555

# hierarchical linear model for Q3 ~ cond 
md_Q31 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q31) # sig
BIC(md_Q31) # 255
# linear model for Q3 ~ cond (better)
md_Q32 = lm(Q ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q32) # sig
BIC(md_Q32) # 249














## using weighted text_image as representative for eye-tracking data
# only focus on exp2 and exp3, b/c fully-separated condition don't have text_image alternation
# model exp2 and exp3 together
# E model
# hierarchical linear model for E ~ text_image 
md_E11 = lmer(E ~ scale(weighted_text_image) + (1|id), rbind(data_exp2, data_exp3))
summary(md_E11) # p = 0.0758 -
BIC(md_E11) # 420
# Linear model for E ~ text_image (better)
md_E12 = lm(E ~ scale(weighted_text_image), data = rbind(data_exp2, data_exp3))
summary(md_E12) # p = 0.0397 -
BIC(md_E12) # 412

# hierarchical linear model for text_image ~ cond (better)
md_E21 = lmer(weighted_text_image ~ relevel(condition, "standard") + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E21) # sig
BIC(md_E21) # 1024
# linear model for text_image ~ cond
md_E22 = lm(weighted_text_image ~ relevel(condition, "standard"), data = rbind(data_exp2, data_exp3))
summary(md_E22) # sig
BIC(md_E22) # 1032

# hierarchical linear model for E ~ cond
md_E1 = lmer(E ~ relevel(condition, "standard") + (1|id), data = rbind(data_exp2, data_exp3))
summary(md_E1) # not sig
BIC(md_E1) # 426
# linear model for E ~ cond (better)
md_E2 = lm(E ~ relevel(condition, "standard"), data = rbind(data_exp2, data_exp3))
summary(md_E2) # not sig
BIC(md_E2) # 419


# Q model
# model exp2 and exp3 separately
# Q exp2
# hierarchical linear model for Q2 ~ text_image 
md_Q211 = lmer(Q ~ scale(weighted_text_image) + (1|id), data = data_exp2)
summary(md_Q211) # p = 0.0246 -
BIC(md_Q211) # 266
# linear model for Q2 ~ text_image (better)
md_Q212 = lm(Q ~ scale(weighted_text_image), data = data_exp2)
summary(md_Q212) # p = 0.0246 -
BIC(md_Q212) # 258

# hierarchical linear model for text_image ~ cond (better)
md_Q221 = lmer(weighted_text_image ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q221) # sig -
BIC(md_Q221) # 542
# linear model for text_image ~ cond
md_Q222 = lm(weighted_text_image ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q222) # sig -
BIC(md_Q222) # 548

# hierarchical linear model for Q2 ~ cond
md_Q21 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q21) # sig
BIC(md_Q21) # 232
# linear model for Q2 ~ cond (better)
md_Q22 = lm(Q ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q22) # sig
BIC(md_Q22) # 225

# check mediation
md_Q2 = lm(Q ~ relevel(condition, "standard") + scale(weighted_text_image), data = data_exp2)
summary(md_Q2) # condition sig; text_image not sig

# Q exp3
# hierarchical linear model for Q3 ~ text_image
md_Q311 = lmer(Q ~ scale(weighted_text_image) + (1|id), data = data_exp3)
summary(md_Q311) # not sig
BIC(md_Q311) # 262
# linear model for Q3 ~ text_image (better)
md_Q312 = lm(Q ~ scale(weighted_text_image), data = data_exp3)
summary(md_Q312) # not sig
BIC(md_Q312) # 255

# hierarchical & normal linear model for text_image ~ cond (better)
md_Q321 = lmer(weighted_text_image ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q321) # sig
BIC(md_Q321) # 486
# linear model for text_image ~ cond
md_Q322 = lm(weighted_text_image ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q322) # sig
BIC(md_Q322) # 489

# hierarchical linear model for Q3 ~ cond 
md_Q31 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q31) # sig
BIC(md_Q31) # 255
# linear model for Q3 ~ cond (better)
md_Q32 = lm(Q ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q32) # sig
BIC(md_Q32) # 249





##############################################################
# using image_ws as representative for eye-tracking data
# model exp1, exp2 and exp3 together
# E model
# hierarchical linear model for E ~ image_ws 
md_E11 = lmer(E ~ scale(image_ws) + (1|id), data_new)
summary(md_E11) # sig -
BIC(md_E11) # 650
# Linear model for E ~ image_ws (better)
md_E12 = lm(E ~ scale(image_ws), data = data_new)
summary(md_E12) # sig -
BIC(md_E12) # 641

# hierarchical linear model for image_ws ~ cond (better)
md_E21 = lmer(image_ws ~ relevel(condition, "standard") + (1|id), data = data_new)
summary(md_E21) # sig
BIC(md_E21) # 1915
# linear model for image_ws ~ cond
md_E22 = lm(image_ws ~ relevel(condition, "standard"), data = data_new)
summary(md_E22) # sig
BIC(md_E22) # 1931

# hierarchical linear model for E ~ cond
md_E1 = lmer(E ~ relevel(condition, "standard") + (1|id), data = data_new)
summary(md_E1) # seperated sig
BIC(md_E1) # 667
# linear model for E ~ cond (better)
md_E2 = lm(E ~ relevel(condition, "standard"), data = data_new)
summary(md_E2) # not sig
BIC(md_E2) # 661


# Q model
# model exp1, exp2 and exp3 separately
# Q exp1
# hierarchical linear model for Q1 ~ image_ws 
md_Q111 = lmer(Q ~ scale(image_ws) + (1|id), data = data_exp1)
summary(md_Q111) # p = 0.012 -
BIC(md_Q111) # 273
# linear model for Q1 ~ image_ws (better)
md_Q112 = lm(Q ~ scale(image_ws), data = data_exp1)
summary(md_Q112) # p = 0.012 -
BIC(md_Q112) # 266

# hierarchical linear model for image_ws ~ cond (better)
md_Q121 = lmer(image_ws ~ relevel(condition, "standard") + (1|id), data = data_exp1)
summary(md_Q121) # sig -
BIC(md_Q121) # 668
# linear model for image_ws ~ cond
md_Q122 = lm(image_ws ~ relevel(condition, "standard"), data = data_exp1)
summary(md_Q122) # sig -
BIC(md_Q122) # 674

# hierarchical linear model for Q1 ~ cond
md_Q11 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp1)
summary(md_Q11) # sig
BIC(md_Q11) # 259
# linear model for Q2 ~ cond (better)
md_Q12 = lm(Q ~ relevel(condition, "standard"), data = data_exp1)
summary(md_Q12) # sig
BIC(md_Q12) # 253

# check mediation
md_Q1 = lm(Q ~ relevel(condition, "standard") + scale(image_ws), data = data_exp1)
summary(md_Q1) # condition sig; image_ws not sig


# Q exp2
# hierarchical linear model for Q2 ~ image_ws 
md_Q211 = lmer(Q ~ scale(image_ws) + (1|id), data = data_exp2)
summary(md_Q211) # p = 0.0149 -
BIC(md_Q211) # 265
# linear model for Q2 ~ image_ws (better)
md_Q212 = lm(Q ~ scale(image_ws), data = data_exp2)
summary(md_Q212) # p = 0.0149 -
BIC(md_Q212) # 258

# hierarchical linear model for image_ws ~ cond (better)
md_Q221 = lmer(image_ws ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q221) # sig -
BIC(md_Q221) # 635
# linear model for image_ws ~ cond
md_Q222 = lm(image_ws ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q222) # sig -
BIC(md_Q222) # 644

# hierarchical linear model for Q2 ~ cond
md_Q21 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q21) # sig
BIC(md_Q21) # 232
# linear model for Q2 ~ cond (better)
md_Q22 = lm(Q ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q22) # sig
BIC(md_Q22) # 225

# check mediation
md_Q2 = lm(Q ~ relevel(condition, "standard") + scale(image_ws), data = data_exp2)
summary(md_Q2) # condition sig; image_ws not sig

# Q exp3
# hierarchical linear model for Q3 ~ image_ws
md_Q311 = lmer(Q ~ scale(image_ws) + (1|id), data = data_exp3)
summary(md_Q311) # not sig 0.199
BIC(md_Q311) # 261
# linear model for Q3 ~ image_ws (better)
md_Q312 = lm(Q ~ scale(image_ws), data = data_exp3)
summary(md_Q312) # not sig 0.199
BIC(md_Q312) # 254

# hierarchical & normal linear model for image_ws ~ cond (better)
md_Q321 = lmer(image_ws ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q321) # sig
BIC(md_Q321) # 589
# linear model for image_ws ~ cond
md_Q322 = lm(image_ws ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q322) # sig
BIC(md_Q322) # 595

# hierarchical linear model for Q3 ~ cond 
md_Q31 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q31) # sig
BIC(md_Q31) # 255
# linear model for Q3 ~ cond (better)
md_Q32 = lm(Q ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q32) # sig
BIC(md_Q32) # 249

# check mediation
md_Q3 = lm(Q ~ relevel(condition, "standard") + scale(image_ws), data = data_exp3)
summary(md_Q3) # condition sig; text_image not sig






# rescale and take average of text_image, image_text, image_ws, weighted_text_image
composite_data = rbind(data_exp2, data_exp3)
composite_data$composite_var = (as.numeric(scale(composite_data$text_image)) + as.numeric(scale(composite_data$image_text)) +
                   as.numeric(scale(composite_data$image_ws)) + as.numeric(scale(composite_data$weighted_text_image)))/4
data_exp2$composite_var = (as.numeric(scale(data_exp2$text_image)) + as.numeric(scale(data_exp2$image_text)) +
                                  as.numeric(scale(data_exp2$image_ws)) + as.numeric(scale(data_exp2$weighted_text_image)))/4
data_exp3$composite_var = (as.numeric(scale(data_exp3$text_image)) + as.numeric(scale(data_exp3$image_text)) +
                             as.numeric(scale(data_exp3$image_ws)) + as.numeric(scale(data_exp3$weighted_text_image)))/4



## using composite_var as representative for eye-tracking data
# only focus on exp2 and exp3, b/c fully-separated condition don't have text_image or image_text alternation
# model exp2 and exp3 together
# E model
# hierarchical linear model for E ~ composite_var 
md_E11 = lmer(E ~ scale(composite_var) + (1|id), composite_data)
summary(md_E11) # p = 0.0443 -
BIC(md_E11) # 420
# Linear model for E ~ composite_var (better)
md_E12 = lm(E ~ scale(composite_var), data = composite_data)
summary(md_E12) # p = 0.0228 -
BIC(md_E12) # 411

# hierarchical linear model for composite_var ~ cond 
md_E21 = lmer(composite_var ~ relevel(condition, "standard") + (1|id), data = composite_data)
summary(md_E21) # sig
BIC(md_E21) # 359
# linear model for composite_var ~ cond (better)
md_E22 = lm(composite_var ~ relevel(condition, "standard"), data = composite_data)
summary(md_E22) # sig
BIC(md_E22) # 353

# hierarchical linear model for E ~ cond
md_E1 = lmer(E ~ relevel(condition, "standard") + (1|id), data = composite_data)
summary(md_E1) # not sig
BIC(md_E1) # 426
# linear model for E ~ cond (better)
md_E2 = lm(E ~ relevel(condition, "standard"), data = composite_data)
summary(md_E2) # not sig
BIC(md_E2) # 419


# Q model
# model exp2 and exp3 separately
# Q exp2
# hierarchical linear model for Q2 ~ composite_var 
md_Q211 = lmer(Q ~ scale(composite_var) + (1|id), data = data_exp2)
summary(md_Q211) # p = 0.0131 -
BIC(md_Q211) # 265
# linear model for Q2 ~ composite_var (better)
md_Q212 = lm(Q ~ scale(composite_var), data = data_exp2)
summary(md_Q212) # p = 0.0131 -
BIC(md_Q212) # 257

# hierarchical linear model for composite_var ~ cond 
md_Q221 = lmer(composite_var ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q221) # sig -
BIC(md_Q221) # 190
# linear model for composite_var ~ cond (better)
md_Q222 = lm(composite_var ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q222) # sig -
BIC(md_Q222) # 184

# hierarchical linear model for Q2 ~ cond
md_Q21 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp2)
summary(md_Q21) # sig
BIC(md_Q21) # 232
# linear model for Q2 ~ cond (better)
md_Q22 = lm(Q ~ relevel(condition, "standard"), data = data_exp2)
summary(md_Q22) # sig
BIC(md_Q22) # 225

# check mediation
md_Q2 = lm(Q ~ relevel(condition, "standard") + scale(composite_var), data = data_exp2)
summary(md_Q2) # condition sig; composite_var not sig

# Q exp3
# hierarchical linear model for Q3 ~ composite_var
md_Q311 = lmer(Q ~ scale(composite_var) + (1|id), data = data_exp3)
summary(md_Q311) # not sig
BIC(md_Q311) # 261
# linear model for Q3 ~ composite_var (better)
md_Q312 = lm(Q ~ scale(composite_var), data = data_exp3)
summary(md_Q312) # not sig
BIC(md_Q312) # 254

# hierarchical & normal linear model for composite_var ~ cond 
md_Q321 = lmer(composite_var ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q321) # sig
BIC(md_Q321) # 180
# linear model for composite_var ~ cond (better)
md_Q322 = lm(composite_var ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q322) # sig
BIC(md_Q322) # 174 

# hierarchical linear model for Q3 ~ cond 
md_Q31 = lmer(Q ~ relevel(condition, "standard") + (1|id), data = data_exp3)
summary(md_Q31) # sig
BIC(md_Q31) # 255
# linear model for Q3 ~ cond (better)
md_Q32 = lm(Q ~ relevel(condition, "standard"), data = data_exp3)
summary(md_Q32) # sig
BIC(md_Q32) # 249

