library(dplyr)
library(ggplot2)
library(here)
library(tidyr)
here::i_am("code/02_make_figures.R")


# 1. Leshan - Create resp_fig ==============================================================================
## Load the frequency table data
table_resp = readRDS(here::here("output/table_resp.rds"))

## Convert CASE_STATUS to a factor for better labeling in the plot
table_resp$`COVID-19 Status` = factor(table_resp$`COVID-19 Status`, 
                                levels = c(0,1),
                                labels = c("No COVID-19", "COVID-19"))

## Reshape data for plotting
table_resp_long = table_resp %>%
  pivot_longer(cols = -`COVID-19 Status`, names_to = "Disease", values_to = "Count")

## Create the grouped bar chart
resp_fig = ggplot(table_resp_long, aes(x = Disease, y = Count, fill = `COVID-19 Status`)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Number of Cases with Respiratory Diseases by COVID-19 Status",
       x = "Respiratory Disease",
       y = "Count",
       fill = "COVID-19 Status") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Save the plot as a .png file in the output folder
ggsave(filename = here::here("output/resp_fig.png"), plot = resp_fig, width = 8, height = 6)


# Ziyi - Create nonresp_fig ================================================================================
## Load the frequency table data
table_nonresp <- readRDS(here::here("output/table_nonresp.rds"))

## Convert CASE_STATUS to a factor for better labeling in the plot
table_nonresp$`COVID-19 Status` = factor(table_nonresp$`COVID-19 Status`, 
                                      levels = c(0,1),
                                      labels = c("No COVID-19", "COVID-19"))

## Reshape data for plotting
table_nonresp_long <- table_nonresp %>%
  pivot_longer(cols = -`COVID-19 Status`, names_to = "Disease", values_to = "Count")

## Create the grouped bar chart
nonresp_fig <- ggplot(table_nonresp_long, aes(x = Disease, y = Count, fill = `COVID-19 Status`)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Number of Cases with Non-Respiratory Diseases by COVID-19 Status",
       x = "Non-Respiratory Chronic Disease",
       y = "Count",
       fill = "COVID-19 Status") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Save the plot as a .png file in the output folder
ggsave(filename = here::here("output/nonresp_fig.png"), plot = nonresp_fig, width = 8, height = 6)


# Menglong - Create severity_fig ===========================================================================
## Load the frequency table data
table_severity <- readRDS(here::here("output/table_severity.rds"))

## Convert CASE_STATUS to a factor for better labeling in the plot
table_severity$`COVID-19 Status` = factor(table_severity$`COVID-19 Status`, 
                                         levels = c(0,1),
                                         labels = c("No COVID-19", "COVID-19"))

## Reshape data for plotting
table_severity_long <- table_severity %>%
  pivot_longer(cols = -`COVID-19 Status`, names_to = "Type", values_to = "Count")

## Create the grouped bar chart
severity_fig <- ggplot(table_severity_long, aes(x = Type, y = Count, fill = `COVID-19 Status`)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(
    title = "Number of Cases with Indicators for Severe Disease by COVID-19 Status",
    x = "Severity Type",
    y = "Count",
    fill = "COVID-19 Status"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Save the figure as a severity_fig.png file in the output folder
ggsave(filename = here::here("output/severity_fig.png"), plot = severity_fig, width = 8, height = 6)


# Neil - Creating Demographic Figures

# Load the cleaned data
covid <- readRDS(here::here("output/data_clean.rds"))

# 1. CASE_STATUS Bar Chart ==============================================================================
## Prepare data for CASE_STATUS bar chart
case_status_counts <- covid %>%
  count(CASE_STATUS) %>%
  mutate(CASE_STATUS = factor(CASE_STATUS, levels = c("Not Severe Cases", "Severe Cases")))

## Create the CASE_STATUS bar chart
case_status_fig <- ggplot(case_status_counts, aes(x = CASE_STATUS, y = n, fill = CASE_STATUS)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(
    title = "Number of Cases by COVID-19 Status",
    x = "COVID-19 Status",
    y = "Count"
  ) +
  theme_minimal()

## Save the CASE_STATUS plot
ggsave(filename = here::here("output/case_status_fig.png"), plot = case_status_fig, width = 8, height = 6)

# 2. SEX Bar Chart =========================================================================================
## Prepare data for SEX bar chart
sex_counts <- covid %>%
  count(SEX) %>%
  mutate(SEX = factor(SEX, levels = c("Male", "Female")))

## Create the SEX bar chart
sex_fig <- ggplot(sex_counts, aes(x = SEX, y = n, fill = SEX)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(
    title = "Number of Cases by Sex",
    x = "Sex",
    y = "Count"
  ) +
  theme_minimal()

## Save the SEX plot
ggsave(filename = here::here("output/sex_fig.png"), plot = sex_fig, width = 8, height = 6)

# 3. AGE Box Plot ==========================================================================================
## Create the AGE box plot
age_fig <- ggplot(covid, aes(x = "", y = AGE)) +
  geom_boxplot(fill = "skyblue", color = "darkblue") +
  labs(
    title = "Age Distribution of Cases",
    x = "All Cases",
    y = "Age"
  ) +
  theme_minimal()

## Save the AGE plot
ggsave(filename = here::here("output/age_fig.png"), plot = age_fig, width = 8, height = 6)
