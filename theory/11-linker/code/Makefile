
SHELL       := /usr/bin/env bash

SRC_DIR     := ./App
INC_DIR     := ./inc $(SRC_DIR)
OBJ_DIR     := ./obj
BIN_DIR     := ./bin
LIB_DIR     := ../../../../libctboard
COMMON_DIR  := ../../../../common

AS_SRC      :=

C_DEF       := PLATFORM_M0
C_INC       :=
C_SRC       := main.c \
               square.c

include     $(COMMON_DIR)/root.mk


RD          := $(PREFIX)readelf


.PHONY: symbols


all: symbols


symbols:
	@for obj in $(AS_SRC:.a=.o) $(C_SRC:.c=.o); do \
        $(RD) -s $(OBJ_DIR)/$${obj} > $(LST_DIR)/$${obj/%.o/.symbols}; \
        done
	@$(RD) -s $(ELF) > $(ELF:.elf=.symbols)
