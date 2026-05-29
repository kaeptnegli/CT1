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
//     File:      table.s
//
//     Purpose:   IO of values which
//                are stored in a table.
//
//     Remarks:   -
//
//     Author(s): <{kesr,scbj}@zhaw.ch>
//
//     Date:      10/2016
//                11/2025
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
// -- constants
// ------------------------------------------------------------------
.equ ADDR_LED_15_0,           0x60000100
.equ ADDR_LED_31_16,          0x60000102
.equ ADDR_7_SEG_BIN_DS1_0,    0x60000114
.equ ADDR_DIP_SWITCH_15_0,    0x60000200
.equ ADDR_HEX_SWITCH,         0x60000211

.equ NR_CASES,                0xB


// ------------------------------------------------------------------
// -- Variables
// ------------------------------------------------------------------
.section .my_const, "a", %progbits
.balign 4

jump_table:
// NOTE: the labels need to be increased by one.
// this is because the least significant bit determines the
// instruction set after a jump.
// in gnu assembly syntax the compiler unfortunately does not do this
// automatically, even though the instruction set is provided at the
// beginning of the file with `.thumb`
// > alternatively one can remove the `+1` and add `.thumb_func`
// > before each label

    .word   case_dark + 1
// STUDENTS: To be programmed



// END: To be programmed

// ------------------------------------------------------------------
// -- myCode
// ------------------------------------------------------------------
.section .my_code,"ax"
.balign 4

main:

// -------------------------------------------------------------------
// -- Main
// -------------------------------------------------------------------

read_dipsw:
    // STUDENTS: To be programmed



    // END: To be programmed

read_hexsw:                         // read operation into r2 and display on 7seg.
    // STUDENTS: To be programmed



    // END: To be programmed

case_switch:                        // implement switch statement as shown on lecture slide
    // STUDENTS: To be programmed



    // END: To be programmed


    // add the code for the individual cases below
    // - operand 1 in r0
    // - operand 2 in r1
    // - result in r0

case_dark:
    movs r0, #0
    b    display_result

case_add:
    adds r0, r0, r1
    b    display_result

    // STUDENTS: To be programmed



    // END: To be programmed


display_result:  // Display result on LEDs
    // STUDENTS: To be programmed



    // END: To be programmed

    b    read_dipsw

    // -------------------------------------------------------------------
    // -- End of file
    // -------------------------------------------------------------------
    .end

