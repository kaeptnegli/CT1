
SHELL           := /usr/bin/env bash

PREFIX          := arm-none-eabi-
CC              := $(PREFIX)gcc
COPY            := $(PREFIX)objcopy
SIZE            := $(PREFIX)size
AR              := $(PREFIX)ar

NAME            := ctboard

SRC_DIR         := ./device/source \
                   ./hal/source

INC_DIR         := ./device/include \
                   ./hal/include

OBJ_DIR         := ./obj

LIB_DIR         := ./lib

TEMP_DIR        := ./temp

MK_DIR          := $(OBJ_DIR) $(LIB_DIR)

DBG_LEVEL       := -g3
OPT_LEVEL       := -O0

VERBOSITY       :=

TARGET_FLAGS    := -mcpu=cortex-m4 \
                   -mthumb \
                   -mfpu=fpv4-sp-d16 \
                   -mfloat-abi=soft

WG              := -Wall \
                   -Wextra \
                   -Wpedantic \
                   -Werror

WCC             := -Wconversion \
                   -Wsign-conversion \
                   -Wsign-compare \
                   -Wcast-align=strict \
                   -Wfloat-equal \
                   -Wlogical-op

AS_FLAGS        := $(TARGET_FLAGS) \
                   $(DBG_LEVEL) \
                   $(OPT_LEVEL) \
                   $(VERBOSITY) \
                   $(WG) \
                   -x assembler-with-cpp

AS_SRC          := startup.s

C_DEF           := PLATFORM_M0
C_INC           := $(INC_DIR)

C_DEF           := $(addprefix -D, $(C_DEF))
C_INC           := $(addprefix -I, $(C_INC))

C_FLAGS         := $(TARGET_FLAGS) \
                   $(DBG_LEVEL) \
                   $(OPT_LEVEL) \
                   $(VERBOSITY) \
                   $(WG) \
                   $(WCC) \
                   $(C_DEF) \
                   $(C_INC)

C_SRC           := system_ctboard.c \
                   syscalls.c \
                   reg_ctboard.c \
                   reg_stm32f4xx.c \
                   retarget.c \
                   hal_adc.c \
                   hal_ct_lcd.c \
                   hal_ct_seg7.c \
                   hal_dac.c \
                   hal_dma.c \
                   hal_fmc.c \
                   hal_gpio.c \
                   hal_pwr.c \
                   hal_rcc.c \
                   hal_spi.c \
                   hal_systick.c \
                   hal_timer.c

OBJ             := $(addprefix $(OBJ_DIR)/, $(AS_SRC:.s=.o)) \
                   $(addprefix $(OBJ_DIR)/, $(C_SRC:.c=.o))

LIBRARY         := $(LIB_DIR)/lib$(NAME).a

TAR_ARCHIVE     := $(basename $(LIBRARY)).tar.xz
ZIP_ARCHIVE     := $(basename $(LIBRARY)).zip

TAR_CONTENTS    := $(LIBRARY) \
                   startup.s \
                   linker-script.ld \
                   $(shell find device -name "*.h") \
                   $(shell find hal -name "*.h")

VPATH           := $(SRC_DIR)

.PHONY: all build clean rebuild test

all: $(MK_DIR) $(LIBRARY) $(TAR_ARCHIVE) $(ZIP_ARCHIVE)

build: all

clean:
	-rm -rf $(MK_DIR) $(TEMP_DIR)

rebuild: clean all

$(MK_DIR):
	mkdir -p $@

$(OBJ_DIR)/%.o: %.s
	$(CC) $(AS_FLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: %.c
	$(CC) $(C_FLAGS) -c $< -o $@

$(LIBRARY): $(OBJ)
	$(AR) rcs $@ $^
	$(SIZE) $@

$(TAR_ARCHIVE): $(TAR_CONTENTS)
	@tar -cf \
        $@ \
        -a \
        --transform='s|lib/||' \
        --transform='s|.*/source/||' \
        $^
	@tar -xf \
        $@ \
        -C $(LIB_DIR)

$(ZIP_ARCHIVE): $(TAR_ARCHIVE)
	@mkdir -p $(TEMP_DIR)
	@tar -xf $< -C $(TEMP_DIR)
	@pushd $(TEMP_DIR); \
        zip -r "$(shell pwd)/$@" .; \
        popd
	@rm -rf $(TEMP_DIR)
