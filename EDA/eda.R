library("xlsx")

data = read.xlsx("BehavioralData.xlsx", 1)
data = data[-1,]
data = data[-nrow(data),]
names(data)

# id
table(data$ID, exclude = NULL)
length(data$ID)

# age
summary(data$Age)
hist(data$Age)
# missing and 117.9

# date
summary(data$Date)

# DOT
summary(data$DOT)

# DOB
summary(data$DOB)

# seconds
summary(data$Seconds)
hist(data$Seconds)

# incorrect
summary(data$Incorrect)
hist(data$Incorrect)

# level 
table(data$Level)
