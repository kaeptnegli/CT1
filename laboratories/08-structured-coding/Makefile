
SHELL       := /usr/bin/env bash

SRC_DIR     := ./src
INC_DIR     := ./inc
OBJ_DIR     := ./obj
BIN_DIR     := ./bin
COMMON_DIR  := ../../common
LIB_DIR     := $(COMMON_DIR)/libctboard

MD_FILES    := structured-coding.md

AS_SRC      := struct_code.s

C_DEF       := PLATFORM_M0
C_INC       := $(LIB_DIR)/device/include/ \
               $(LIB_DIR)/hal/include/
C_SRC       := adc.c

include     $(COMMON_DIR)/root.mk
include     $(COMMON_DIR)/pdf.mk
