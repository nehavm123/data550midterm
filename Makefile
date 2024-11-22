report.html: code/03_render_report.R \
  report.Rmd tables figures
	Rscript code/03_render_report.R

output/data_clean.rds: code/00_clean_data.R data/covid_sub.csv 
	Rscript code/00_clean_data.R
	
tables: output/table_nonresp.rds output/table_resp.rds output/table_severity.rds
output/table_nonresp.rds output/table_resp.rds output/table_severity.rds: code/01_make_tables.R output/data_clean.rds
	Rscript code/01_make_tables.R 

figures: output/nonresp_fig.png output/resp_fig.png output/severity_fig.png
output/nonresp_fig.png output/resp_fig.png output/severity_fig.png: code/02_make_figures.R output/data_clean.rds
	Rscript code/02_make_figures.R

		
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html && rm -f *.pdf

.PHONY: install
install:
    Rscript -e "renv::restore(prompt = FALSE)"
	
	