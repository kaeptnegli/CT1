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
 * ------------------------------------------------------------------
 */
#include <stdlib.h>
#include "utils_ctboard.h"

#define ADDR_DIP_SWITCH_31_0 ((uint32_t) 0x60000203)
#define ADDR_DIP_SWITCH_7_0  ((uint32_t) 0x60000200)
#define ADDR_DIP_SWITCH_P11  ((uint32_t) 0x60000211)
#define ADDR_LED_31_24       ((uint32_t) 0x60000103)
#define ADDR_LED_23_16       ((uint32_t) 0x60000102)
#define ADDR_LED_15_8        ((uint32_t) 0x60000101)
#define ADDR_LED_7_0         ((uint32_t) 0x60000100)
#define ADDR_BUTTONS         ((uint32_t) 0x60000210)
#define ADDR_DISPLAY_DS0     ((uint32_t) 0x60000110)
#define ADDR_DISPLAY_DS1     ((uint32_t) 0x60000111)
#define ADDR_DISPLAY_DS2     ((uint32_t) 0x60000112)
#define ADDR_DISPLAY_DS3     ((uint32_t) 0x60000113)

int main(void) 
{
	const uint8_t display_num[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
	uint8_t num = 0x0;
	while(1)
	{
	num = read_byte(ADDR_DIP_SWITCH_P11) & 0x0F;
	write_byte(ADDR_LED_7_0, num);
	write_byte(ADDR_DISPLAY_DS0, ~display_num[num]);
	write_byte(ADDR_DISPLAY_DS1, ~display_num[num]);
	}
}


/// END: To be programmed

