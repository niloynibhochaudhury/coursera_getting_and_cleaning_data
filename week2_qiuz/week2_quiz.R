## Week 2 quiz for getting and cleaning data
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data/week2_qiuz")

## Question #1
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", key="8f6ec2d956e359f840cf", secret="cbf9584126c0ee8c292df8eec0bcfce026c6bb04")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
cont<-content(req)
## convert output from json to data.frame
library(jsonlite)
jsonData<-fromJSON("https://api.github.com/users/jtleek/repos")
## filter jsonData data.frame using dplyr
library(dplyr)
jsonData %>%
        select(created_at, name) %>%
        filter(name=="datasharing")

## Answer             created_at        name
##              1 2013-11-07T13:25:07Z datasharing

## Question 2
install.packages("sqldf")
library(sqldf)
## Download file from internet
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "acs.csv")
list.files()
## load file to data.frame
acs<-read.csv("acs.csv")
## determine which select will show only the data for the probability weights pwgtp1 with ages less than 50
sqldf("select * from acs") ## no shows everything
sqldf("select * from acs where AGEP < 50") ## no shows every for ages less <50
sqldf("select pwgtp1, AGEP from acs where AGEP < 50") CORRECT
sqldf("select pwgtp1 from acs") ## will show all probability weights

## Question #3 
## Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
sqldf("select distinct AGEP from acs")  Correct
sqldf("select unique AGEP from acs") ##incorrect unique is not a valid parameter
sqldf("select unique * from acs") ##incorrect unique is not a valid parameter
sqldf("select distinct pwgtp1 from acs") ## incorrect, valid parameter, wrong variable. We wan AGEP no pwgtp1

## Question #4
## How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
## http://biostat.jhsph.edu/~jleek/contact.html 
library(httr)
library(XML)
con=url("http://biostat.jhsph.edu/~jleek/contact.html")
content=readLines(con)
close(con)
nchar(content[10])
nchar(content[20])
nchar(content[30])
nchar(content[100])
## answer 45,31,7,25

## Question #5
##Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
##https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
##Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
read_fwf<-read.fwf(url, widths=c(10,9,4,9,4,9,4,9,4), skip = 4)
head(read_fwf)
sum(read_fwf[,4]) ## this is the answer the sum = 32426.7


