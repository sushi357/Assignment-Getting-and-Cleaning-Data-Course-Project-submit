#get data and corresponding activity data
#set dir to location of data files
dir<-getwd()

setwd(paste0(dir,"/UCI HAR Dataset/train"))

train<-read.table("X_train.txt")
train_act<-read.table("y_train.txt")
train_sub<-read.table("subject_train.txt")

setwd(paste0(dir,"/UCI HAR Dataset/test"))

test<-read.table("X_test.txt")
test_act<-read.table("y_test.txt")
test_sub<-read.table("subject_test.txt")

#get descriptive variable names of data
setwd(paste0(dir,"/UCI HAR Dataset"))

features<-read.table("features.txt")

#relabel data variable names with descriptive names
names(train)<-features[,2]
names(test)<-features[,2]

#rename activity data
names(train_act)<-"activity"
names(test_act)<-"activity"

#rename subject data
names(train_sub)<-"subject"
names(test_sub)<-"subject"

#combine train and test data with respective activity and subject data
train<-cbind(train,train_act,train_sub)
test<-cbind(test,test_act,test_sub)

#combine train and test datasets
combine<-rbind(train,test)


#get std and mean measurements
subL<-grepl("[Mm]ean|std|activity|subject",names(combine))

sub_combine<-combine[,subL]

#use descriptive labels for activity variable
sub_combine[,"activity"]<-as.factor(sub_combine[,"activity"])

levels(sub_combine[,"activity"])[levels(sub_combine[,"activity"])=="1"] <- "WALKING"
levels(sub_combine[,"activity"])[levels(sub_combine[,"activity"])=="2"] <- "WALKING_UPSTAIRS"
levels(sub_combine[,"activity"])[levels(sub_combine[,"activity"])=="3"] <- "WALKING_DOWNSTAIRS"
levels(sub_combine[,"activity"])[levels(sub_combine[,"activity"])=="4"] <- "SITTING"
levels(sub_combine[,"activity"])[levels(sub_combine[,"activity"])=="5"] <- "STANDING"
levels(sub_combine[,"activity"])[levels(sub_combine[,"activity"])=="6"] <- "LAYING"

#split data into groups by subject
df<-split(sub_combine,sub_combine[,"subject"])

#define list to fill with data frames - each list element is for 1 subject
data_list<-list()

#get average of each variable for each activity level. Loop over subjects
for(j in 1:length(df)) {
  
  df_walk<-subset(df[[j]],activity=="WALKING")
  mean_walk<-numeric()
  for(i in 1:86) {
    mean_walk[i]<-mean(df_walk[,i])
  }
  
  df_walk_up_stairs<-subset(df[[j]],activity=="WALKING_UPSTAIRS")
  mean_walk_up_stairs<-numeric()
  for(i in 1:86) {
    mean_walk_up_stairs[i]<-mean(df_walk_up_stairs[,i])
  }
  
  df_walk_down_stairs<-subset(df[[j]],activity=="WALKING_DOWNSTAIRS")
  mean_walk_down_stairs<-numeric()
  for(i in 1:86) {
    mean_walk_down_stairs[i]<-mean(df_walk_down_stairs[,i])
  }
  
  df_sitting<-subset(df[[j]],activity=="SITTING")
  mean_sitting<-numeric()
  for(i in 1:86) {
    mean_sitting[i]<-mean(df_sitting[,i])
  }
  
  df_standing<-subset(df[[j]],activity=="STANDING")
  mean_standing<-numeric()
  for(i in 1:86) {
    mean_standing[i]<-mean(df_standing[,i])
  }
  
  df_laying<-subset(df[[j]],activity=="LAYING")
  mean_laying<-numeric()
  for(i in 1:86) {
    mean_laying[i]<-mean(df_laying[,i])
  }
  
  #combine each vector of averages into 1 data frame
  df_format<-cbind(mean_walk,mean_walk_up_stairs,
                   mean_walk_down_stairs,mean_sitting,
                   mean_standing,mean_laying)
  
  #format data frame
  df_format<-t(df_format)
  
  df_format<-data.frame(df_format)
  
  rownames(df_format)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                         "SITTING","STANDING","LAYING")
  
  df_format[,87]<-rownames(df_format)
  
  df_format[,88]<-j
  
  names(df_format)<-names(sub_combine)
  
  #relabel variable name to include average descriptor
  for(i in 1:86) {
    names(df_format)[i]<-paste(names(df_format)[i],"average")
  }
  
  data_list[[j]]<-df_format
}


#combine each list entry into a single dataframe
df_ini<-data_list[[1]]

for(i in 2:length(data_list)) {
  df_next<-data_list[[i]]
  df_comb<-rbind(df_ini,df_next)
  df_ini<-df_comb
}

df_final<-df_comb

rownames(df_final)<-NULL

#re-order variables in data frame
df_final<-df_final[c(88,87,1:86)]

#write df_final to a table
setwd(dir)
write.table(df_final, file = "step_5_tidy.txt", row.names = FALSE)

#clear workspace
w_space<-ls()
w_space<-subset(w_space, !(w_space=="df_final"))
rm(list = w_space)




