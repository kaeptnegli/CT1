
SHELL       := /usr/bin/env bash

SRC_DIR     := ./src
INC_DIR     := ./inc
OBJ_DIR     := ./obj
BIN_DIR     := ./bin
COMMON_DIR  := ../../common
LIB_DIR     := $(COMMON_DIR)/libctboard

MD_FILES    := interrupts.md

AS_SRC      := main.s \
               measurement.s \
               utils.s

C_DEF       := PLATFORM_M0
C_INC       :=
C_SRC       :=

include     $(COMMON_DIR)/root.mk
include     $(COMMON_DIR)/pdf.mk
