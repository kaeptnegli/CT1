
SHELL       := /usr/bin/env bash

SRC_DIR     := ./src

INC_DIR     := $(SRC_DIR)

OBJ_DIR     := ./obj
BIN_DIR     := ./bin
LIB_DIR     := ../../libctboard
COMMON_DIR  := ../../common

AS_SRC      :=

C_DEF       := PLATFORM_M0
C_INC       := $(SRC_DIR) \
               $(INC_DIR)
C_SRC       := main.c \
               toggle.c

LIB_PATHS   := $(LIB_DIR)

LIB_NAMES   := ctboard


include     $(COMMON_DIR)/root.mk
include     $(COMMON_DIR)/pdf.mk

