
SHELL := /usr/bin/env bash

SRC_DIR     := ./src
INC_DIR     := ./inc
OBJ_DIR     := ./obj
BIN_DIR     := ./bin
COMMON_DIR  := ../../common
LIB_DIR     := $(COMMON_DIR)/libctboard

MD_FILES    := bit-manipulations.md

AS_SRC      :=

C_DEF       := PLATFORM_M0
C_INC       := ./src \
               $(COMMON_DIR)/device/include/ \
               $(COMMON_DIR)/hal/include/
C_SRC       := main.c \
               utils_ctboard.c

include     $(COMMON_DIR)/root.mk
include     $(COMMON_DIR)/pdf.mk
