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
//     Purpose:   multiplication 32 bits unsigned
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
.global mul_u32

// -------------------------------------------------------------------
// -- symbol import
// -------------------------------------------------------------------
.global display_title
.global tests_32x32

// -------------------------------------------------------------------
// -- defines
// -------------------------------------------------------------------
.equ NR_OF_TESTS,       8

// -------------------------------------------------------------------
// -- code
// -------------------------------------------------------------------
.section .my_code, "ax"

.type mul_u32, %function
mul_u32:
        push    {r1-r3, lr}

        ldr     r0, =title
        bl      display_title

        ldr     r3, =result_table
        ldr     r2, =values
        ldr     r1, =NR_OF_TESTS
        ldr     r0, =operation
        bl      tests_32x32

        pop     {r1-r3, pc}

// -------------------------------------------------------------------
// 32 bit multiplication
// - multiplier in R0
// - multiplicand in R1
// - 64 bit result in R1:R0 (upper:lower)
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
.section .my_const, "a"

values:
        .word       0x00000001
        .word       0xFFFFFFFF
        .quad       0x00000000FFFFFFFF

        .word       0x00001717
        .word       0x00004A4A
        .quad       0x0000000006B352A6

        .word       0x00001717
        .word       0xFFFFFFFF
        .quad       0x00001716FFFFE8E9

        .word       0x73A473A4
        .word       0x4C284C28
        .quad       0x2267066DA5A6C1A0

        .word       0x43F887CC
        .word       0xC33E6ABF
        .quad       0x33D6E1F8E60FC934

        .word       0xE372E372
        .word       0x00340234
        .quad       0x002E354B4C451728

        .word       0x22DDDD22
        .word       0xBCCCDDDE
        .quad       0x19B6D568F3641D7C

        .word       0x7FFFFFFF
        .word       0x7FFFFFFF
        .quad       0x3FFFFFFF00000001

title:
        .string     "mul_u32"

        .balign 4
// -------------------------------------------------------------------
// -- Variables
// -------------------------------------------------------------------
.section .my_var, "aw"

result_table:
        .space      NR_OF_TESTS*8


// -------------------------------------------------------------------
// -- End of file
// -------------------------------------------------------------------
.end
