/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  multiplication of signed 16 bit numbers
 * --
 * -- Author(s):    <{kesr,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

.syntax unified
.arch armv6-m
.cpu cortex-m0
.eabi_attribute 25, 1
.thumb

// -------------------------------------------------------------------
// -- symbol export
// -------------------------------------------------------------------
.global mul_s16

// -------------------------------------------------------------------
// -- defines
// -------------------------------------------------------------------
.global display_title
.global tests_16x16

// -------------------------------------------------------------------
// -- defines
// -------------------------------------------------------------------
.equ NR_OF_TESTS,     8

// -------------------------------------------------------------------
// -- code
// -------------------------------------------------------------------
.section .text

.type mul_s16, %function
mul_s16:
        push    {r1-r3, lr}

        ldr     r0, =title
        bl      display_title

        ldr     r3, =result_table
        ldr     r2, =values
        ldr     r1, =NR_OF_TESTS
        ldr     r0, =operation
        bl      tests_16x16

        pop     {r1-r3, pc}

// -------------------------------------------------------------------
// 16 bit multiplication
// - multiplier in R0
// - multiplicand in R1
// - 32 bit result in R0
// -------------------------------------------------------------------
.type operation, %function
operation:
        push    {r4-r7, lr}

        // instruction: do not use high registers in your code,
        // or make sure they contain thier original values
        // when the function returns

        // STUDENTS: To be programmed



        // END: To be programmed

        pop     {r4-r7, pc}            // return r0

        .balign 4

// -------------------------------------------------------------------
// -- Constants
// -------------------------------------------------------------------
.section .rodata

values:
        .hword      0x0001
        .hword      0xFFFF
        .word       0xFFFFFFFF

        .hword      0x0017
        .hword      0x004A
        .word       0x000006A6

        .hword      0xFFFF
        .hword      0xFFFF
        .word       0x00000001

        .hword      0x73A4
        .hword      0x4C28
        .word       0x2266C1A0

        .hword      0x43CC
        .hword      0xC3BF
        .word       0xF00AF934

        .hword      0xE372
        .hword      0x0234
        .word       0xFFC11728

        .hword      0xDD22
        .hword      0xBCDE
        .word       0x0924BB7C

        .hword      0x7FFF
        .hword      0x7FFF
        .word       0x3FFF0001

title:
        .string     "mul_s16"

        .balign 4

// -------------------------------------------------------------------
// -- Variables
// -------------------------------------------------------------------
.section .bss

result_table:
        .space      NR_OF_TESTS*4

        .balign 4

// -------------------------------------------------------------------
// -- End of file
// -------------------------------------------------------------------
.end
