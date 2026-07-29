SHELL       := /usr/bin/env bash

MD_FILES    += readme.md

PDF_FILES   := $(MD_FILES:.md=.pdf)
GFM_FILES   := $(MD_FILES:.md=.gfm)

VERBOSITY   :=


.PHONY: all clean clean_all test pdf repdf remove_pdf debug_pdf gfm


clean_all:: remove_pdf


pdf: $(PDF_FILES)


repdf: remove_pdf pdf


remove_pdf:
	@rm -f $(PDF_FILES) $(GFM_FILES) || true


debug_pdf: VERBOSITY := --verbose
debug_pdf: $(PDF_FILES)

gfm: $(GFM_FILES)

%.pdf: %.md
	pandoc \
        --pdf-engine pdflatex \
        --listings \
        --template $(COMMON_DIR)/template.tex \
        --lua-filter=$(COMMON_DIR)/horizontal-rule.lua \
        -f markdown \
        -t pdf \
        $(VERBOSITY) \
        -o $@ \
        $<

%.gfm: %.md
	pandoc \
        -f markdown \
        -t gfm \
        $(VERBOSITY) \
        -o $@ \
        $<
