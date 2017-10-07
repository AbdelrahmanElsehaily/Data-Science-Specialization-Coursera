library("reshape2")

#reading train dataset
x_train<-read.table("./project/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./project/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./project/UCI HAR Dataset/train/subject_train.txt")

#reading test dataset
x_test<-read.table("./project/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./project/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./project/UCI HAR Dataset/test/subject_test.txt")

#combining data together
xdata<-rbind(x_train,x_test)
ydata<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)

#readin and extracting the required features 
features<-read.table("./project/UCI HAR Dataset/features.txt")
activity_labels<-read.table("./project/UCI HAR Dataset/activity_labels.txt")

#getting mean and std measurements only
colnames(xdata)<-features$V2
xdata<-xdata[,grep("mean|Mean|std|Std",names(xdata))]

#adding subject and activity to overall data set
colnames(subject)<-"subject"
colnames(ydata)<-"activity"
all_data<-cbind(xdata,subject,ydata)
#naming the activities in the data set with descriptive activity names
all_data$activity<-factor(all_data$activity,levels=activity_labels[,1],labels=activity_labels[,2])

#reshaping the data to get mean by subject and activity
all_data<-melt(all_data, id = c("subject","activity"))
result<- dcast(all_data, subject+activity ~ variable, mean)

#writing tidy data
write.table(all_data, "tidy.txt")

