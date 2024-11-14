library(here)
library(dplyr)
here::i_am("code/01_make_tables.R")

## Create table_nonresp

## Load the cleaned data
covid <- readRDS(here::here("output/data_clean.rds"))

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











