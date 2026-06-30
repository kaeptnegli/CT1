/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercise for arithmetic operations
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
// -- myCode
// ------------------------------------------------------------------
.section .my_code, "ax"

main:

user_prog:

// Increment/Decrement with ADDS and SUBS
        movs    r1, #0
        adds    r1, r1, #1
        adds    r1, r1, #1
        subs    r1, r1, #1
        subs    r1, r1, #1
        subs    r1, r1, #1
        subs    r1, r1, #1
        subs    r1, r1, #1
        adds    r1, r1, #1
        adds    r1, r1, #1
        adds    r1, r1, #1
        adds    r1, r1, #1
        adds    r1, r1, #1

// ADDS and SUBS (negative, positive, overflow)
        ldr     r0, =0x6A000000
        ldr     r1, =0x2EFFFFFE
        adds    r1, r1, r1
        adds    r0, r0, r1
        adds    r0, r0, r1

        ldr     r0, =0xA1000000
        ldr     r1, =0x5EFFFFFE
        subs    r0, r0, r1
        subs    r0, r0, r1

// ADDS and RSBS vs. SUBS (compare R0 and R2)
        ldr     r0, =0x4A000000
        ldr     r1, =0x2EFFFFFE
        mov     r2, r0

        subs    r0, r0, r1
        rsbs    r1, r1, #0
        adds    r2, r2, r1

// MUL flags and cut-off if result needs more than 32 bits
        ldr     r0, =0x0000E200
        ldr     r1, =0x00002201

        muls    r0, r1, r0
        ldr     r1, =0x00000F20
        muls    r0, r1, r0
        muls    r0, r1, r0

        b       user_prog

        .balign 4

        .end
