## Week 4 code
setwd("~/.FY14 Priorities/03_Training/Data Science/Coursera Data Science/coursera_getting_and_cleaning_data")


## Editing Text variables
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

tolower(names(cameraData)) ## change all column names to lower case, remove lowercase

splitNames = strsplit(names(cameraData),"\\.") ## split on period
splitNames[[5]]  ## no split because 
splitNames[[6]] ## split variable out
firstElement <- function(x){x[1]} ## just takes first value coming out of the list
sapply(splitNames,firstElement) ## this removed the period from the list

## Example
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1] ## first element of list
mylist$letters ## subset by named varites
mylist[[1]]
splitNames[[6]][1] ## 6th item in list and 1st element


fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)


names(reviews)
sub("_","",names(reviews),) ## remove underscores from column names
testName <- "this_is_a_test"
sub("_","",testName) ## replaces first underscore with no space ""
gsub("_","",testName) ## replaces all underscores with no space ""

## String text searching
grep("Alameda",cameraData$intersection) ## searchs text in variables
table(grepl("Alameda",cameraData$intersection)) ## grepl returns a logical true or false if text is present
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),] ## subset data based on searches
grep("Alameda",cameraData$intersection,value=TRUE) ## value = true will return value where alameda appears
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))

library(stringr)
nchar("Jeffrey Leek") ## tells number of characters in a string
substr("Jeffrey Leek",1,7) ## take out part of sting.  1-7 characters
paste("Jeffrey","Leek") ## pastes items together with space
paste0("Jeffrey","Leek") ## pastes items together with no space
str_trim("Jeff      ") ## Trims spaces that appear at end of string
## do all lowercase
## descriptive
## not duplicated
## no underscores and dots
## Variables with character values
        ## should be made into factor variable
        ## should be descriptive use True/False not 1/0, and Male/Female not M/F


## Regular Expressions 1
## literals = match exactly
## Regular expressions consists of literals

^i think = matches the start of ta line.  Will not match middle of line
morning$ - represents the end of the line.  That is the $ sign
[Bb][Uu][Ss][Hh] - list a set of char we will accept at a given point
^[Ii] am - combine beginning of line and capital or lower case Ii and literal am
^[0-9][a-zA-Z] - can specify range of letters or char [a-zA-Z] match any 
[^?.]$ - any line that ends in anything other than a ? or period
        
        
## Regular Expressions II
9.11 - "." means it could be any character
flood|fire - this metacharacter is an "or" match eithe fire or flood
flood|earthquake|hurricane|coldfire - lots of alternatives to match
^[Gg]ood|[Bb]ad - alternatives can be reg expressions.  Upper or lower case good, bad anywhere in the line
^([Gg]ood|[Bb]ad) - must have either good or bad at begining of line, any case
[Gg]eorge( [Ww]\.)? [Bb]ush - "?" makes match optiona;
[Gg]eorge( [Ww]\.)? [Bb]ush - needed to us

## Working with Dates
library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()
library(lubridate)
d1 = date()
d1
class(d1)
d2 = Sys.Date()
d2
class(d2)
format(d2,"%a %b %d") ## abbreviated days, months etc

x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z = as.Date(x, "%d%b%Y")
z

z[1] - z[2]

as.numeric(z[1]-z[2])

weekdays(d2)

months(d2)

julian(d2)

library(lubridate)
ymd("20140108")

mdy("08/04/2013")

dmy("03-04-2013")

ymd_hms("2011-08-03 10:15:03")

ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")

?Sys.timezone

x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])

wday(x[1],label=TRUE)

## Data Resources
Open Government Sites
United Nations http://data.un.org/
U.S. http://www.data.gov/
        List of cities/states with open data
United Kingdom http://data.gov.uk/
France http://www.data.gouv.fr/
Ghana http://data.gov.gh/
Australia http://data.gov.au/
Germany https://www.govdata.de/
Hong Kong http://www.gov.hk/en/theme/psi/datasets/
Japan http://www.data.go.jp/
Many more http://www.data.gov/opendatasites

http://www.gapminder.org/
        
Survey data from the United States
http://www.asdfree.com

Infochimps Marketplace
http://www.infochimps.com/marketplace

Kaggle
http://www.kaggle.com

Collections by data scientists
Hilary Mason http://bitly.com/bundles/hmason/1
Peter Skomoroch https://delicious.com/pskomoroch/dataset
Jeff Hammerbacher http://www.quora.com/Jeff-Hammerbacher/Introduction-to-Data-Science-Data-Sets
Gregory Piatetsky-Shapiro http://www.kdnuggets.com/gps.html
http://blog.mortardata.com/post/67652898761/6-dataset-lists-curated-by-data-scientists

More specialized collections
Stanford Large Newtork Data
UCI Machine Learning
KDD Nugets Datasets
CMU Statlib
Gene expression omnibus
ArXiv Data
Public Data Sets on Amazon Web Services

Some API's with R Interfaces"

    twitter and twitteR package
    figshare and rfigshare
    PLoS and rplos
    rOpenSci
    Facebook and RFacebook
    Google maps and RGoogleMaps




        


