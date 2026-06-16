/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercise to practice the use of arrays in
 * --               assembly
 * --
 * -- Author(s):    <{ruan,leiu,scbj}@zhaw.ch>
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
// -- constants
// ------------------------------------------------------------------
.equ ADDR_LED_7_0,             0x60000100
.equ ADDR_LED_15_8,            0x60000101
.equ ADDR_LED_23_16,           0x60000102
.equ ADDR_LED_31_24,           0x60000103

.equ ADDR_DIP_SWITCH_7_0,      0x60000200
.equ ADDR_DIP_SWITCH_15_8,     0x60000201
.equ ADDR_DIP_SWITCH_31_24,    0x60000203

.equ ADDR_BUTTONS,             0x60000210

.equ BITMASK_KEY_T0,           0x01
.equ BITMASK_LOWER_NIBBLE,     0x0F

// ------------------------------------------------------------------
// -- Variables
// ------------------------------------------------------------------
.section .my_var, "aw"
// STUDENTS: To be programmed



// END: To be programmed
.balign 4

// ------------------------------------------------------------------
// -- myCode
// ------------------------------------------------------------------
.section .my_code, "ax"
.balign 4

main:

readInput:
        bl      waitForKey                  // wait for key to be pressed and released

// STUDENTS: To be programmed



// END: To be programmed
        b       readInput
.balign 4

// ------------------------------------------------------------------
// Subroutines
// ------------------------------------------------------------------

// wait for key to be pressed and released
waitForKey:
        push    {r0, r1, r2}
        ldr     r1, =ADDR_BUTTONS           // load base address of keys
        ldr     r2, =BITMASK_KEY_T0         // load key mask T0

waitForPress:
        ldrb    r0, [r1]                    // load key values
        tst     r0, r2                      // check, if key T0 is pressed
        beq     waitForPress

waitForRelease:
        ldrb    r0, [r1]                    // load key values
        tst     r0, r2                      // check, if key T0 is released
        bne     waitForRelease

        pop     {r0, r1, r2}
        bx      lr
.balign 4

// ------------------------------------------------------------------
// End of code
// ------------------------------------------------------------------
.end

