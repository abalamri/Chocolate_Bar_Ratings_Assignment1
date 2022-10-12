library(tidytuesdayR)
library(tidyverse)
library(ggplot2)
library(readr)
library(stringr)
library(lubridate)

#we are working on the Chocolate Bar 2022 dataset from Flavors of Cacao,
##dataset outlining over 1,700 types of plain dark chocolate bars, their ratings, ingredients, and tastes that we got from Kaggle
##From this dataset, we are trying to analyze the best type of cacao beans for

##chocolate bars by finding out which company managed to make the highest rating chocolate bars?
##analyze whether the cacao percentage, and the selected bean types has anything to do with the quality of the chocolate ?
#Does the date of review matter?The question would make sure that the data in the dataset is reliable across time. 
##This is necessary because all of the ratings are done by one person, so his biases over time

# to read full data

dim(chocolate) 
### the dataset contain of 2530 rows and 10 variables 

diagnose(chocolate)
## A tibble: 10 × 6
variables                        types     missing_count missing_percent unique_count unique_rate
<chr>                            <chr>             <int>           <dbl>        <int>       <dbl>
  1 ref                              numeric               0            0             630     0.249  
2 company.names                    character             0            0             580     0.229  
3 comapny.location                 character             0            0              67     0.0265 
4 review.year                      numeric               0            0              16     0.00632
5 Bean.origin                      character             0            0              62     0.0245 
6 specific_bean_origin_or_bar_name character             0            0            1605     0.634  
7 cocoa_percent                    numeric               0            0              46     0.0182 
8 ingredients                      character            87            3.44           22     0.00870
9 most_memorable_characteristics   character             0            0            2487     0.983  
10 rating                           numeric               0            0              12     0.00474

str(chocolate)
str(tuesdata)
glimpse(chocolate)
## we noticed that "Cocoa Percent"is a character, not a numeric value we need To do that, we have to clean up our data first by#
# removing the special characters, which might be caused by an imperfect conversion of the original data to “.csv”, and changing the data types of the columns from our data frame. Afterwards, we can start to subset our data to find our desired values.
##to remove all percetnage signs 
chocolate$cocoa_percent <- sapply(chocolate$cocoa_percent, function(x) gsub("%", "", x))
chocolate <- type_convert(chocolate)
str(chocolate)
### now all "cocoa percent" turn to numeric 

##to find the location of missing values 

which(is.na(chocolate))
##
[1] 17796 17797 17875 18004 18034 18036 18037 18130 18131 18132 18141 18142 18207 18222 18262
[16] 18263 18298 18301 18313 18314 18315 18316 18317 18337 18343 18473 18495 18528 18568 18817
[31] 18829 18891 18897 18901 18903 18909 18910 18979 18980 18989 18990 19030 19031 19032 19033
[46] 19051 19052 19066 19067 19133 19134 19219 19220 19221 19222 19337 19356 19360 19361 19362
[61] 19381 19410 19411 19487 19658 19670 19697 19728 19729 19730 19731 19732 19789 20004 20047
[76] 20068 20077 20111 20112 20116 20117 20118 20135 20136 20137 20158 20168

## tot find the count of missing values 
sum(is.na(chocolate))
###[1] 87 "the count of missing values .

names(chocolate)
names(chocolate)[names(chocolate) %in% c("company_manufacturer",
                                         "company_location",
                                         "review_date","country_of_bean_origin",
                                         "pecific_bean_origin_or_bar_name")] <-c("company.names",
                                                                                 "comapny.location",
                                                                                 "review.year","Bean.origin",
                                                                                 "chocholate.bar.name")
                                                                       
names(chocolate)
head(chocolate)
duplicated(chocolate)
unique(chocolate)
chocolate %>% distinct()
print(chocolate)

# ##Flavors of Cacao Rating System
#The reviewer of a total of  chocolate bars across the world has set a scale of chocolate bar ratings starting from 1 (lowest ratings) up to 5 (highest ratings) in order to give us a bit of description of how it taste. The complete information regarding the rating values is as follow:
  
#5 = Elite (Transcending beyond the ordinary limits)
#4 = Premium (Superior flavor development, character and style)
#3 = Satisfactory(3.0) to praiseworthy(3.75) (well made with special qualities)
#2 = Disappointing (Passable but contains at least one significant flaw)
#1 = Unpleasant (mostly unpalatable)

# Subset cacao ratings which have value above or equal to satisfactory level and 
##count the number of data left in the data frame


good_quality_cacoa <- chocolate[chocolate$rating>= 3,]

nrow(good_quality_cacoa)
##[1] 1964

### Subset to only chocolate bars with a rating of 5, change factor data type back to character for previewing purpose, preview the cacao data which has elite rating

elite_cacao <- chocolate[chocolate$rating == 5,]
glimpse(chocolate)
