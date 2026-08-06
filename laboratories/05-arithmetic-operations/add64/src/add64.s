/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  64 bit addition on 32 bit ALU
 * --
 * -- Author(s):    <{kesr,scbj}@zhaw.ch>
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
// -- Symbolic Literals
// ------------------------------------------------------------------
.equ ADDR_DIP_SWITCH_31_0,  0x60000200
.equ ADDR_BUTTONS,          0x60000210
.equ ADDR_LCD_RED,          0x60000340
.equ ADDR_LCD_GREEN,        0x60000342
.equ ADDR_LCD_BLUE,         0x60000344
.equ ADDR_LCD_BIN,          0x60000330
.equ MASK_KEY_T0,           0x00000001
.equ BACKLIGHT_FULL,        0xffff

// ------------------------------------------------------------------
// -- myCode
// ------------------------------------------------------------------
.section .text
.balign 4

main:
        ldr     r7, =ADDR_LCD_BLUE              // load base address of pwm blue
        ldr     r6, =BACKLIGHT_FULL             // backlight full blue
        strh    r6, [r7]                        // write pwm register

        movs    r0, #0                          // lower 32 bits of total sum
        movs    r1, #0                          // higher 32 bits of total sum

endless:
        bl      waitForKey                      // wait for key T0 to be pressed

        // STUDENTS: To be programmed



        // END: To be programmed
        b       endless

        .balign 4


//----------------------------------------------------
// Subroutines
//----------------------------------------------------

// wait for key to be pressed and released
waitForKey:
        push    {r0, r1, r2}
        ldr     r1, =ADDR_BUTTONS               // load base address of keys
        ldr     r2, =MASK_KEY_T0                // load key mask T0

waitForPress:
        ldrb    r0, [r1]                        // load key values
        tst     r0, r2                          // check, if key T0 is pressed
        beq     waitForPress

waitForRelease:
        ldrb    r0, [r1]                        // load key values
        tst     r0, r2                          // check, if key T0 is released
        bne     waitForRelease

        pop     {r0, r1, r2}
        bx      lr

        .balign 4

// ------------------------------------------------------------------
// End of code
// ------------------------------------------------------------------
        .end
