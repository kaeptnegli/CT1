/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercise for subroutines and parameter passing
 * --
 * -- Author(s):    <{muln,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

.syntax unified
.arch armv6-m
.cpu cortex-m0
.eabi_attribute 25, 1
.thumb

// -------------------------------------------------------------------
// -- Exports
// -------------------------------------------------------------------
.global main

// -------------------------------------------------------------------
// -- Constants
// -------------------------------------------------------------------
.section .rodata

sample_table1:
        .word   0x00010000, 0x00011700, 0x00012088, 0x00028fa0
        .word   0x0003f800, 0x0010cb8a, 0x00600d00, 0x009b1b12
sample_table2:
        .word   0x7fffffff, 0x0000004a, 0xff0011ff, 0x4c43af28
        .word   0xc19ac3bf, 0x00000234, 0x1d36bcde, 0x80782bc2
sample_table3:
        .word   0x80000001, 0x8ff804b3, 0x9b4a7786, 0xe77c082b
        .word   0x0ad523bf, 0x4954de1c, 0x7cdee132, 0x7fff6587
sample_table4:
        .word   0x8ff804b3, 0x80000001, 0x9b4a7786, 0xe77c082b
        .word   0xc19ac3bf, 0x80782bc2, 0xb980bcde, 0xa10f7fff

golden_table:
        .word   0x009b1b12, 0x7fffffff, 0x7fff6587, 0xe77c082b

// -------------------------------------------------------------------
// -- Variables
// -------------------------------------------------------------------
.section .bss

result_table:
        .space   4*4                 // Reserve 4 words of memory

// -------------------------------------------------------------------
// -- Defines
// -------------------------------------------------------------------
.section .text

.equ ADDR_BUTTONS,      0x60000210

.equ ADDR_LCD_RED,      0x60000340
.equ ADDR_LCD_GREEN,    0x60000342
.equ ADDR_LCD_BLUE,     0x60000344
.equ ADDR_LCD,          0x60000300

.equ TABLE_LENGTH_0,    0x80000000
.equ NR_OF_TABLES,      0x04
.equ BITMASK_KEY_T0,    0x01

// -------------------------------------------------------------------
// -- Main
// -------------------------------------------------------------------

.type main, %function
main:


clear_disp:
        // init display
        ldr     r1, =ADDR_LCD
        ldr     r2, =0x20202020
        str     r2, [r1, #20]
        strb    r2, [r1, #24]
init_disp:
        ldr     r2, =0x74736554
        str     r2, [r1, #0]
        ldr     r2, =0x75736572
        str     r2, [r1, #4]
        ldr     r2, =0x203A746C
        str     r2, [r1, #8]

wait_for_button:
        // wait for button
        bl    waitForKey

start_test:
        // init counter"tests passed"
        movs r7, #0

        // test return value for table length = 0
        ldr     r0, =sample_table1
        movs    r1, #0
        bl      search_max
        ldr     r1, =TABLE_LENGTH_0
        cmp     r0, r1
        bne     test_tables
        adds    r7, r7, #1

test_tables:
        // search max in sample_table1
        ldr     r0, =sample_table1
        movs    r1, #8
        bl      search_max
        ldr     r6, =result_table
        str     r0, [r6]

        // search max in sample_table2
        ldr     r0, =sample_table2
        movs    r1, #8
        bl      search_max
        adds    r6, r6, #4
        str     r0, [r6]

        // search max in sample_table3
        ldr     r0, =sample_table3
        movs    r1, #8
        bl      search_max
        adds    r6, r6, #4
        str     r0, [r6]

        // search max in sample_table4
        ldr     r0, =sample_table4
        movs    r1, #8
        bl      search_max
        adds    r6, r6, #4
        str     r0, [r6]

check_results:
        // compare results with golden table
        movs    r4, #0
        ldr     r5, =golden_table
        ldr     r6, =result_table

check_next:
        ldr     r0, [r5]
        ldr     r1, [r6]
        cmp     r0, r1
        bne     set_up_next
        adds    r7, r7, #1

set_up_next:
        adds    r4, r4, #1
        adds    r6, r6, #4
        adds    r5, r5, #4
        cmp     r4, #NR_OF_TABLES
        blt     check_next

disp_result:
        // print result
        ldr     r1, =ADDR_LCD
        cmp     r7, #5
        bne     test_fail

        ldr     r2, =0x73736150           // Pass
        str     r2, [r1, #12]
        bl      set_bg_green
        b       wait_for_button

test_fail:
        ldr     r2, =0x6C696146           // Fail
        str     r2, [r1, #12]
        bl      set_bg_red

        b       wait_for_button

// ------------------------------------------------------------------
// Subroutines
// ------------------------------------------------------------------

// wait for key to be pressed and released
.type waitForKey, %function
waitForKey:
        push    {r0, r1, r2, lr}
        ldr     r1, =ADDR_BUTTONS           // laod base address of keys
        ldr     r2, =BITMASK_KEY_T0         // load key mask T0

waitForPress:
        ldrb    r0, [r1]                    // load key values
        tst     r0, r2                      // check, if key T0 is pressed
        beq     waitForPress

waitForRelease:
        ldrb    r0, [r1]                    // load key values
        tst     r0, r2                      // check, if key T0 is released
        bne     waitForRelease

        pop     {r0, r1, r2, pc}


.type set_bg_green, %function
set_bg_green:
        push    {r0, r1, lr}

        ldr     r0, =0
        ldr     r1, =ADDR_LCD_RED
        strh    r0, [r1]
        ldr     r1, =ADDR_LCD_BLUE
        strh    r0, [r1]
        ldr     r1, =ADDR_LCD_GREEN
        ldr     r0, =0xFFFF
        strh    r0, [r1]

        pop     {r0, r1, pc}


.type set_bg_red, %function
set_bg_red:
        push    {r0, r1, lr}

        ldr     r0, =0
        ldr     r1, =ADDR_LCD_GREEN
        strh    r0, [r1]
        ldr     r1, =ADDR_LCD_BLUE
        strh    r0, [r1]
        ldr     r1, =ADDR_LCD_RED
        ldr     r0, =0xFFFF
        strh    r0, [r1]

        pop     {r0, r1, pc}

        .balign 4


// -------------------------------------------------------------------
// -- End of file
// -------------------------------------------------------------------
        .end

