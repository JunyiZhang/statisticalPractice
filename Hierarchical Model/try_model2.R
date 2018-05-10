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
# eye_id_diff = setdiff(eye_id, id)
# compre_id_diff = setdiff(compre_id, id)
# reading_id_diff = setdiff(reading_id, id)

data_compre = data_compre[!as.character(data_compre$id) %in% compre_id_diff, ]
data_eye = data_eye[!as.character(data_eye$id) %in% eye_id_diff, ]
data_reading = data_reading[!as.character(data_reading$id) %in% reading_id_diff, ]

data = merge(data_compre, data_eye, by = "id")
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


v1 = v1[, c("id", "version", "level", "layout", "E1_5", "E6_10", "Q1_3", "Q4_6", 
            "trial_dur", "text_fix_time", "image_fix_time", 
            "text_image", "text_ws","text_dash")]
v1$id = as.character(v1$id)
v1_ids = split(v1, v1$id)

v2 = v2[, c("id", "version","layout", "E1_5", "E6_10", "Q1_3", "Q4_6", 
            "trial_dur", "text_fix_time", "image_fix_time", 
            "text_image", "text_ws","text_dash")]
v2$id = as.character(v2$id)
v2_ids = split(v2, v2$id)

v3 = v3[, c("id", "version","layout", "E1_5", "E6_10", "Q1_3", "Q4_6", 
            "trial_dur", "text_fix_time", "image_fix_time", 
            "text_image", "text_ws","text_dash")]
v3$id = as.character(v3$id)
v3_ids = split(v3, v3$id)

v4 = v4[, c("id", "version","layout", "E1_5", "E6_10", "Q1_3", "Q4_6", 
            "trial_dur", "text_fix_time", "image_fix_time", 
            "text_image", "text_ws","text_dash")]
v4$id = as.character(v4$id)
v4_ids = split(v4, v4$id)

v5 = v5[, c("id", "version","layout", "E1_5", "E6_10", "Q1_3", "Q4_6", 
            "trial_dur", "text_fix_time", "image_fix_time", 
            "text_image", "text_ws","text_dash")]
v5$id = as.character(v5$id)
v5_ids = split(v5, v5$id)

v6 = v6[, c("id", "version","layout", "E1_5", "E6_10", "Q1_3", "Q4_6", 
            "trial_dur", "text_fix_time", "image_fix_time", 
            "text_image", "text_ws","text_dash")]
v6$id = as.character(v6$id)
v6_ids = split(v6, v6$id)


# function to reformat the data -- 2 lines of data per id
one_id = function(one, cond) {
  
  one_layouts = split(one, one$layout)
  
  one_standard = one_layouts$standard
  std_trial_dur = sum(one_standard$trial_dur, na.rm = TRUE)
  std_image_time = sum(one_standard$image_fix_time, na.rm = TRUE)
  std_text_time = sum(one_standard$text_fix_time, na.rm = TRUE)
  std_text_pct = std_text_time/std_trial_dur
  std_image_pct = std_image_time/std_trial_dur
  std_alternations = sum(one_other$text_ws, 
                         one_other$text_dash, na.rm = TRUE)
  
  one_other = one_layouts[[1]]
  cond_trial_dur = sum(one_other$trial_dur, na.rm = TRUE)
  cond_image_time = sum(one_other$image_fix_time, na.rm = TRUE)
  cond_text_time = sum(one_other$text_fix_time, na.rm = TRUE)
  cond_text_pct = cond_text_time/cond_trial_dur
  cond_image_pct = cond_image_time/cond_trial_dur
  cond_alternations = sum(one_other$text_ws, 
                          one_other$text_dash, na.rm = TRUE) 
  
  id = c(unique(one$id), unique(one$id))
  condition = c("standard", cond)
  Q = c(unique(one$Q1_3), unique(one$Q4_6))
  E = c(unique(one$E1_5), unique(one$E6_10))
  fix_text_pct = c(std_text_pct, cond_text_pct)
  fix_image_pct = c(std_image_pct, cond_image_pct)
  text_alternations = c(std_alternations, cond_alternations)
  
  level = as.character(one_layouts$standard$level)[1]
  
  one_new = as.data.frame(cbind(id, condition, level, Q, E, 
                                fix_text_pct, fix_image_pct, text_alternations))
  
  return(one_new)
  
}


id = ""
condition = ""
level = ""
Q = 0
E = 0
fix_text_pct = 0
fix_image_pct = 0
text_alternations = 0
v1_new = as.data.frame(cbind(id, condition, level, Q, E, 
                             fix_text_pct, fix_image_pct, text_alternations))
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
data_new$text_alternations = as.numeric(as.character(data_new$text_alternations))
data_new$level = as.character(data_new$level)

data_exp1 = rbind(v1_new, v2_new)
data_exp1$Q = as.numeric(as.character(data_exp1$Q))
data_exp1$E = as.numeric(as.character(data_exp1$E))
data_exp1$fix_text_pct = as.numeric(as.character(data_exp1$fix_text_pct))
data_exp1$fix_image_pct = as.numeric(as.character(data_exp1$fix_image_pct))
data_exp1$text_alternations = as.numeric(as.character(data_exp1$text_alternations))
data_exp1$level = as.character(data_exp1$level)


data_exp2 = rbind(v3_new, v4_new)
data_exp2$Q = as.numeric(as.character(data_exp2$Q))
data_exp2$E = as.numeric(as.character(data_exp2$E))
data_exp2$fix_text_pct = as.numeric(as.character(data_exp2$fix_text_pct))
data_exp2$fix_image_pct = as.numeric(as.character(data_exp2$fix_image_pct))
data_exp2$text_alternations = as.numeric(as.character(data_exp2$text_alternations))
data_exp2$level = as.character(data_exp2$level)


data_exp3 = rbind(v5_new, v6_new)
data_exp3$Q = as.numeric(as.character(data_exp3$Q))
data_exp3$E = as.numeric(as.character(data_exp3$E))
data_exp3$fix_text_pct = as.numeric(as.character(data_exp3$fix_text_pct))
data_exp3$fix_image_pct = as.numeric(as.character(data_exp3$fix_image_pct))
data_exp3$text_alternations = as.numeric(as.character(data_exp3$text_alternations))
data_exp3$level = as.character(data_exp3$level)




#######################################################################



if(!require("lme4")){
  install.packages("lme4")
  library("lme4")
}

if(!require("lmerTest")){
  install.packages("lmerTest")
  library("lmerTest")
}

# full model of Q w/ text_alternations = text->image
# variance = 0
md_Q1 = lmer(Q ~ relevel(condition, "standard") + as.factor(version) + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_new)
summary(md_Q1)

# reduced model of Q
# variance = 0
md_Q2 = lmer(Q ~ relevel(condition, "standard") + scale(fix_image_pct) + (1|id), data = data_new)
summary(md_Q2)

# full model of E w/ text_alternations = text->image
# variance = 0.27 (compared to estimate 2.24)
# only separated condition sig
md_E1 = lmer(E ~ relevel(condition, "standard") + as.factor(version) + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_new)
summary(md_E1)

# reduced model of E 
# variance 0.34 (compared to estimate 2.313)
# only separated condition sig
md_E2 = lmer(E ~ relevel(condition, "standard") + (1|id), data = data_new)
summary(md_E2)


# mediation # absolute image fix time
# separated text alternation 
# interaction

# Question control groups different, version different
# Events same version similar

md_E2 = lmer(fix_image_pct ~ relevel(condition, "standard") + (1|id), data = data_new)
summary(md_E2)


md_E3 = lmer(E ~scale(text_alternations) + (1|id), data = data_new)
summary(md_E3)

md_Q3 = lmer(Q ~scale(text_alternations) + (1|id), data = data_new)
summary(md_Q3)

# md_Q3 = lmer(Q ~scale(text_alternations) + (1|id), data = data_new) is sig
# when alternation = text-image

md_Q_exp1 = lmer(Q ~ relevel(condition, "standard") + as.factor(version) + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_exp1)
summary(md_Q_exp1)

md_Q_exp2 = lmer(Q ~ relevel(condition, "standard") + as.factor(version) + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_exp2)
summary(md_Q_exp2)

md_Q_exp3 = lmer(Q ~ relevel(condition, "standard") + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_exp3)
summary(md_Q_exp3)






md_E_exp1 = lmer(E ~ relevel(condition, "standard") + as.factor(version) + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_exp1)
summary(md_E_exp1)

md_E_exp2 = lmer(E ~ relevel(condition, "standard") + as.factor(version) + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_exp2)
summary(md_E_exp2)

md_E_exp3 = lmer(E ~ relevel(condition, "standard") + scale(fix_text_pct) + scale(fix_image_pct) + scale(text_alternations) + (1|id), data = data_exp3)
summary(md_E_exp3)


# mediation model using text_alternation with text_alternation = text -> ws + dash
# not sig
md_E_med_1 = lmer(E ~ scale(text_alternations) + (1|id), data = data_new)
summary(md_E_med_1)

# not sig
md_Q_med_1 = lmer(Q ~ scale(text_alternations) + (1|id), data = data_new)
summary(md_Q_med_1)



# mediation model w/ pca for E
pca_try = prcomp(data_exp2[, c(6, 7, 8)])
# mediation model w/ pca for E
# not sig
pca1 = as.data.frame(pca_try$x)$PC1
md_E_med_2 = lmer(E ~ scale(pca1) + (1|id), data = data_exp2)
summary(md_E_med_2)

# sig
md_med_E2 = lmer(pca1 ~ relevel(condition, "standard") + (1|id), data = data_new)
summary(md_med_E2)

# not sig
md_med_E_pca = lmer(E ~ scale(pca1) + relevel(condition, "standard") + (1|id), data = data_new)
summary(md_med_E_pca)








