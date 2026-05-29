//  ############################################################
//
//       o                    *
//                    *              o
//            |
//           -O-                         =( =         +
//      +     |                   *
//                   ____     ________
//                  /  _/__  / __/ __/    .
//                 _/ // _ \/ _/_\ \             +  .
//        *       /___/_//_/___/___/             |
//                                       -O-         @
//      +                                |
//                      *
//                   ,      .
//           .    `
//       @                +    `~---~~`           *
//
//     Institute of Embedded Systems
//     Zurich University of Applied Sciences
//     8401 Winterthur, Switzerland
//
//     File:      main.s
//
//     Purpose:   multiplication and division
//
//     Author(s): <{kesr,scbj}@zhaw.ch>
//
//     Date:      11/2016
//                03/2026
//
//  ############################################################

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb

// -------------------------------------------------------------------
// -- symbol export
// -------------------------------------------------------------------
.global main
.global tests_16x16
.global tests_32x32
.global display_title

// -------------------------------------------------------------------
// -- symbol import
// -------------------------------------------------------------------
.global mul_u16
.global mul_s16
.global mul_u32

// -------------------------------------------------------------------
// -- defines
// -------------------------------------------------------------------
.equ ADDR_BUTTONS,      0x60000210
.equ ADDR_LCD_ASCII,    0x60000300
.equ ADDR_7SEG,         0x60000110
.equ ADDR_LED,          0x60000100

.equ MSG_FAIL,          0x8e88f9c7  // 7 segment low-active bits of "FAIL"
.equ MSG_PASS,          0x8c889292  // 7 segment low-active bits of "PASS"
.equ MSG_CLEAR,         0x7f7f7f7f  // 7 segment low-active bits of dots only

// -------------------------------------------------------------------
// -- constants
// -------------------------------------------------------------------
.section .my_const, "a"

// -------------------------------------------------------------------
// -- code
// -------------------------------------------------------------------
.section .my_code, "ax"

.type main, %function
main:
        bl      outcome_clear
wait_for_button:
        ldr     r0, =ADDR_BUTTONS       // read buttons
        ldrb    r1, [r0]
        ldr     r0, =mul_u16
        lsrs    r1, #1                  // test for t0
        bcs     load_proc               // and branch if pressed
        ldr     r0, =mul_s16
        lsrs    r1, #1                  // test for t1
        bcs     load_proc               // and branch if pressed
        ldr     r0, =mul_u32
        lsrs    r1, #1                  // test for t2
        bcc     next                    // and branch if pressed
load_proc:
        bl      outcome_clear
        blx     r0
        bl      outcome
next:
        b       wait_for_button         // wait for next button

// -------------------------------------------------------------------
// -- tests_16x16
// R0 = operation (R0,R1) returning R0
// R1 = number of array elements
// R2 = array of {DCW arg1, DCW arg2, DCD expected_result} values
// R3 = actual results table
// returns R0 = error mask
// -------------------------------------------------------------------
.type tests_16x16, %function
tests_16x16:
        push    {r4-r7, lr}

        mov     r8, r0  // operation
        mov     r9, r1  // #tests
        mov     r10, r2 // values base
        mov     r11, r3 // results table

        // r0,r1 = operation arguments
        // r0    = return value
        // r2    = expected result
        // r3    = unused
        // r4    = table base address
        // r5    = table element offset
        // r6    = error mask
        // r7    = test index
        // r8    = number of tests

        movs    r6, #0
        movs    r7, #0
        b       check_end16

next_test16:
        // get operands and execute operation
        lsls    r5, r7, #3
        mov     r4, r10
        adds    r4, r5
        ldrh    r0, [r4, #0] // arg1
        ldrh    r1, [r4, #2] // arg2
        ldr     r4, [r4, #4] // expected result
        blx     r8
        mov     r2, r4
        // store actual result
        lsls    r5, r7, #2
        mov     r4, r11
        str     r0, [r4, r5]
        // compare expected versus actual result and update error mask
        lsls    r6, #1
        cmp     r2, r0
        beq     passed16
        adds    r6, #1
passed16:
        // next test
        adds    r7, #1
check_end16:
        cmp     r7, r9
        blo     next_test16

        // return error_mask
        movs    r0, r6
        pop     {r4-r7, pc}

// -------------------------------------------------------------------
// -- tests_32x32
// R0 = operation (R0,R1) returning R0
// R1 = number of array elements
// R2 = array of {DCD arg1, DCD arg2, DCQ expected_result} values
// R3 = actual results table
// returns R0 = error mask
// -------------------------------------------------------------------
.type tests_32x32, %function
tests_32x32:
        push    {r4-r7, lr}

        mov     r8, r0  // operation
        mov     r9, r1  // #tests
        mov     r10, r2 // values base
        mov     r11, r3 // results table

        // r0,r1 = operation arguments
        // r1:r0 = return value
        // r3:r2 = expected result
        // r4    = table base address
        // r5    = table element offset
        // r6    = error mask
        // r7    = test index
        // r8    = number of tests

        movs    r6, #0
        movs    r7, #0
        b       check_end32

next_test32:
        // get operands and execute operation
        lsls    r5, r7, #4
        mov     r4, r10
        adds    r4, r5
        ldr     r0, [r4, #0]  // arg1
        ldr     r1, [r4, #4]  // arg2
        ldr     r5, [r4, #12] // expected result r5:r4
        ldr     r4, [r4, #8]  //
        blx     r8
        mov     r2, r4
        mov     r3, r5
        // store actual result
        lsls    r5, r7, #3
        mov     r4, r11
        adds    r4, r5
        str     r0, [r4, #0]
        str     r1, [r4, #4]
        // compare expected versus actual result and update error mask
        lsls    r6, #1
        cmp     r2, r0
        bne     failed32
        cmp     r3, r1
        bne     failed32
        b       inc32

failed32:
        adds    r6, #1

inc32:
        // next test
        adds    r7, #1

check_end32:
        cmp     r7, r9
        blo     next_test32

        // return error_mask
        movs    r0, r6
        pop     {r4-r7, pc}

// -------------------------------------------------------------------
// -- void display_title(title)
// -------------------------------------------------------------------
.type display_title, %function
display_title:
        push {r5-r7, lr}
        ldr  r7, =ADDR_LCD_ASCII
        movs r6, #0  // index to the title character
        b    check_eot

more_text:
        strb r5, [r7, r6]
        adds r6, #1

check_eot:
        ldrb r5, [r0, r6]
        cmp  r5, #0
        bne  more_text
        pop  {r5-r7, pc}

// -------------------------------------------------------------------
// -- void outcome_clear()
// -------------------------------------------------------------------
.type outcome_clear, %function
outcome_clear:
        push    {r0-r1, lr}

        movs    r0, #0
        ldr     r1, =ADDR_LED
        str     r0, [r1]

        ldr     r0, =MSG_CLEAR
        ldr     r1, =ADDR_7SEG
        str     r0, [r1]

        pop     {r0-r1, pc}

// -------------------------------------------------------------------
// -- void outcome(uint32_t mask_of_failed_tests)
// -------------------------------------------------------------------
outcome:
        push    {r0-r1, lr}

        ldr     r1, =ADDR_LED
        str     r0, [r1]

        cmp     r0, #0
        bne     if_failed
        ldr     r0, =MSG_PASS
        b       endif_failed

if_failed:
        ldr     r0, =MSG_FAIL

endif_failed:
        ldr     r1, =ADDR_7SEG
        str     r0, [r1]

        pop     {r0-r1, pc}

// -------------------------------------------------------------------
// -- End of file
// -------------------------------------------------------------------
        .balign 4
        .end

