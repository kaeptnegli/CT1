/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercises for modular programming
 * --
 * -- Author(s):    <{kesr,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb
.type main, %function
.global main

// ------------------------------------------------------------------
// -- defines
// ------------------------------------------------------------------
.equ ADDR_DIP_SWITCHES,         0x60000200
.equ ADDR_BUTTONS,              0x60000210
.equ ADDR_LED_31_0,             0x60000100
.equ ADDR_7SEG,                 0x60000114
.equ ADDR_LCD_COLOUR,           0x60000340
.equ ADDR_LCD_ASCII,            0x60000300
.equ ADDR_LCD_ASCII_BIT_POS,    0x60000302
.equ ADDR_LCD_ASCII_2ND_LINE,   0x60000314

// value for clearing lcd
.equ ASCII_DIGIT_CLEAR,         0x00000000
.equ LCD_LAST_OFFSET,           0x00000028

// offset for showing the digit in the lcd
.equ ASCII_DIGIT_OFFSET,        0x00000030

// lcd background colors to be written
.equ LCD_RED,                   0
.equ LCD_GREEN,                 2
.equ LCD_BLUE,                  4

// ------------------------------ = ---------------------------------
// -- symbol import
// ------------------------------------------------------------------
.global adc_init
.global adc_get_value

// ------------------------------------------------------------------
// -- symbol export
// ------------------------------------------------------------------
.global main

// ------------------------------------------------------------------
// -- constant declarations
// ------------------------------------------------------------------
.section .my_const, "a"
DISPLAY_BIT:    .string     "Bit "
DISPLAY_2_BIT:  .string     "2"
DISPLAY_4_BIT:  .string     "4"
DISPLAY_8_BIT:  .string     "8"

.balign 4

// ------------------------------------------------------------------
// -- code
// ------------------------------------------------------------------
.section .my_code, "ax"

.type main, %function
main:
        bl          adc_init
        bl          clear_lcd

main_loop:
// STUDENTS: To be programmed



// END: To be programmed
        b           main_loop

.type clear_lcd, %function
clear_lcd:
        push        {r0, r1, r2}
        ldr         r0, =ADDR_LCD_ASCII
        ldr         r1, =LCD_LAST_OFFSET
        ldr         r2, =ASCII_DIGIT_CLEAR

clear_lcd_loop:
        subs        r1, #4                          // decrease offset
        str         r2, [r0, r1]                    // reset character
        bgt         clear_lcd_loop                  // loop if (offset > 0)
        pop         {r0, r1, r2}
        bx          lr

.type clear_lcd, %function
write_bit_ascii:
        push        {r0, r1}
        ldr         r0, =ADDR_LCD_ASCII_BIT_POS
        ldr         r1, =DISPLAY_BIT
        ldr         r1, [r1]
        str         r1, [r0]
        pop         {r0, r1}
        bx          lr

.balign 4
.end
