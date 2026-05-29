//
//  ############################################################
//
//                             +
//                ---====D                        @
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
//                   *       .            o         +
//
//
//     Institute of Embedded Systems
//     Zurich University of Applied Sciences
//     8401 Winterthur, Switzerland
//
//     File:      transbf.s
//
//     Purpose:   IO of values which
//                are stored in a table.
//
//     Remarks:   -
//
//     Author(s): <{muln,scbj}@zhaw.ch>
//
//     Date:      09/2014
//                01/2026
//
//  ############################################################
//

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb
.type main, %function
.global main


// ------------------------------------------------------------------
// -- Symbolic Literals
// ------------------------------------------------------------------
.equ MY_CONST,                0x12
.equ ADDR_DIP_SWITCH_31_0,    0x60000200
.equ ADDR_LED_31_0,           0x60000100

// ------------------------------------------------------------------
// -- Variables
// ------------------------------------------------------------------
.section .my_var,"ax"

store_table:
    .space  16  // reserve 16 byte (4 words)

.balign 4

// ------------------------------------------------------------------
// -- Constants
// ------------------------------------------------------------------
.section .my_const,"a"

addr_dip_switch:
    .word   0x60000200

const_table:
    .word   0x01234567, 0x12345678, 0x99996666, 0x34567890

.balign 4

// ------------------------------------------------------------------
// -- MyCode
// ------------------------------------------------------------------
.section .my_code, "ax"
.balign 4

main:
        // mov/movs instruction, loading constants
        movs    r1,  #0xFE                       // ***A1***
        mov     r10, r1
        movs    r2,  #MY_CONST
        mov     r11, r2                          // ***A2***

        // load value of dip switches to r4
        ldr     r3,  =ADDR_DIP_SWITCH_31_0       // ***A3***
        ldr     r4,  [r3]

        // ldr literal, load value of addr_dip_switch to r7
        ldr     r7,  =addr_dip_switch
        ldr     r7,  [r7]                        // ***A4***
        ldr     r0,  [r7]

        // write value of dip switches to LEDs
        ldr     r6,  =ADDR_LED_31_0
        str     r0,  [r6]

        // ldr pseudo instruction, load address of addr_dip_switch to r7
        ldr     r7,  =addr_dip_switch            // ***A5***
        ldr     r7,  [r7]
        ldr     r0,  [r7]

        // write address of dip switches to LEDs
        ldr     r6,  =ADDR_LED_31_0
        str     r0,  [r6]

        // read values from const_table
        ldr     r7,  =const_table
        ldr     r0,  [r7]
        ldr     r1,  [r7, #4]                    // ***A6***
        movs    r6,  #8
        ldr     r2,  [r7, r6]
        movs    r6,  #12
        ldr     r3,  [r7, r6]                    // ***A7***

        // write values to store_table
        ldr     r7,  =store_table
        str     r0,  [r7]
        str     r1,  [r7,#4]
        movs    r6,  #8
        str     r2,  [r7, r6]
        movs    r6,  #12
        str     r3,  [r7, r6]

        // write third value from store_table to leds
        movs    r1,  #8
        ldr     r7,  =store_table
        ldr     r0,  [r7, r1]
        ldr     r6,  =ADDR_LED_31_0
        str     r0,  [r6]

        b       main

        .balign 4

// ------------------------------------------------------------------
// End of code
// ------------------------------------------------------------------
        .end
