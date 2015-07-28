library(data.table)

# Loading data from work directory 

X_test <- read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt", sep=""), quote="\"", comment.char="")
subject_test <- read.table(paste(getwd(),"/UCI HAR Dataset/test/subject_test.txt", sep=""), quote="\"", comment.char="")
y_test <- read.table(paste(getwd(),"/UCI HAR Dataset/test/y_test.txt", sep=""), quote="\"", comment.char="")

X_train <- read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt", sep=""), quote="\"", comment.char="")
subject_train <- read.table(paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt", sep=""), quote="\"", comment.char="")
y_train <- read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt", sep=""), quote="\"", comment.char="")

features <- read.table(paste(getwd(),"/UCI HAR Dataset/features.txt", sep=""), quote="\"", comment.char="")
activity_labels <- read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt", sep=""), quote="\"", comment.char="")

# creating data.tables

X_test <- data.table(X_test)
X_train <- data.table(X_train)

subject_train <- data.table(subject_train)
subject_test <- data.table(subject_test)

y_test <- data.table(y_test)
y_train <- data.table(y_train)

features <- data.table(features)
activity_labels <- data.table(activity_labels)

#merging test and training sets

X <- rbind(X_test, X_train)
Y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)


#extracting means and standard deviations

X_filtered <- X[,features[[2]] %like% "mean|Mean|std", with = FALSE]

setnames(X_filtered, as.character(features[features[[2]] %like% "mean|Mean|std"][[2]]))


#adding activity column from labels

X_filtered[,"Activity" := Y]

#adding subject column from subjects

X_filtered[, "Subject" := subject]
setkey(X_filtered, Activity, Subject)

#adding appropriate activity labels

X_filtered[, Activity := as.character(Activity)][Activity == 1, Activity := activity_labels[[2]][1]]
X_filtered[, Activity := as.character(Activity)][Activity == 2, Activity := activity_labels[[2]][2]]
X_filtered[, Activity := as.character(Activity)][Activity == 3, Activity := activity_labels[[2]][3]]
X_filtered[, Activity := as.character(Activity)][Activity == 4, Activity := activity_labels[[2]][4]]
X_filtered[, Activity := as.character(Activity)][Activity == 5, Activity := activity_labels[[2]][5]]
X_filtered[, Activity := as.character(Activity)][Activity == 6, Activity := activity_labels[[2]][6]]

#Aggregating averages

setkey(X_filtered, Activity, Subject)

tmp <- X_filtered[, lapply(.SD,mean), by=c("Activity", "Subject")]

write.table(tmp, "data.txt")
