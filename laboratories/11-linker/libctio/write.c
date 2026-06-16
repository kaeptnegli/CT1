/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  write one byte
 * --
 * -- Author(s):    <{????,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

#include "write.h"

void write8(uint32_t to, uint8_t what)
{
    (*((volatile uint8_t*)to)) = what;
}

