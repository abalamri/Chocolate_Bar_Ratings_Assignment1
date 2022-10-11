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
datatable(chocolate)

ggplot(chocolate, aes(rating)) + 
  geom_density()
# The density plot of the chocolate ratings shows a lot of humps implying further investigating is required.


  


