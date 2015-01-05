## Week 3 quiz for getting and cleaning data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/week3_quiz")

## Question #1
## 

if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./data/acs2.csv")
acs_data<-read.csv("./data/acs2.csv")

## subset vector to 
agricultureLogical<-((acs_data$ACR %in% c("3") & acs_data$AGS %in% c("6")))
which(agricultureLogical)
## answer = 125, 238, 262

## question #2    
install.packages("jpeg")
library(jpeg)
if(!file.exists("./data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl,destfile="./data/jeff.jpg", mode="wb")
jeffjpg<-readJPEG("./data/jeff.jpg", native = TRUE)
quantile(jeffjpg, probs=c(0.3, 0.8))
## answer == 30% = -15259150, 80% = -10575416

## Question 3
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
mergeData2<-arrange(mergeData, desc(Ranking))
## answer 189, St. Kitts and Nevis

## Question #4
q4<-select(mergeData2, Ranking, Income.Group)
q4_2<-filter(q4, Income.Group=="High income: OECD")
mean(q4_2$Ranking)
## answer 32.96667

q4<-select(mergeData2, Ranking, Income.Group)
q4_3<-filter(q4, Income.Group=="High income: nonOECD")
mean(q4_3$Ranking, na.rm=TRUE)
## answer 91.91304

## Question #5
library(Hmisc)
mergeData2$Rankcut=cut2(mergeData2$Ranking,g=5) ## determines quantiles for me
table(mergeData2$Rankcut,mergeData2$Income.Group)
## answer = 5

