## Week 4 quiz for getting and cleaning data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/week4_quiz")

## Question #1
if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./data/acs.csv")
acs_data<-read.csv("./data/acs.csv")
names(acs_data)
splitNames = strsplit(names(acs_data),"wgtp") ## split on period
splitNames[[123]]
## answer = "" "15"

## Question #2
## load data
if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="./data/gdp.csv")
gdp_data<-read.csv("./data/gdp.csv", skip=3,header = TRUE)
## clean up data set
library(dplyr)
colnames(gdp_data)
gdp2<-select(gdp_data, X, Ranking, Economy, US.dollars.)
gdp2=gdp2[-1,]
gdp2=gdp2[1:190,]
names(gdp2)[names(gdp2)=="X"] <- "Country"
names(gdp2)[names(gdp2)=="US.dollars."] <- "US.dollars"
gdp2$Ranking<-as.numeric(as.character(gdp2$Ranking))
## remove commas
gdp3<-gdp2$US.dollars ## pull out column data
final_answer<-gsub(",","",gdp2$US.dollars) ## replaces all commas with no space ""
final_answer<-as.numeric(final_answer)
final_answer_mean<-mean(final_answer)
final_answer_mean
##answer = 377652.4

## Question #3
countryNames<-gdp2$Economy
grep("^United", countryNames) ## =3
grep("United$", countryNames) ## = 0
grep("^United", countryNames) ## = 3 This is the answer
grep("*United", countryNames)

## Question #4
## load first dataset
if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="./data/gdp.csv")
gdp_data<-read.csv("./data/gdp.csv", skip=3,header = TRUE)
## clean up first data set
library(dplyr)
colnames(gdp_data)
gdp2<-select(gdp_data, X, Ranking, Economy, US.dollars.)
gdp2=gdp2[-1,]
gdp2=gdp2[1:190,]
names(gdp2)[names(gdp2)=="X"] <- "Country"
names(gdp2)[names(gdp2)=="US.dollars."] <- "US.dollars"
gdp2$Ranking<-as.numeric(as.character(gdp2$Ranking))
## load second data set
if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile="./data/ed_data.csv")
ed_data<-read.csv("./data/ed_data.csv", header = TRUE)
## merge data for both data frames
intersect(names(gdp2), names(ed_data)) ## no common column names
mergeData=merge(gdp2,ed_data,by.x="Country",by.y="CountryCode", all=TRUE)
## mergeData2<-arrange(mergeData, desc(Ranking)) not needed

## now grep for those where June is end of fiscal calendar
grep("[Ff]iscal (.*) [Jj]une", mergeData$Special.Notes)
## answer = 13
##check by
answer<-grep("[Ff]iscal (.*) [Jj]une", mergeData$Special.Notes)
mergeData$Special.Notes[answer] ## shows the text 

## Question #5
install.packages("quantmod")
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
table(year(sampleTimes), wday(sampleTimes))
## answer to part #1 = 250
table(year(sampleTimes))
## answer to part #2 = 47
table(year(sampleTimes), wday(sampleTimes))







