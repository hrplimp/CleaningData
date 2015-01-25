fldrTrain<-/train/

subjTrain<-read.table("train/subject_train.txt")
xTrain<-read.table("train/x_train.txt")
yTrain<-read.table("train/y_train.txt")
dflist<-list(subjTrain, yTrain, xTrain)
dfTrain<- join_all(dflist)
'dfTrain<-data.frame(xTrain, yTrain)


subjTest<-read.table("test/subject_test.txt")
xTest<-read.table("test/x_test.txt")
yTest<-read.table("test/y_test.txt")

'dfTest<-data.frame(xTest, yTest)