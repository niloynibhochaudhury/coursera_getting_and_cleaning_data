## Week 2 notes for Getting and Cleaning Data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data")

## Reading from Mysql
library(RMySQL)
ucscDb<-dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
results<-dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)
results

## pull out a specific database called "hg19"
hg19<-dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)
length(allTables)
allTables[1:5]
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2") ## data base name + "sql select statement"
affyData<-dbReadTable(hg19, "affyU133Plus2") ## read table called "affyU133Plus2" from "hg19" database
head(affyData)
query<-dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis<-fetch(query);quantile(affyMis$misMatches)
affyMisSmall<-fetch(query,n=10); dbClearResult(query)
dim(affyMisSmall)
dbDisconnect(hg19)

dbGetQuery ## used to get table names 
dbGetTable ## will extract data from DB and Table
dbSendQuery(DB, "sql command") fetch(query) shows some info from query
fetch(query, n=10) ## fetch only first 10 rows.  you must do
## dbClearResult(query) to clear query
## can send any mysql query in quotes
## dont forget to close connection
dbDisconnect(DB)

## Reading HDF5 hierarcharically data sets
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created=h5createFile("example.h5")
created

### creating groups within file
created=h5createGroup("example.h5", "foo")
created=h5createGroup("example.h5", "baa")
created=h5createGroup("example.h5", "foo/baa")
h5ls("example.h5")

## writing to groups
A=matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A")
B=array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale")<-"liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

## write a data set to a top level group
h5write(df, "example.h5","df")

## reading data
readA=h5read("example.h5", "foo/A")
readB=h5read("example.h5", "foo/foobaa/B")
readdf=h5read("example.h5", "df")
readA

## writing and reading chunks
h5write(c(12,13,14), "example.h5", "foo/A", index=list(1:3,1))
h5read("example.h5","foo/A")

## Reading data from the web
## web scraping is programatically extracting data from HTML
con=url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode=readLines(con)
close(con)
htmlCode

## Parsing with XML
library(XML)
url<-"http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html<-htmlTreeParse(url,useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

## GET from the httr package
library(httr); html2=GET(url)
content2=content(html2,as="text")
parsedHtml=htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

## accessing websites with passwords
pg1=GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2=GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2
names(pg2)

## Using handles
google=handle("http://google.com")
pg1=GET(handle=google,path="/")
pg2=GET(handle=google,path="search")
## look at R Bloggers http://www.r-bloggers.com/?s=Web+Scraping

## getting Data from API's

## Reading From Other Sources
        ## Google "data storage mechanism R package"
        ## use file, url, gzfile, bzfile, ?connections
        ## Foreign package will read from other stats packages
        RPostressSQL ## DBI compliant database connection
        RODBC ## ODBC
        RMongo ##
        rmongodb ##
        image readers, jpeg, readbitmap, png, EBImage
        reading GIS data, rdgal, rgeos, raster
        reading mp3 and audio files, tuneR, seewave
        
## S
        


