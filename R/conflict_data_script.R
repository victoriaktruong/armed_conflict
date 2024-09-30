conflict_data <- read.csv(here("original","conflictdata.csv"),header=TRUE)

conflict_data %>%
  group_by(ISO, year)  %>%
  summarise(totdeath = sum(best))  %>%
  mutate(conflict = ifelse(totdeath < 25, 0, 1))  %>%
  ungroup()  %>%
  mutate(year = year + 1) -> conflict_updated # Accounting for the lag by a year

conflict_updated


