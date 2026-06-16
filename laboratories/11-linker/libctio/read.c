/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  read one byte
 * --
 * -- Author(s):    <{????,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

#include "read.h"

uint8_t read8(uint32_t from)
{
    return (*((volatile uint8_t*)from));
}
