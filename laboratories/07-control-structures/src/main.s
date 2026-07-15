/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  laboratory on switch/case in assembly
 * --
 * -- Author(s):    <{kesr,scbj}@zhaw.ch>
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
/*
 * NOTE: Least significant bit determines the instruction set after a
 * jump. The directive `.thumb` at the beginning of the file tells the
 * assembler, that this file should be translated into thumb
 * instructions. Unfortunately the GNU assembler only regards this
 * option for instructions, not labels. Thus one needs to tell the
 * assembler explicitly to translate labels into thumb mode (LSB = 1).
 * This is done with the directive `.thumb_func` which affects just
 * the next symbol.
 *
 * Alternatively one can manually add one to the label:
 * ```AS
 * .word case_add + 1
 * .word case_sub + 1
 * ```
 */

.thumb_func
    .word   case_dark

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

.thumb_func
case_dark:
    movs r0, #0
    b    display_result

.thumb_func
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

