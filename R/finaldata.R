library(tidyverse)
library(here)

# Read all datasets used previously
covariate <- read.csv(here("original","covariates.csv"), header=TRUE)
mortality <- source(here("R","armed_conflict_code.R"))
disaster <- source(here("R","armed_disaster.R"))
conflict <- source(here("R","conflict_data_script.R"))


list_alldata <- list(merged_clean, conflict_updated, disasters)

finaldata0 <- list_alldata %>% reduce(full_join, by = c('ISO', 'year'))

list_alldata %>% reduce(full_join, by = c('ISO','year')) -> finaldata0

finaldata <- covariate %>% left_join(finaldata0, by = c("ISO","year"))

finaldata <- finaldata %>% 
  mutate(conflict = replace_na(conflict,0),
         drought = replace_na(drought,0),
         earthquake = replace_na(earthquake,0),
         totdeath = replace_na(totdeath,0))


if (!dir.exists(here("original", "analytical"))) {
  dir.create(here("original", "analytical"), recursive = TRUE)
}


write.csv(finaldata, file = here("original","analytical","finaldata.csv"),row.names=FALSE)
finaldata


