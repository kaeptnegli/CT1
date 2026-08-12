
SHELL       := /usr/bin/env bash

SRC_DIR     := ./src
INC_DIR     := ./inc
OBJ_DIR     := ./obj
BIN_DIR     := ./bin
COMMON_DIR  := ../../common
LIB_DIR     := $(COMMON_DIR)/libctboard

MD_FILES    := multiplication.md

AS_SRC      := main.s \
               mul_s16.s \
               mul_u16.s \
               mul_u32.s

C_DEF       := PLATFORM_M0
C_INC       :=
C_SRC       :=

include     $(COMMON_DIR)/root.mk
include     $(COMMON_DIR)/pdf.mk
