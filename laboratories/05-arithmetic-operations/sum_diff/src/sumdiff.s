/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercise for sums and differences
 * --
 * -- Author(s):    <{muln,scbj}@zhaw.ch>
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
.equ ADDR_DIP_SWITCH_7_0,   0x60000200
.equ ADDR_DIP_SWITCH_15_8,  0x60000201
.equ ADDR_LED_7_0,          0x60000100
.equ ADDR_LED_15_8,         0x60000101
.equ ADDR_LED_23_16,        0x60000102
.equ ADDR_LED_31_24,        0x60000103

// ------------------------------------------------------------------
// -- myCode
// ------------------------------------------------------------------
.section .my_code, "ax"

main:

user_prog:
        // STUDENTS: To be programmed



        // END: To be programmed
        b       user_prog

        .balign 4
// ------------------------------------------------------------------
// End of code
// ------------------------------------------------------------------
        .end
