/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  testproject targeting ctboard
 * --
 * -- Author(s):    <{akdi}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

#include <reg_ctboard.h>
#include "utils_ctboard.h"

#define ADDR_DIP_SWITCH_31_0 0x60000200
#define ADDR_LED_31_0        0x60000100
#define ADDR_7_SEG_DS0       0x60000110
#define ADDR_HEX_SWITCH      0x60000211

int main(void)
{
    uint32_t switch_value;
    uint8_t turn_switch_value;
    uint8_t seven_seg_value;

    // array allows simple conversion from int to seven-segment code
    const uint8_t seven_seg_patterns[16] = { 0xc0, 0xf9, 0xa4, 0xb0,
                                             0x99, 0x92, 0x82, 0xf8,
                                             0x80, 0x90, 0x88, 0x83,
                                             0xc6, 0xa1, 0x86, 0x8e };

    while (1) {
        // Task 1 - read from dip switches, write to leds

        switch_value = read_word(ADDR_DIP_SWITCH_31_0);
        write_word(ADDR_LED_31_0, switch_value);

        // Task 2 - control of a seven-segment display

        // data in lower bits, remove upper 4 bits
        turn_switch_value = 0x0F & read_byte(ADDR_HEX_SWITCH);

        // convert data to seven segment pattern
        seven_seg_value = seven_seg_patterns[turn_switch_value];

        write_byte(ADDR_7_SEG_DS0, seven_seg_value);
    }
}
