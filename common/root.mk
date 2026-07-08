
SHELL           := /usr/bin/env bash

PREFIX          := arm-none-eabi-
CC              := $(PREFIX)gcc
COPY            := $(PREFIX)objcopy
SIZE            := $(PREFIX)size

ifeq ($(OS),Windows_NT)
    GDB         := gdb-multiarch.exe
else
    GDB         := $(PREFIX)gdb
endif

OCD             := openocd

NAME            := application

OPT_LEVEL_CC    := -g \
                   -O0

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
                   $(OPT_LEVEL_CC) \
                   $(VERB_LEVEL) \
                   $(WG) \
                   -Wa,-a,-ad,-alms=$(BIN_DIR)/$(NAME).lst \
                   -x assembler-with-cpp

C_DEF           := $(addprefix -D, $(C_DEF))
C_INC           := $(addprefix -I, $(C_INC))
C_FLAGS         := $(TARGET_FLAGS) \
                   $(OPT_LEVEL_CC) \
                   $(VERB_LEVEL) \
                   $(WG) \
                   $(WCC) \
                   -Wa,-a,-ad,-alms=$(BIN_DIR)/$(NAME).lst \
                   $(C_DEF) \
                   $(C_INC)

FLAGS_FILE      := ./compile_flags.txt

LST_DIR         := $(BIN_DIR)/list-files

LIBCTBOARD      := $(LIB_DIR)/libctboard.a
LIB_PATHS       += $(LIB_DIR)
LIB_NAMES       += ctboard

LINKER_FLAGS    := $(TARGET_FLAGS) \
                   -static \
                   -nostartfiles \
                   $(addprefix -L, $(LIB_PATHS)) \
                   -lm \
                   -lnosys \
                   -Wl,--start-group \
                   $(addprefix -l, $(LIB_NAMES)) \
                   -Wl,--end-group \
                   -specs=nosys.specs \
                   -specs=nano.specs \
                   -Wl,-Map,$(BIN_DIR)/$(NAME).map \
                   -Wl,-e,Reset_Handler \
                   -Wl,--gc-sections

LD_SCRIPT       := $(LIB_DIR)/linker-script.ld
GDB_INIT        := $(COMMON_DIR)/.gdbinit
OCD_CONFIG      := $(COMMON_DIR)/openocd.cfg

OBJ             := $(addprefix $(OBJ_DIR)/, $(AS_SRC:.s=.o)) \
                   $(addprefix $(OBJ_DIR)/, $(C_SRC:.c=.o))

ELF             := $(BIN_DIR)/$(NAME).elf
BIN             := $(basename $(ELF)).bin

MKDIR           := $(OBJ_DIR) \
                   $(BIN_DIR) \
                   $(LST_DIR)

VPATH           := $(SRC_DIR)


.PHONY: all clean clean_all dbgsrv flash launchgdb rebuild test


all: $(LIBCTBOARD) $(MKDIR) $(BIN) $(FLAGS_FILE)


flash: $(MKDIR) $(BIN)
	-$(OCD) -f $(OCD_CONFIG) \
        -c "program $(BIN) verify exit 0x08000000"


dbgsrv: flash
	-$(OCD) -f $(OCD_CONFIG) \
        -c "gdb_port 4500" \
        -c "init; reset run;"


launchgdb: $(ELF) $(BIN) $(GDB_INIT)
	$(GDB) --command=$(GDB_INIT) $<


$(MKDIR):
	mkdir -p $@


#
# The sections have to correspond with the
# sections defined in the linker script who
# are directed to be located in the flash
# memory area.
#
$(BIN): $(ELF)
	$(COPY) --output-target=binary \
           -j .isr_vector \
           -j .stack \
           -j .heap \
           -j .text \
           -j .my_code \
           -j .my_const \
           -j .my_var \
           -j .rodata\
           -j .ARM.extab \
           -j .ARM \
           -j .preinit_array \
           -j .init_array \
           -j .fini_array \
           -j .data \
           -j .ccmram \
           -j .ARM.extab \
           -j .ARM \
           $< $@
	chmod -x $@
	@printf "\n"


$(ELF): $(OBJ)
	$(CC) -o $@ $^ $(LINKER_FLAGS) -T $(LD_SCRIPT)
	chmod -x $@


$(OBJ_DIR)/%.o: %.s
	$(CC) \
        $(AS_FLAGS) \
        -Wa,-a,-ad,-alms=$(LST_DIR)/$*.lst \
        -c $< \
        -o $@


$(OBJ_DIR)/%.o: %.c
	$(CC) \
        $(C_FLAGS) \
        -Wa,-a,-ad,-alms=$(LST_DIR)/$*.lst \
        -c $< \
        -o $@


$(LIBCTBOARD):
	echo "$(LIB_DIR)"
	make -C "$(LIB_DIR)" rebuild


# this is to satisfy clangd (lsp client)
$(FLAGS_FILE):
	@echo "$(C_FLAGS)" | sed 's/ /\n/g' > $@


clean:
	-rm -rf $(MKDIR) $(FLAGS_FILE)


clean_all:: clean


rebuild: clean all


