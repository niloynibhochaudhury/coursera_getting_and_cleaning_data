## Week 3 notes on Getting and Cleaning Data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data")


## Subsetting and sorting
set.seed(13435)
X<-data.frame("var1"=sample(1:5),"var2"=sample(6:10), "var3"=sample(11:15))
X<-X[sample(1:5),];X$var2[c(1,3)]=NA
X

X[,1] ## subset column 1
X[,"var1"] ## subset with variable name
X[1:2,"var2"] ## subsetting on rows and columns at same time
X[(X$var1<=3 & X$var3>11),] ## subsetting rows with multiple conditions using and
X[(X$var1<=3 | X$var3>15),] ## again subsetting rows with multiple conditions this tiime with "or"
X[which(X$var2>8),] ## use the which command to deal with NA values returns and indices without NA's
sort(X$var1) ## sort increase is default
sort(X$var1, decreasing=T) ## sort decreasing
sort(X$var2, na.last=T) ## sort with NA's show as last
X[order(X$var1),] ## order variable 1 and pass to subset
X[order(X$var1,X$var3),] ## order vars with multiple columns
library(dplyr)
arrange(X,var1) ## doing the same as line 17
arrange(X,desc(var1)) ## sorting decending
X$var4<-rnorm(5) ## adding column to data frame
Y<-cbind(X,rnorm(5)) ## adding column same as #22
Y<-cbind(rnorm(5), X) ## adding column to front of data.frame

## Summarizing data
## look for problems in the data
if(!file.exists("./data")){dir.create(".data")}
fileUrl<-"https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
restData<-read.csv("./data/restaurants.csv")
## checking out the file
head(restData, n=3)
tail(restData, n=3)
colnames(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=T) ## look at variability is quantitative variables
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9)) ## look at different percentiles
table(restData$zipCode,useNA="ifany") ## make a table to see data.  Make sure you use "useNA="ifany" to see any NA's in data
table(restData$councilDistrict,restData$zipCode) ## shows 2 dimensional table
sum(is.na(restData$councilDistrict)) ## returns ## check for missing values
any(is.na(restData$CouncilDistrict)) ## returns True/False
all(restData$zipCode>0) ## check to see if any zipcodes are zero, turns out 1 is
colSums(is.na(restData)) ## check for NA's in all columns
all(colSums(is.na(restData))==0) ## checks that all columns have 0 NA's
table(restData$zipCode %in% c("21212")) ## check to see how many Zip codes =21212
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),] ## use logical var to subset dataset. Resturants in zipcodes
data(UCBAdmissions)
DF=as.data.frame(UCBAdmissions)
summary(DF) ## summary about dataset observed
xt<-xtabs(Freq~Gender+Admit, data=DF) ## create a cross tab table
data(warpbreaks)
warpbreaks$replicate<-rep(1:9, len=54)
xt=xtabs(breaks~.,data=warpbreaks)
xt
ftable(xt) ## create a flat table, summarized xtabs
fakeData=rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb") ## prints the size of an object


## Creating new variables
if(!file.exists("./data")){dir.create(".data")}
fileUrl<-"https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
restData<-read.csv("./data/restaurants.csv")
## creating sequences - used to index your dataset
s1<-seq(1,10,by=2); s1 ## by is to jump by 2
s2<-seq(1,10,length=3); s2 ## creates exactly length values
x<-c(1,3,8,25,100); seq(along=x) ## creates a vector of the same length but consequtive
restData$nearMe=restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe) ## creates restuarants near me variable
restData$zipWrong=ifelse(restData$zipCode<0,TRUE, FALSE) ## returns true if condition is true, false if condition is false
table(restData$zipWrong, restData$zipCode<0)
## making categorical variable form quantitative
restData$zipGroups=cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)
install.packages("Hmisc")
library(Hmisc) ## easier way to break things up by group
restData$zipGroups=cut2(restData$zipCode,g=4) ## determines quantiles for me
table(restData$zipGroups)
## creating factor variables
restData$zcf<-factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
yesno<-sample(c("yes","no"),size=10, replace=TRUE) ## create vector of yes and no
yesnofac=factor(yesno, levels=c("yes", "no")) ##turn into factor
relevel(yesnofac, ref="yes") ## treat "Yes" as the lowest value, reference class =yes
as.numeric(yesnofac) ## change factor back to integer
## cutting produces factor variables
Library(Hmisc)
restData$zipGroups=cut2(restData$zipCode,g=4)
table(restData$zipGroups)
class(restData$zipGroups)
library(Hmisc); library(plyr)
restData2=mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)
## common transformations
abx(x) absolute value
sqrt(x) take square root
ceiling(x) round value up to nearest integer
floor(x) round value up to nearest integer
round(x,digits=m) rounds to m digits
cos(x), sin(x) trig functions
log(x) natural logarithm ## commonly used for skews and outliers
log2(x),log10(x) other common logs ## commonly used for skews and outliers
exp(x) exponenting x

## reshaping data
## tidy data
## every variable its own column
## each obs has its own row
install.packages("reshape2")
library(reshape2)
head(mtcars)
## melting data set
mtcars$carname<-rownames(mtcars)
carMelt<-melt(mtcars,id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))
## tell which variables are ID variables vs measure variables
## reshaped so it is tall and skinny
head(carMelt, n=3)
tail(carMelt, n=3)
## recast data set
cylData<-dcast(carMelt, cyl~variable) ## show cylinders broken down by variables
cylData
cylData<-dcast(carMelt, cyl~variable, mean) ## show mean of variables
cylData
## average values within a factor
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum) ## average value within a factor, ## can use this function on my data for service cost forecasting
spIns=split(InsectSprays$count, InsectSprays$spray) ## split apply combine, creates a list of spray counts 
spIns
sprCount=lapply(spIns, sum)
sprCount
unlist(sprCount)
sapply(spIns,sum) ## combines apply and combine all in 1.  
ddply(InsectSprays,.(spray),summarize,sum=sum(count)) ## split apply combine
## creating a new variable
## subtract total count from each variable count
praySums<-ddply(InsectSprays,.(spray), summarize, sum=ave(count, FUN=sum))
dim(spraySums)
head(spraySums)
## other functions
acast ## for casting as multi-dimensional arrays
arrange ## for faster reordering without using (order) commands
mutate ## adding new variables

## Merging Data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews = read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
names(reviews)
names(solutions)
mergeData=merge(reviews,solutions,by.x="solution_id",by.y="id", all=TRUE) ## Merge data by telling which variables to merge on
head(mergeData)
intersect(names(solutions), names(reviews))
mergedData2=merge(reviews,solutions,all=TRUE) ## merge all common column names
head(mergedData2)
library(plyr);library(dplyr)
df1=data.frame(id=sample(1:10), x=rnorm(10))
df2=data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1,df2),id) ## arrange function good but less full featured compared to merge
## join will only merge on a common variable name
df1=data.frame(id=sample(1:10), x=rnorm(10))
df2=data.frame(id=sample(1:10), y=rnorm(10))
df3=data.frame(id=sample(1:10), z=rnorm(10))
dfList=list(df1,df2,df3)
join_all(dfList)

