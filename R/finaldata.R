library(tidyverse)
library(here)

# Read all datasets used previously
covariate <- read.csv(here("original","covariates.csv"), header=TRUE)
mortality <- source(here("R","armed_conflict_code.R"))
disaster <- source(here("R","armed_disaster.R"))
conflict <- source(here("R","conflict_data_script.R"))


list_alldata <- list(merged_data, conflict_updated, disasters)

# Merge datasets one at a time
finaldata0 <- full_join(merged_data, conflict_updated, by = c('ISO', 'year'))
finaldata0 <- full_join(finaldata0, disasters, by = c('ISO', 'year'))



finaldata0 <- list_alldata %>% reduce(full_join, by = c('ISO', 'year'))





list_alldata %>% reduce(full_join, by = c('ISO','year')) -> finaldata0

finaldata <- covariate %>% left_join(finaldata0, by = c("ISO","year"))

finaldata <- finaldata %>% 
  mutate(armedconf = replace_na(armedconf,0),
         drought = replace_na(drought,0),
         earthquake = replace_na(earthquake,0),
         total_death = replace_na(total_death,0))


write.csv(finaldata, file = here("original","analytical","finaldata.csv"),row.names=FALSE)