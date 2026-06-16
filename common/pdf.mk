SHELL       := /usr/bin/env bash

MD_FILES    += readme.md

PDF_FILES   := $(MD_FILES:.md=.pdf)

VERBOSITY   :=


.PHONY: all clean clean_all test pdf repdf remove_pdf debug_pdf gfm


clean_all:: remove_pdf


pdf: $(PDF_FILES)


repdf: remove_pdf pdf


remove_pdf:
	@rm -f $(PDF_FILES) || true


debug_pdf: VERBOSITY := --verbose
debug_pdf: $(PDF_FILES)


%.pdf: %.md
	pandoc \
        --pdf-engine pdflatex \
        --listings \
        --template $(COMMON_DIR)/template.tex \
        -f markdown \
        -t pdf \
        $(VERBOSITY) \
        -o $@ \
        $<

