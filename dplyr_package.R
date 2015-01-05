## dplyr package

library(dplyr)

## move data frame to data frame table
cran<-tbl_df(mydf)


## to select on specific columns
select(cran, ip_id, package, country)

## use filter to selected rows.  Can use multiples
filter(cran, r_version=="3.1.1", country=="US")

filter(cran, country=="US" | country=="IN") ##either condition is true

filter(cran, !is.na(r_version)) ## all r_version that are not NA

## Arrange allow us to order rows
arrange(cran2, ip_id) # orders ip_id in accending
arrange(cran2, desc(ip_id)) ## descending orderarrange(cran2, country, desc(r_version), ip_id)
arrange(cran2, country, desc(r_version), ip_id) # country ascending, r_version descending, ip_id ascending

## mutate() create new variables from existing
mutate(cran3, size_mb=size / 2^20) # created new column from "size" column
mutate(cran3, size_mb=size/2^20, size_gb=size_mb/2^10) # created 2 columns from original data
mutate(cran3, correct_size=size+1000) # added 1000 to all size numbers

## summarize() collapses dataset into single row
summarize(cran, avg_bytes=mean(size))# takes mean of "size" column


## using the group_by in dplyr
by_package<-group_by(cran, package) ## group data by package
summarize(by_package, mean(size)) ## summarize now returns mean size for each package in group_by

## summarize by package 
pack_sum <- summarize(by_package,
count = n(),
unique = n_distinct(ip_id),
countries = n_distinct(country),
avg_bytes = mean(size))
pack_sum


## determine top 1% of downloads
quantile(pack_sum$count, probs = 0.99)
top_counts<-filter(pack_sum, count>679)

quantile(pack_sum$unique, probs=0.99)## unique downloads
top_unique<-filter(pack_sum, unique > 465)
arrange(top_unique, desc(unique))

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb <= 0.5) %>%
        arrange(desc(size_mb))

### tidyr program
library(tidyr)


## colapse columns that are not variables
gather(students, sex, count, -grade)

## colapse columns that are not variables
res<-gather(students2, sex_class, count, -grade)

## breaking apart a column with 2 variables in it
separate(res, sex_class, into=c("sex", "class"))

## gather columns class1:class5, key=class, value=grade
students3 %>%
        gather(class, grade, class1:class5,na.rm = TRUE) %>%
        print

## Use spread to spread out test column
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        print

## Extracting a number from a alpha-numeric
extract_numeric("class5")
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        mutate(class = extract_numeric(class)) %>%
        print

## Data where table has multiple observational units
## part 1
student_info <- students4 %>%
        select(id,name,sex) %>%
        print
## part 2
student_info <- students4 %>%
        select(id, name, sex) %>%
        unique %>%
        print
## part 3
gradebook <- students4 %>%
        select(id, class, midterm, final) %>%
        print

## A single observational unit is stored in multiple tables
## add a column to both tables first
passed<-passed %>% mutate(status = "passed")
failed<-failed %>% mutate(status = "failed")
rbind_list(passed, failed)

## Putting it all together
sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, into=c("part", "sex")) %>%
        print

sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        group_by(part, sex) %>%
        mutate(total = sum(count),
               prop = count /total
        ) %>% print













