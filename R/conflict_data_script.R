conflict_data <- read.csv(here("original","conflictdata.csv"),header=TRUE)

conflict_data <- conflict_data %>%
  group_by(year,ISO) %>%
  summarize(conflict = sum(best))
conflict_data$conflict <- ifelse(conflict_data$conflict >= 25,1,0)
conflict_data$year <- conflict_data$year + 1 # Accounting for the lag by a year
conflict_updated <- conflict_data

