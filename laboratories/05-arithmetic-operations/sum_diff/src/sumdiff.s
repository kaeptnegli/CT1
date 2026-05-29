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
//
//     File:      table.s
//
//     Purpose:   sum and difference
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
