library(here)
library(dplyr)
library(ggplot2)

finaldata <- read.csv(here("original","analytical","finaldata.csv"), header = TRUE)

finaldata_clean <- finaldata %>%
  select(country_name, ISO, year, matmor) %>%
  filter(year >= 2000 & year <= 2017) %>%
  arrange(ISO, year) %>%
  group_by(ISO) %>%
  mutate(diffmatmor = matmor[year == 2017] - matmor[year == 2000]) %>%  
  filter(diffmatmor > 0) %>%  
  ungroup() %>%
  select(ISO) %>%
  distinct()

finaldata_filtered <- finaldata %>%
  filter(ISO %in% finaldata_clean$ISO)

figure1 <- ggplot(finaldata_filtered, aes(x = year, y = matmor, color = country_name, group = ISO)) +
  geom_line() +
  geom_point() +
  labs(title = "Countries with Increasing Maternal Mortality Rates (2000-2017)",
       x = "Year",
       y = "Maternal Mortality") +
  theme_minimal() +
  scale_color_discrete(name = "Country")

figure1

ggsave(figure1, file = here("figures","figure1_matmor.png"), width = 10, height = 8)

