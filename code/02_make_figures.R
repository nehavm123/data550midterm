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
