
library(dplyr)
library(ggplot2)
library(here)
library(tidyr)
here::i_am("code/02_make_figures.R")


# Create nonresp_fig
## Load the frequency table data
table_nonresp <- readRDS(here::here("output/table_nonresp.rds"))

## Convert CASE_STATUS to a factor for better labeling in the plot
table_nonresp$CASE_STATUS <- factor(table_nonresp$CASE_STATUS, labels = c("No COVID-19", "COVID-19"))

## Reshape data for plotting
table_nonresp_long <- table_nonresp %>%
  pivot_longer(cols = -CASE_STATUS, names_to = "Disease", values_to = "Count")

## Create the grouped bar chart
nonresp_fig <- ggplot(table_nonresp_long, aes(x = Disease, y = Count, fill = CASE_STATUS)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Non-Respiratory Chronic Diseases by COVID-19 Status",
       x = "Non-Respiratory Chronic Disease",
       y = "Count",
       fill = "COVID-19 Status") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Save the plot as a .png file in the output folder
ggsave(filename = here::here("output/nonresp_fig.png"), plot = nonresp_fig, width = 8, height = 6)
