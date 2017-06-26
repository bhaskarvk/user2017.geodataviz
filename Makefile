all: build

build: inst/index.html inst/presentations/01-Introduction.html 
	Rscript -e 'devtools::install(upgrade_dependencies=F)'

inst/index.html: inst/index.Rmd
	Rscript -e 'rmarkdown::render("$<")'

inst/presentations/01-Introduction.html: inst/presentations/01-Introduction.Rmd
	Rscript -e 'rmarkdown::render("$<")'

clean:
	rm inst/*.html inst/*/*.html
