/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercises for branch instructions
 * --
 * -- Author(s):    <{akdi,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

.syntax unified
.eabi_attribute 25, 1
.arch armv6-m
.cpu cortex-m0
.thumb
.type main, %function
.global main

// ------------------------------------------------------------------
// -- Address Defines
// ------------------------------------------------------------------

.equ ADDR_LED_15_0,         0x60000100
.equ ADDR_LED_31_16,        0x60000102
.equ ADDR_DIP_SWITCH_7_0,   0x60000200
.equ ADDR_DIP_SWITCH_15_8,  0x60000201
.equ ADDR_7_SEG_BIN_DS3_0,  0x60000114
.equ ADDR_BUTTONS,          0x60000210

.equ ADDR_LCD_RED,          0x60000340
.equ ADDR_LCD_GREEN,        0x60000342
.equ ADDR_LCD_BLUE,         0x60000344
.equ LCD_BACKLIGHT_FULL,    0xffff
.equ LCD_BACKLIGHT_OFF,     0x0000

// ------------------------------------------------------------------
// -- myCode
// ------------------------------------------------------------------
.section .my_code,"ax"

main:
        movs    r6, #0xFF                   // load a pathological value
        movs    r7, #0                      // reset register

main_loop:
// STUDENTS: To be programmed



// END: To be programmed

        b       main_loop

//----------------------------------------------------
// Subroutines
//----------------------------------------------------

// pause for disco_lights
.type pause, %function
pause:
        push    {r0, r1}
        movs    r1, #1
        ldr     r0, =0x00300000

loop:
        subs    r0, r1
        bcs     loop

        pop     {r0, r1}
        bx      lr

        .balign 4

// ------------------------------------------------------------------
// End of code
// ------------------------------------------------------------------
        .end
