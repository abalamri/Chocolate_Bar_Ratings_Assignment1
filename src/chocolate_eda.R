# Author : Mohammed Alsoughayer
# Date: Oct 10, 2022
# Description: Preliminary EDA of Chocolate Bar Rating Data.

# Initialize Libraries 
library(tidyverse)
library(janitor)
library(DT)
library(GGally)
library(ggridges)

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

# Show density plot of rating to get an overview of the sample's rating destribution:
ggplot(chocolate, aes(rating)) + 
  geom_density()
# The density plot of the chocolate ratings shows a negative skew with a lot of humps implying further investigating is required.

# Analyze the cocoa percent vs rating
# Show count of each rating: 
table(as.character(chocolate$rating))
# table shows that the majority of our data falls between 2.5 and 4

# Check measures of location and spread of cocoa percent for each rating
chocolate %>% 
  group_by(rating) %>% 
  summarise(avg = mean(cocoa_percent), stdev = sd(cocoa_percent)) %>% 
  knitr::kable(caption = "The mean and standard deviation of cocoa percent")
# A trend is showing that the higher the rating the less noise/spread of cocoa percent and the more it centers around 70% cocoa percent

# show using box plot to see more robust measures 
chocolate %>% 
  group_by(rating) %>% 
  ggplot(aes(y = as.character(rating), x = cocoa_percent)) +
  geom_boxplot()

# Put the ingredients into the equation: 
chocolate %>% 
  group_by(ingredients) %>% 
  ggplot(aes(x = as.character(rating), y = cocoa_percent)) +
  geom_point() +
  facet_wrap(vars(ingredients), scales = 'free')
# The number of observations per unique set of ingredients vary. therefore, to analyze any trend we will only use the top eight sets. 
names(sort(table(chocolate$ingredients), decreasing = TRUE))[1:8] -> top_ingredients

# plot top ingredients and their cocoa percent and rating graphs:
chocolate %>% 
  filter(ingredients %in% top_ingredients) %>% 
  ggplot(aes(x = cocoa_percent, y = as.character(rating))) +
  geom_point() +
  facet_wrap(vars(ingredients))
# The top eight combination of ingredients 

# chocolate %>% 
#   filter(ingredients %in% top_ingredients) %>%
#   group_by(rating, ingredients) %>% 
#   summarise(count = length(ingredients)) -> ing_rat_count
# 
# datatable(ing_rat_count)

# plot rating density ridges among the top eight ingredients combination with avg cocoa percent hue
chocolate %>% 
  filter(ingredients %in% top_ingredients) %>% 
  group_by(ingredients) %>% 
  ggplot(aes(y = ingredients,  x = rating, color = mean(cocoa_percent))) + 
  geom_density_ridges() + 
  scale_color_continuous()
# need to incorporate cocoa percent into graph

# rating vs company location 
names(sort(table(chocolate$company_location), decreasing = TRUE))[1:20] -> top_countries

chocolate %>% 
  ggplot(aes(x = rating, y = company_location)) +
  geom_density_ridges()
# the density plot is cluttered and doesn't show any measure of frequency only the distribution of the data therefore do a facetwrap and plot histograms of top 20 countries
chocolate %>% 
  filter(company_location %in% top_countries) %>% 
  ggplot(aes(rating)) +
  geom_histogram() + 
  facet_wrap(vars(company_location), scales = 'free')
# the histogram shows that the top chocolate bar producing country in terms of production and rating is the united states. 
# moreover, the trend for all countries is somewhat normal 
# ask rick about replicating the map graphs from the article 

# rating vs country of bean origin
names(sort(table(chocolate$country_of_bean_origin), decreasing = TRUE))[1:20] -> top_bean_countries

chocolate %>% 
  ggplot(aes(x = rating, y = country_of_bean_origin)) +
  geom_density_ridges()
# the density plot is cluttered and doesn't show any measure of frequency only the distribution of the data therefore do a facetwrap and plot histograms of top 20 countries
chocolate %>% 
  filter(country_of_bean_origin %in% top_bean_countries) %>% 
  ggplot(aes(rating)) +
  geom_histogram() + 
  facet_wrap(vars(country_of_bean_origin))
# this histogram is harder to interpret than the previous one, however we can see that the top bean producing countries in terms of ratings are Dominican Republic?, Ecuador, Madagascar, Peru, and Venezuela
# further investigation is required. 