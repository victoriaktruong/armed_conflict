library(here)
library(tidyverse)
library(countrycode)

rawdat <- read.csv(here("original","maternalmortality.csv"), header=TRUE)

data_wide <- select(rawdat,Country.Name, X2000:X2019)

data_long <- 


# Create a function that performs the same procedure on the 
# maternal mortality ata so that you can apply the same steps on 
# infant mortality, neonatal mortality, and under 5 mortality 

data1 <- read.csv(here("original","infantmortality.csv"),header=TRUE)
data2 <- read.csv(here("original","neonatalmortality.csv"),header=TRUE)
data3 <- read.csv(here("original","under5mortality.csv"),header=TRUE)


wide_1 <- select(data1,Country.Name, X2000:X2019)
long_1 <- pivot_longer(data1, X2000:X2019, names_to = "Year") %>%
  mutate(Year=as.integer(gsub("X", "",Year))) %>% rename(MatMor=value) 

data1

wide_2 <- select(data2,Country.Name, X2000:X2019)
long_2 <- pivot_longer(data2, X2000:X2019, names_to = "Year") %>%
  mutate(Year=as.integer(gsub("X", "",Year))) %>% rename(MatMor=value) 

data2

wide_3 <- select(data3,Country.Name, X2000:X2019)
long_3 <- pivot_longer(data3, X2000:X2019, names_to = "Year") %>%
  mutate(Year=as.integer(gsub("X", "",Year))) %>% rename(MatMor=value) 

data3 





new <- function(x){
       %>%
      pivot_longer(x, X2000:X2019, names_to = "Year") %>%
      mutate(Year=as.integer(gsub("X", "",Year))) %>%
      rename(MatMor=value)
  return(data)
  
}
  
new(data2)


#$ISO <- countrycode(__)













    
# Ignore the warning

disaster <- read.csv(here("data", "original", "disaster.csv"), header = TRUE)

### select rows for earthquake and drought and columns for year, country, ISO, disaster type
disaster %>%
  dplyr::filter(Year >= 2000 & Year <= 2019) |>
  dplyr::filter(Disaster.Type %in% c("Earthquake", "Drought")) |>
  dplyr::select(Year, ISO, Disaster.Type) |>
  rename(year = Year) |>
  group_by(year, ISO) |>
  mutate(drought0 = ifelse(Disaster.Type == "Drought", 1, 0),
         earthquake0 = ifelse(Disaster.Type == "Earthquake", 1, 0)) |>
  summarize(drought = max(drought0),
            earthquake = max(earthquake0)) |> 
  ungroup() -> disasters 

#save(disasters, file = here("data", "disasters.Rda"))





                                                                                  