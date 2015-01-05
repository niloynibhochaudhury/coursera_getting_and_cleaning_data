##  Getting and Cleaning Data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data")

## create a sub directory if it does not exist
if(!file.exists("data")){
        dir.create("data")
}

## download data from website
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
list.files("./data")

dateDownloaded <- date()
dateDownloaded

## read data into R
cameraData<-read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData)

## alternative way to read data into R
cameraData<-read.csv("./data/cameras.csv")
head(cameraData)

## downloading excel files
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.xlsx")
dateDownloaded <- date()

## reading excel files

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)
head(cameraData)

## reading specific row and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1), colIndex=colIndex,rowIndex=rowIndex)
cameraDataSubset

## Reading XML data
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

## access elements just like a list
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode,xmlValue)
## pull out specific components from XML

## Getting the items on the menu and prices
xpathSApply(rootNode,"//name", xmlValue) ## returns menu items
xpathSApply(rootNode, "//price", xmlValue) ## returns item prices

## Parsing XML that is HTML
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

## Read Data from JSON
library(jsonlite)
jsonData<-fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner) ## accessing a data frame within a data frame
jsonData$owner$login ##accessing a data frame within a data frame

myjson<-toJSON(iris, pretty=TRUE) ## send iris data set to JSON 
cat(myjson) ## prints out JSON data
iris2<-fromJSON(myjson)
head(iris2)

## Using the data.table pacakage
library(data.table)
DF=data.frame(x=rnorm(9), y=rep(c("a", "b", "C"), each=3), z=rnorm(9))
head(DF,3)

DT=data.table(x=rnorm(9), y=rep(c("a", "b", "C"), each=3), z=rnorm(9))
head(DF,3)

## to see all tables in memory use 
tables()

## subsetting rows
DT[2,] ## second row
DT[DT$y=="a",] ## where y column = a
DT[c(2,3)] ## so this takes 2nd and 3rd rows
DT[,c(2,3)] ## this does not work.  Different from dataframe
## column subsetting is using expressions.  In R an expression is a collection
## of statesments enclosed in curley brackets. See example below
        {
                x=1
                y=2
        }
        k={print(10);5}
DT[,list(mean(x),sum(z))] ## instead of index, pass list functions with variables
DT[,table(y)] ##
DT[,w:=z^2]  ## adding new column to data.table
DT2<-DT
DT[,y:=2] ## overwrites column y with the value of 2
head(DT, n=3) ## shows the first 3 rows of data.table
head(DT2,n=3) ## changed DT2 as well
DT[,m:={tmp<-(x+z); log2(tmp+5)}] ## multi step operations
DT[,a:=x>0] ## creates a logical
DT[,b:=mean(x+w,by=a)] ## plyr like operations, grouping by variable a
## special variables in data.table
set.seed(123)
DT<-data.table(x=sample(letters[1:3],1E5, TRUE))
DT[,.N,by=x] ## .N counts the number of times a value appears
## Using Keys with data.tables
DT<-data.table(x=rep(c("a","b","c"), each=100), y=rnorm(300))
setkey(DT,x) ##subsetting and sorting more rapidly
DT['a'] ## the quoted 'a' tells R to look in key for the letter 'a'

## Using Keys to facilitate joins
DT1<-data.table(x=c('a','a','b','dt1'),y=1:4)
DT2<-data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x); setkey(DT2,x)
merge(DT1,DT2) ## only merges the common items (above that is 'a' and 'b')

## Data.table is fast at reading from disk
big_df<-data.frame(x=rnorm(1E6), y=rnorm(1E6)) ## create large data.frame
file<-tempfile() ## setup temp file
write.table(big_df,file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file)) ## new fast way to read
system.time(read.table(file, header=TRUE, sep="\t")) ## old slow way to read 
## compare the new and the old ways to read and the new way is much faster


### practice with data.tables

DF=data.frame(x=c("b", "b", "b", "a", "a"), v=rnorm(5))
DT=data.table(x=c("b", "b", "b", "a", "a"), v=rnorm(5))
sapply(DT, class)
DT[2,]
DT[x=="b",]
DT
setkey(DT,x)
DT
tables()
DT["b",]
DT["b", mult="first"]
DT["b", mult="last"]
DT["b"]

## highly effienent search 
identical(DT[list("R", "h"),], DT[.("R", "h"),])
## so DT[list("R","h"),] is the same as DT[.("R", "h"),]