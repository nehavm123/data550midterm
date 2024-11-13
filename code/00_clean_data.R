library(here)
library(dplyr)

# Here Command
here::i_am("code/00_clean_data.R")

# Reads in Data
covid_sub_location <- here::here("data/covid_sub.csv")
covid <- read.csv(covid_sub_location, header = TRUE)

# Create new variable to indicate if person has COVID-19
covid <- covid %>% 
  mutate(CASE_STATUS = ifelse(CLASIFFICATION_FINAL < 4, 1, 0),
         DIED = ifelse(!is.na(DATE_DIED), 1, 0)
  )

# Save onto the output folder
saveRDS(covid, file = here::here("output/data_clean.rds"))