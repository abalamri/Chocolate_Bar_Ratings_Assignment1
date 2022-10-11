# Author : Mohammed Alsoughayer
# Date: Oct 10, 2022
# Description: Preliminary EDA of Chocolate Bar Rating Data.

# Initialize Libraries 
library(tidyverse)
library(janitor)
library(DT)
library(GGally)

# Read the data 
chocolate <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-18/chocolate.csv')

# Change format of some columns
chocolate$cocoa_percent <- gsub("%","",as.character(chocolate$cocoa_percent))
chocolate$cocoa_percent <- as.numeric(chocolate$cocoa_percent)
datatable(chocolate)
summary(chocolate)
# variable description: 
# ref: number referencing to time review was made (the higher the number the later and more recent the review)
# company_manufacturer: name of the company 
# company_location: country the company is located
# review_date: the year the review was made
# country_of_bean_origin: origin of bean used for chocolate bar
# specific_bean_origin_or_bar_name: variable describing either the location of the beans origin or the name of the bar
# coca_percent: number describing the percentage of cocoa making up the chocolate bar
# ingredients: "#" = represents the number of ingredients in the chocolate; B = Beans, S = Sugar, S* = Sweetener other than white cane or beet sugar, C = Cocoa Butter, V = Vanilla, L = Lecithin, Sa = Salt
# most_memorable_characteristics: brief descriptions of memorable characteristics of the bars.
# rating: rating: ordinal number ranging 1-4 with 0.25 increments describing the flavor rating of the bar.

ggplot(chocolate, aes(rating)) + 
  geom_density()
# The density plot of the chocolate ratings shows a lot of humps implying further investigating is required.

# Analyze the cocoa percent vs rating
# Show count of each rating: 
table(as.character(chocolate$rating))

# Check measures of location and spread of cocoa percent for each rating
chocolate %>% 
  group_by(rating) %>% 
  summarise(avg = mean(cocoa_percent), stdev = sd(cocoa_percent)) %>% 
  knitr::kable(caption = "The mean and standard deviation of cocoa percent")
# A small trend 

chocolate %>% 
  group_by(rating) %>% 
  ggplot(aes(x = as.character(rating), y = cocoa_percent)) +
  geom_boxplot()


