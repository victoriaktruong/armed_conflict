conflictdata <- read.csv(here("original","conflictdata.csv"),header=TRUE)


# Create a function that determines to see if the countries had a conflict that year
# We don't care if there were multiple conflicts, we just want a yes or no for conflict that year 
# "Remember that the armed conflict variable was lagged by a year in the analysis"

# 1999-2018

conflict <- function(x,y){
  mutate(conflict0 = ifelse ) 
}