library(here)
library(tidyverse)


# Read the mortality datasets

matmor <- read.csv(here("original","maternalmortality.csv"),header=TRUE)
infmor <- read.csv(here("original","infantmortality.csv"),header=TRUE)
neomor <- read.csv(here("original","neonatalmortality.csv"),header=TRUE)
und5mor <- read.csv(here("original","under5mortality.csv"),header=TRUE)


# Data cleaning function

clean <- function(data, name){
  data_subset <- data %>% 
    select(Country.Name, X2000:X2019)
  data_long <- data_subset %>%
    pivot_longer(cols = starts_with("X"),names_to="year",values_to = name)
  data_long <- data_long %>%
    mutate(year = as.numeric(sub("X", "", year)))
  return(data_long)
}

# Apply the function to all existing datasets to create new datasets
clean_matmor <- clean(matmor,"MatMor")
clean_infmor <- clean(matmor,"InfMor")
clean_neomor <- clean(matmor,"NeoMor")
clean_und5mor <- clean(matmor,"Und5Mor")

# Merge the cleaned datasets using reduce and full_join
merged_data <- reduce(list(clean_matmor, clean_infmor, clean_neomor, clean_und5mor),
                      full_join, by = c("Country.Name", "year"))

# Add ISO-3 to the data
library(countrycode)
merged_data$ISO <- countrycode(merged_data$Country.Name,origin = "country.name",destination = "iso3c")
merged_data <- select(merged_data, -Country.Name)

                                                                                  