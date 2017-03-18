ifeq (, $(REPORT))
define ERROR_MESSAGE

Provide REPORT (path to sqlite file generated by Mull):

REPORT=/path/to/mull-report.sqlite make

endef
$(warning $(ERROR_MESSAGE))
endif


.PHONY: build build/css build/js build/fonts

REPORT_NAME=$(shell basename $(REPORT) | cut -d"." -f1)

build: bootstrap
	bundle exec ruby render.rb $(REPORT) $(REPORT_NAME)
	open ./build/$(REPORT_NAME).html
	#open ./build/$(REPORT_NAME)_debug.html

bootstrap: build/css build/js build/fonts

build/css:
	mkdir -p build/css
	cp -R layout/css/ build/css

build/js:
	mkdir -p build/js
	cp -R layout/js/ build/js

build/fonts:
	mkdir -p build/fonts
	cp -R layout/fonts/ build/fonts

test:
	bundle exec rspec

clean:
	rm -rf build

