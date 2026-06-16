/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercise on linker
 * --
 * -- Author(s):    <{????,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

// Tasks when working with Keil:
// build the program to see the error messages
//
// 1.   fix include path error. change project settings for C/C++ and
//      add `.\inc` to include path.
// 2.   insert missing includes in `main.c`.
// 3.   change settings for the linker and add the library with
//      `lib\read_write`.
// 4.   fix remaining errors.

// Tasks when working with Makefile:
// build the program to see the error messages
//
// 1.   add `./inc` to the include paths in the makefile.
// 2.   insert missing includes in `main.c`.
// 3.   add `./lib/libctio.a` to the linker arguments in the makefile.
// 4.   fix remaining errors.


#include <stdint.h>

// add missing includes
/// STUDENTS: To be programmed



/// END: To be programmed

#define BUTTONS 0x60000210
#define T0      (1 << 0)

static uint8_t last = 0;

int main()
{
    while(1) {
        uint8_t buttons = read8(BUTTONS);
        uint8_t pressed_T0 = (~last & buttons) & T0;
        last = buttons;

        if (pressed_T0) {
            toggle();
        }
    }
}
