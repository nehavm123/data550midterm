
# Midterm Project: COVID-19 Cases in Mexico

## Data
The data for this project contains clinical and demographic information on COVID-19 cases in Mexico. We aim to conduct a descriptive analysis on different demographic and clinical factors of disease. The `data/` folder contains the raw data (`covid_sub.csv`), pseudo datasets for code testing, and a data dictionary. 

------------------------------------------------------------------------
## How to Use
1. Using R Console, set the project root directory as the working directory.
  - Run `source('renv/activate.R')` to activate the project.
2. Using terminal, go to the project root directory.
  - Run `make install` to synchronize the package environment.
  - Run `make report.html` to make the report.
3. In order to customize the report to include information on disease severity, set `severe = TRUE` in the render function in `03_render_report.R` before making the report. To exclude information on disease severity, set `severe = FALSE` in the render function in `03_render_report.R` before making the report.

------------------------------------------------------------------------

## Code Structure

`code/00_clean_data.R`

  - Reads in the raw dataset
  - Creates a `CASE_STATUS` variable that is set to 1 to indicate having COVID-19 (if ```CLASIFFICATION_FINAL``` is less than 4) and 0 to indicate not having COVID-19 (if ```CLASIFFICATION_FINAL``` is greater than or equal to 4)
  - Creates a `DIED` variable that is set to 1 if ```DATE_DIED``` is not NA and 0 if the variable is NA.
  - Saves dataset with `CASE_STATUS` variable as `data_clean.rds` in `output/` folder

`code/01_make_tables.R`

  - Creates frequency table (`table_severe`) for disease severity (ICU and died) among those who have COVID-19 and those who do not 
  - Creates frequency table (`table_resp`) for respiratory diseases (COPD and asthma) among those who have COVID-19 and those who do not 
  - Creates frequency table (`table_nonresp`) for non-respiratory chronic diseases (diabetes and hypertension) among those who have COVID-19 and those who do not
  - All tables should be saved as an `.rds` object in `output/` folder

`code/02_make_figures.R`

  - Creates separate grouped bar charts for disease severity (`severe_fig`), respiratory diseases (`resp_fig`), and non-respiratory chronic diseases (`nonresp_fig`) This will result in three charts in total.
  - All figures should be saved as a `.png` object in `output/` folder

`code/03_render_report.R`

  - Renders the report
  - Specifies parameter value for `severe` when rendering the report 

`code/04_psuedo_data_basic.R`

  - Code for constructing modified datasets to test the report generation process
  - Not required for building the final report
    
`report.Rmd`

  - Produces three descriptive analysis tables
  - Produces three bar charts
  - The parameter `severe` in the rmarkdown file will be set to `TRUE` to include information on disease severity and `FALSE` to not include information on disease severity.

  
------------------------------------------------------------------------

 
The Makefile, Rmarkdown (`report.Rmd`), and HTML report will be in the root directory of the project. The Rmarkdown will contain the tables and figures produced in the analysis.
  



