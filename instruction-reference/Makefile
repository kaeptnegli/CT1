SHELL       := /usr/bin/env bash

PREFIX      :=
# required commands
PDFLT       := $(PREFIX)latexmk
MAGICK      := magick
PDF2SVG     := pdf2svg

ISTR_DIR    := ./instructions
OUT_DIR     := ./output
IPDF_DIR    := $(OUT_DIR)/instructions
AUX_DIR     := $(OUT_DIR)/auxiliary
PNG_DIR     := ./png
SVG_DIR     := ./svg

MK_DIR      := $(OUT_DIR) $(AUX_DIR) $(PNG_DIR) $(SVG_DIR)

SRC         := ./instruction-reference.tex
ISTR        := $(shell find $(ISTR_DIR) \
               -not -name "preamble-instruction.tex" \
               -not -name "__template.tex" \
               -name "*.tex")
PREAMBLE    := $(ISTR_DIR)/preamble-instruction.tex

PDF         := $(addprefix $(OUT_DIR)/, $(notdir $(SRC:.tex=.pdf)))
ISTR_PDF    := $(addprefix $(IPDF_DIR)/, $(notdir $(ISTR:.tex=.pdf)))

PNG         := $(addprefix $(PNG_DIR)/, $(notdir $(ISTR:.tex=.png)))
SVG         := $(addprefix $(SVG_DIR)/, $(notdir $(ISTR:.tex=.svg)))


export TEXINPUTS := ":$(IPDF_DIR):$(ISTR_DIR):${TEXINPUTS}:"


.PHONY: all build rebuild clean test


all: $(MK_DIR) $(ISTR_PDF) $(PDF) $(PNG) $(SVG)


build: all


clean:
	rm -rf $(MK_DIR)


rebuild: clean all


$(MK_DIR):
	mkdir -p $(MK_DIR)


$(OUT_DIR)/%.pdf: $(SRC) $(ISTR_PDF)
	$(PDFLT) \
        -norc \
        -pdf \
        -aux-directory=$(AUX_DIR) \
        -output-directory=$(OUT_DIR) \
        -output-format=pdf \
        $<


$(IPDF_DIR)/%.pdf: $(ISTR_DIR)/%.tex $(PREAMBLE)
	$(PDFLT) \
        -norc \
        -pdf \
        -aux-directory=$(AUX_DIR) \
        -output-directory=$(IPDF_DIR) \
        -output-format=pdf \
        $<


$(PNG_DIR)/%.png: $(IPDF_DIR)/%.pdf
	$(MAGICK) \
        -density 600 \
        $< \
        $@


$(SVG_DIR)/%.svg: $(IPDF_DIR)/%.pdf
	$(PDF2SVG) \
        $< \
        $@


test:
	@echo "src=$(SRC)"
	@echo "instructions=$(ISTR)"
	@echo "pdf=$(PDF)"
	@echo "instruction pdfs=$(ISTR_PDF)"
	@echo "png=$(PNG)"
