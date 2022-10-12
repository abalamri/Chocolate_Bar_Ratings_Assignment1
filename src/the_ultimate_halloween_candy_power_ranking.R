


library(readr)
library(dplyr)



candy_data <- read_csv("candy_data.csv")


glimpse(candy_data) #look at the structure and column types


summary(candy_data)

#Main Question
#Are the highest ranked candies in Halloween contain chocolate?


candy_data %>%
  arrange(-winpercent) %>% 
  select(competitorname, winpercent, chocolate) %>% 
  print(n=20)


#The top 12 ranked candies for Halloween contain chocolate
#All the candies that got 70% or above contain chocolate 



