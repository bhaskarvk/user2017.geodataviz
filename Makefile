.PHONY: all build publish clean

RMD_FILES=$(shell find . -path ./inst/notebooks -prune -o -name '*.Rmd' -print)
RMD_NOTEBOOK_FILES=$(shell find inst/notebooks -name '*.Rmd')
HTML_FILES=$(RMD_FILES:%.Rmd=%.html)
NBHTML_FILES=$(RMD_NOTEBOOK_FILES:%.Rmd=%.nb.html)
CACHE_DIRS=$(RMD_FILES:%.Rmd=%_cache)
NBHTML_CACHE_DIRS=$(RMD_NOTEBOOK_FILES:%.Rmd=%_cache)
FIGURE_DIRS=$(RMD_FILES:%.Rmd=%_files)
NBHTML_FIGURE_DIRS=$(RMD_NOTEBOOK_FILES:%.Rmd=%_files)

RENDER = Rscript -e "devtools::load_all();suppressMessages(library(rmarkdown)); render('$<', quiet=TRUE)"

%.html: %.Rmd
	@echo "\033[35m$< ==> $@\033[0m"
	$(RENDER)

%.nb.html: %.Rmd
	@echo "\033[35m$< ==> $@\033[0m"
	$(RENDER)

all: build publish

build: build.done

build.done: $(HTML_FILES) $(NBHTML_FILES)
	@echo "\033[35mBuilding Package\033[0m"
	#Rscript -e 'devtools::install(upgrade_dependencies=F, dependencies=F, quick=T)'
	touch $@

publish:
	@echo "\033[35mSyncing with gh-pages\033[0m"
	rsync -av  --exclude '*_cache' --exclude '*.Rmd'  inst/ ./gh-pages

clean:
	@echo "\033[35mCleaning ...\033[0m"
	rm -rf build.done $(HTML_FILES) $(CACHE_DIRS) $(FIGURE_DIRS) $(NBHTML_FILES) $(NBHTML_CACHE_DIRS) $(NBHTML_FIGURE_DIRS)
