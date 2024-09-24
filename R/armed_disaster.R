library(here)
library(tidyverse)

rawdata <- read.csv(here("original","disaster.csv"), header=TRUE)


data <- rawdata %>% filter(Year %in% c(2000:2019))%>%
                    filter(Disaster.Type %in% c("Earthquake","Drought")) %>%
                    select(Year,ISO,Disaster.Type)                   
 
subset_data <- data %>%
  mutate(drought = ifelse(Disaster.Type == "Drought", 1, 0),
         earthquake = ifelse(Disaster.Type == "Earthquake", 1, 0))

summary_data <- subset_data %>%
  group_by(Year, ISO) %>%
  summarize(
    drought = max(drought),       
    earthquake = max(earthquake)  
  ) %>%
  ungroup()



disaster <- read.csv(here("data","original","disaster"),header=TRUE)

disaster %>% 
  dplyr::filter (Year %in% c(2000:2019)) %>%
  dplyr::filter (Disaster.Type %in% c("Earthquake", "Drought")) %>%
  dplyr::select(Year,ISO,Disaster.Type) %>%
  rename(year = Year) %>%
  group_by(year, ISO) %>%
  mutate(drought0 = ifelse(Disaster.Type == "Drought",1,0),
         earthquake0 = ifelse(Disaster.Type == "Earthquake",1,0)) %>%
  summarize(drought = max(drought0), earthquake = max(earthquake0)) %>%
  ungroup() -> disaster


conflictdata <- read.csv(here("original","conflictdata.csv"),header=TRUE)



#save(disasters, file = here("data", "disasters.Rda"))







disaster <- read.csv(here("data", "original", "disaster.csv"), header = TRUE)

### select rows for earthquake and drought and columns for year, country, ISO, disaster type

  rename(year = Year) |>
  group_by(year, ISO) |>
  mutate(drought0 = ifelse(Disaster.Type == "Drought", 1, 0),
         earthquake0 = ifelse(Disaster.Type == "Earthquake", 1, 0)) |>
  summarize(drought = max(drought0),
            earthquake = max(earthquake0)) |> 
  ungroup() -> disasters 

#save(disasters, file = here("data", "disasters.Rda"))
      












