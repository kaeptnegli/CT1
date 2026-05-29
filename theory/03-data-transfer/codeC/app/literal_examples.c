/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Project     : CT - Slides for Data Transfer
 * -- Description : Slides for Data Transfer
 * --
 * -- $Id: main.c 371 2014-07-24 06:28:41Z ruan $
 * ------------------------------------------------------------------
 */

#include <stdint.h>

static uint32_t g;

void lit_example(void) {
    uint32_t a;
    uint32_t b;
    const uint32_t c = 0x04;
    uint32_t *p;

    a = 0x05;
    b = 0xABCDEF12;
    p = &g;

    // avoid compiler warnings
    b = a;
    a = b;
    a = c;
    a = g;
    a = *p;

}
