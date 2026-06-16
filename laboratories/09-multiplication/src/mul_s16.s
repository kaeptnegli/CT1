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
.cpu cortex-m4
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
.section .my_code, "ax"

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



