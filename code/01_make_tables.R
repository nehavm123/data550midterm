library(here)
library(dplyr)
here::i_am("code/01_make_tables.R")

## Load the cleaned data
covid <- readRDS(here::here("output/data_clean.rds"))

# Resp
## 1. Leshan - Frequency of respiratory diseases (PNEUMONIA, COPD, and ASTHMA)
table_resp <- covid %>%
  select(CASE_STATUS, PNEUMONIA, COPD, ASTHMA) %>%
  group_by(CASE_STATUS) %>%
  summarise(
    PNEUMONIA = sum(PNEUMONIA == "Yes", na.rm = TRUE),
    COPD = sum(COPD == "Yes", na.rm = TRUE),
    ASTHMA = sum(ASTHMA == "Yes", na.rm = TRUE),
  )


## Save the table to output/table_resp.rds
saveRDS(table_resp, file = here::here("output/table_resp.rds"))

# Non-resp
## Create the frequency table by counting "Yes" responses for each disease
table_nonresp <- covid %>%
  select(CASE_STATUS, DIABETES, CARDIOVASCULAR, OBESITY, RENAL_CHRONIC, HIPERTENSION) %>%
  group_by(CASE_STATUS) %>%
  summarise(
    DIABETES = sum(DIABETES == "Yes", na.rm = TRUE),
    CARDIOVASCULAR = sum(CARDIOVASCULAR == "Yes", na.rm = TRUE),
    OBESITY = sum(OBESITY == "Yes", na.rm = TRUE),
    RENAL_CHRONIC = sum(RENAL_CHRONIC == "Yes", na.rm = TRUE),
    HIPERTENSION = sum(HIPERTENSION == "Yes", na.rm = TRUE)
  ) %>%
  as.data.frame()

## Save the table as an .rds file in the output folder
saveRDS(table_nonresp, file = here::here("output/table_nonresp.rds"))

# Severity
## Create the frequency table by counting "Yes" responses for disease severity
table_severity <- covid %>%
  select(CASE_STATUS, ICU, INTUBED, DIED) %>%
  group_by(CASE_STATUS) %>%
  summarise(
    ICU = sum(ICU == "Yes", na.rm = TRUE),
    INTUBED = sum(INTUBED == "Yes", na.rm = TRUE),
    DIED = sum(DIED == 1, na.rm = TRUE),
  ) %>%
  as.data.frame()

## Save the table as an .rds file in the output folder
saveRDS(table_severity, file = here::here("output/table_severity.rds"))










