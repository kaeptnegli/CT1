SHELL :=        /usr/bin/env bash

PREFIX :=       arm-none-eabi-
CC :=           $(PREFIX)gcc
SIZE :=         $(PREFIX)size
AR :=           $(PREFIX)ar

NAME :=         ctio

SRC_DIR :=      ./
INC_DIR :=      ../inc

OBJ_DIR :=      ./obj

MKDIR :=        $(OBJ_DIR)

DBG_LEVEL :=
OPT_LEVEL :=    -O0

TARGET_FLAGS := -mcpu=cortex-m0 \
                -mthumb \
                -mfpu=fpv4-sp-d16 \
                -mfloat-abi=soft

WG :=           -Wall \
                -Wextra \
                -Wpedantic \
                -Werror

WCC :=          -Wconversion \
                -Wsign-conversion \
                -Wsign-compare \
                -Wcast-align=strict \
                -Wfloat-equal \
                -Wlogical-op

C_SRC :=        read.c \
                write.c
C_INC :=        $(addprefix -I, $(INC_DIR))
C_FLAGS  :=     $(TARGET_FLAGS) \
                $(OPT_LEVEL) \
                $(WG) \
                $(WCC) \
                $(C_INC)

OBJ :=          $(addprefix $(OBJ_DIR)/, $(C_SRC:.c=.o))

ARCHIVE :=      ./lib$(NAME).a

VPATH :=        $(SRC_DIR)

.PHONY: all build clean debug rebuild test keil

all: $(MKDIR) $(ARCHIVE)

build: all

clean:
	-rm -rf $(MKDIR) $(ARCHIVE)

debug: DBG_LEVEL += -g3
debug: rebuild

rebuild: clean all

$(MKDIR):
	mkdir -p $@

$(OBJ_DIR)/%.o: %.c
	$(CC) $(C_FLAGS) \
        $(DBG_LEVEL) \
        -c $< \
        -o $@

$(ARCHIVE): $(OBJ)
	$(AR) rcs $@ $^
	$(SIZE) $@

keil: C_FLAGS += -fshort-wchar
keil: rebuild
