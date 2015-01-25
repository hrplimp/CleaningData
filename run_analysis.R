

library(dplyr)


## Imports feature table (used as part of step 4)
features<-read.table("features.txt",stringsAsFactors=FALSE)
##adds two new rows for columns we will add below
newRow1<- c(562,"Activity_Type")
newRow2<- c(563,"Subject")
features<-rbind(features,newRow1)
features<-rbind(features,newRow2)
##features<-make.names(features, unique=TRUE)
colLabels<-features[,2]
colLabels<-make.names(colLabels, unique=TRUE)

##Step 1
##reads training data and adds columns for y and subject to end of df
subjTrain<-read.table("train/subject_train.txt")
xTrain<-read.table("train/x_train.txt")
yTrain<-read.table("train/y_train.txt")
dfTrain<-cbind(xTrain, yTrain, subjTrain)

##reads test data and adds columns for y and subject to end of df
subjTest<-read.table("test/subject_test.txt")
xTest<-read.table("test/x_test.txt")
yTest<-read.table("test/y_test.txt")
dfTest<-cbind(xTest, yTest, subjTest)

##combines the Training and Test dfs (end of step 1)
dfTotal<nm- rbind(dfTrain,dfTest)
##puts the column lables on the df ( end of step 4)
names(dfTotal)<-colLabels

##Selects only columns containins mean and stdev (Step2)
dfMeanStd<-select(dfTotal,contains("mean"), contains("std"),Activity_Type,Subject)


##adds activity names (step 3)
activity_names<-read.table("activity_labels.txt")
names(activity_names)<-c("num", "Activity_Name") 
dfMeanStd<-merge(dfMeanStd,activity_names,by.x="Activity_Type",by.y="num")

##Step 5 Summarize the data
df_sub_act <- dfMeanStd %>% group_by(Subject,Activity_Name)
dfTidy<- df_sub_act %>% summarise_each(funs(mean(., na.rm = TRUE)))

write.table(dfTidy, "dfTidy.txt",  row.name=FALSE)