#include <stdint.h>
#include "utils_ctboard.h"

void write_byte(uint32_t address, uint8_t data)
{
    uint8_t *pointer;
    pointer = (uint8_t *)address;
    *pointer = data;
}
