/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  toggle LEDs
 * --
 * -- Author(s):    <{????,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

#include <stdint.h>
#include "toggle.h"
#include "write.h"

#define LED 0x60000100

static uint8_t value = 0xC6;

void toggle(void)
{
    value ^= ~0;
    write8(LED, value);
}
