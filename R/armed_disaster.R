library(here)
library(tidyverse)

rawdata <- read.csv(here("original","disaster.csv"), header=TRUE)


data <- rawdata %>% 
  filter(Year %in% c(2000:2019)) %>%
  filter(Disaster.Type %in% c("Earthquake","Drought")) %>%
  select(Year,ISO,Disaster.Type)                   
 
subset_data <- data %>%
  mutate(drought = ifelse(Disaster.Type == "Drought", 1, 0),
         earthquake = ifelse(Disaster.Type == "Earthquake", 1, 0))

summary_data <- subset_data %>%
  group_by(Year, ISO) %>%
  summarize(
    drought = max(drought),       
    earthquake = max(earthquake)) %>%
  ungroup() -> disasters

disasters <- summary_data %>% rename(year = Year)

write.csv(summary_data,file=here("data","disasters.csv"),row.names = FALSE)


















