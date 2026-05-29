/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Project     : CT - Architecture
 * -- Description : Exercise
 * --               Where will the variables, constants and literals be
 * --               allocated?
 * --
 * --                 - section CODE
 * --                 - section DATA READONLY
 * --                 - section DATA READWRITE
 * --                 - registers / section STACK
 * --
 * -- The program shows the use of different variables and NOT good
 * -- programming style NOR is the function particularly useful
 * --
 * -- $Id: main.c 371 2014-07-24 06:28:41Z ruan $
 * ------------------------------------------------------------------
 */

#include <stdint.h>

uint32_t a;
uint32_t b = 0x00001000;
const uint32_t c = 0x56;

void myfunc(void)
{
    uint32_t d;
    static uint32_t e;
    const uint32_t f = 0x00000002;

    for (d = 0x1001; d < 0x1111; d++) {
        e = c + f;
        b += e;
    }
    a = b;
}
