/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  laboratory to examine bit manipulations
 * --
 * -- Author(s):    <{ruan}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

#include "utils_ctboard.h"

#define ADDR_DIP_SWITCH_31_0 ((uint32_t) 0x60000200)
#define ADDR_DIP_SWITCH_7_0  ((uint32_t) 0x60000200)
#define ADDR_LED_31_24       ((uint32_t) 0x60000103)
#define ADDR_LED_23_16       ((uint32_t) 0x60000102)
#define ADDR_LED_15_8        ((uint32_t) 0x60000101)
#define ADDR_LED_7_0         ((uint32_t) 0x60000100)
#define ADDR_BUTTONS         ((uint32_t) 0x60000210)

#define OR_MASK              ((uint8_t) 0b11000000)
#define AND_MASK             ((uint8_t) 0b11111100)
#define MASK_UPPER_FOUR      ((uint8_t) 0b11110000)
#define CHECK_TO             ((uint8_t) 0b00000001)
#define CHECK_T1             ((uint8_t) 0b00000010)
#define CHECK_T2             ((uint8_t) 0b00000100)
#define CHECK_T3             ((uint8_t) 0b00001000)

// define your own macros for bitmasks below (#define)
/// STUDENTS: To be programmed



/// END: To be programmed

int main(void)
{
    uint8_t led_value = 0;
    uint8_t buttons_counter = 1;
    uint8_t current_state = 0;
    uint8_t old_state = 0;
    uint8_t edges = 0;

    while (1) {
        // ---------- Task 1 ----------
        led_value = read_byte(ADDR_DIP_SWITCH_7_0);
        led_value |= OR_MASK; // enable the upper two bits
	led_value &= AND_MASK; // disable lower two bits
			       

        write_byte(ADDR_LED_7_0, led_value);

        // ---------- Task 2 and Task 3 ----------
	current_state = read_byte(ADDR_BUTTONS) & 0x0F;
	edges = current_state & ~old_state;
	old_state = current_state;
       	
	if (CHECK_TO & edges) {
	    //buttons_counter++;
	    buttons_counter = buttons_counter >> 1;
	} else if (CHECK_T1 & edges) {
	    buttons_counter = buttons_counter << 1;
	} else if (CHECK_T2 & edges) {
	    buttons_counter = ~buttons_counter; 
	} else if (CHECK_T3 & edges) {
            write_byte(ADDR_LED_23_16, buttons_counter);
	}

        write_byte(ADDR_LED_15_8, buttons_counter);
    }
}
