## Written by Bruce Walthers
## October 15th, 2014
## Test of titanic Kaggle Data


## Read in the data

train <- read.csv("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/train.csv")
test <- read.csv("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/test.csv")


## write data to columns to update based on strategy
test$Survived<-0
test$Survived[test$Sex=='female'] <- 1



## Writing to the submit dataset
submit<-data.frame(PassengerId=test$PassengerId, Survived=test$Survived)
write.csv(submit, file="theyallperish.csv", row.names=FALSE)

## change column from Factor to character, modify it as character
## and then change it back to a factor
combi$Name<-as.character(combi$Name)
combi$Name[1]
strsplit(combi$Name[1], split='[,.')
strsplit(combi$Name[1], split='[,.]')
strsplit(combi$Name[1], split='[,.]')[[1]]
strsplit(combi$Name[1], split='[,.]')[[1]][2]
combi$Title<-sapply(combi$Name, FUN=function(x) (strsplit(x,split='[,.]')[[1]][2]))
View(combi)
combi$Title<-sub(' ','',combi$Title)
View(combi)
table(combi$Title)
combi$Title[combi$Title %in% c('Mme', 'Mlle')]<-'Mlle'
combi$Title[combi$Title %in% c('Capt','Don','Major','Sir')]<-'Sir'
combi$Title[combi$Title %in% c('Dona','Lady','the Countess','Jonkheer')]<-'Lady'
combi$Title<-factor(combi$Title)



## Open rpart library
library(rpart)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")


## striping out title from dataset
combi$Title<-sapply(combi$Name, FUN=function(x) (strsplit(x,split='[,.]')[[1]][2]))
