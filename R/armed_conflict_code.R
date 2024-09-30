library(here)
library(tidyverse)


# Read the mortality datasets
matmor <- read.csv(here("original","maternalmortality.csv"),header=TRUE)
infmor <- read.csv(here("original","infantmortality.csv"),header=TRUE)
neomor <- read.csv(here("original","neonatalmortality.csv"),header=TRUE)
und5mor <- read.csv(here("original","under5mortality.csv"),header=TRUE)


clean <- function(dataname, varname){
  dataname  %>% 
    dplyr::select(Country.Name, X2000:X2019)  %>% 
    pivot_longer(cols = starts_with("X"),
                 names_to = "year",
                 names_prefix = "X",
                 values_to = varname)  %>% 
    mutate(year = as.numeric(year))  %>% 
    arrange(Country.Name, year)
}

matmor <- clean(matmor, "matmor")
infmor <- clean(infmor, "infmor")
neomor <- clean(neomor, "neomor")
und5mor <- clean(und5mor, "und5mor")


clean_list <- list(matmor, infmor, neomor, und5mor)


clean_list %>% reduce(full_join, by = c('Country.Name', 'year')) -> merged_clean


library(countrycode)

merged_clean$ISO <- countrycode(merged_clean$Country.Name, 
                          origin = "country.name", 
                          destination = "iso3c")
merged_clean <- select(merged_clean, -Country.Name)

merged_clean



