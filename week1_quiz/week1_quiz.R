## Week 1 quiz for getting and cleaning data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/week1_quiz")
library(dplyr)



## question #1
if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./data/acs2.csv")
acs_data<-read.csv("./data/acs2.csv")
acs<-tbl_df(acs_data)

q1_answer<-acs %>%
        select(ST, VAL) %>%
        filter(ST == 16, VAL == 24)

## answer = 53  


## Question #2
## answer = Tidy data has one variable per column. 

## Questions #3
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
xls_data <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx",sheetIndex=1, colIndex=colIndex,rowIndex=rowIndex)
head(xls_data)
dat<-xls_data
## run this command sum(dat$Zip*dat$Ext,na.rm=T) 
## output = 36534720


## Question #4
## Reading XML data
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl,destfile="restaurant.XML")
doc<-xmlTreeParse("restaurant.XML",useInternal=TRUE)
tally(group-by(newzip, newzip))
##  answer is 127

## Question #5
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,destfile="acs.csv")
DT<-fread("acs.csv")


mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
sapply(split(DT$pwgtp15,DT$SEX),mean)
tapply(DT$pwgtp15,DT$SEX,mean)
DT[,mean(pwgtp15),by=SEX] ## this is the fastest as it does not need $ for column names
mean(DT$pwgtp15,by=DT$SEX)
