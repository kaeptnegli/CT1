/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  utilities for the ctboard
 * --
 * -- Author(s):    <{feur}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

#include <stdint.h>
#include "utils_ctboard.h"

/*
 * See header file
 */
uint8_t read_byte(uint32_t address)
{
    return *((uint8_t *) address);
}

/*
 * See header file
 */
uint16_t read_halfword(uint32_t address)
{
    return *((uint16_t *) address);
}

/*
 * See header file
 */
uint32_t read_word(uint32_t address)
{
    return *((uint32_t *) address);
}

/*
 * See header file
 */
uint64_t read_doubleword(uint32_t address)
{
    return *((uint64_t *) address);
}


/*
 * See header file
 */
void write_byte(uint32_t address, uint8_t data)
{
    *((uint8_t *) address) = data;
}

/*
 * See header file
 */
void write_halfword(uint32_t address, uint16_t data)
{
    *((uint16_t *) address) = data;
}

/*
 * See header file
 */
void write_word(uint32_t address, uint32_t data)
{
    *((uint32_t *) address) = data;
}

/*
 * See header file
 */
void write_doubleword(uint32_t address, uint64_t data)
{
    *((uint64_t *) address) = data;
}
