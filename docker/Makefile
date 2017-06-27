.PHONY: all

all: build.done

build.done: Dockerfile
	docker build -t bhaskarvk/rgeodataviz .
	touch build.done
