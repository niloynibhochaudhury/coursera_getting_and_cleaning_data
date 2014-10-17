library(dplyr)
dat<-read.csv("Fitness.csv")
myfitdat<-tbl_df(dat)
rm("dat")


## filter out NA's for Fasting Glucose
fast<-filter(myfitdat, !is.na(Fasting.Glucose))
