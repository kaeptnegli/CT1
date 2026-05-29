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
//     File:      add64.s
//
//     Purpose:   64 bit addition on 32 bit architecture
//
//     Remarks:   -
//
//     Author(s): <{kesr,scbj}@zhaw.ch>
//
//     Date:      10/2016
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
.equ ADDR_DIP_SWITCH_31_0,  0x60000200
.equ ADDR_BUTTONS,          0x60000210
.equ ADDR_LCD_RED,          0x60000340
.equ ADDR_LCD_GREEN,        0x60000342
.equ ADDR_LCD_BLUE,         0x60000344
.equ ADDR_LCD_BIN,          0x60000330
.equ MASK_KEY_T0,           0x00000001
.equ BACKLIGHT_FULL,        0xffff

// ------------------------------------------------------------------
// -- myCode
// ------------------------------------------------------------------
.section my_code, "ax"

main:

user_prog:
        ldr     r7, =ADDR_LCD_BLUE              // load base address of pwm blue
        ldr     r6, =BACKLIGHT_FULL             // backlight full blue
        strh    r6, [r7]                        // write pwm register

        ldr     r0, =0                          // lower 32 bits of total sum
        ldr     r1, =0                          // higher 32 bits of total sum
endless:
        bl      waitForKey                      // wait for key T0 to be pressed

        // STUDENTS: To be programmed



        // END: To be programmed
        b       endless

        .balign 4


//----------------------------------------------------
// Subroutines
//----------------------------------------------------

// wait for key to be pressed and released
waitForKey:
        push    {r0, r1, r2}
        ldr     r1, =ADDR_BUTTONS               // laod base address of keys
        ldr     r2, =MASK_KEY_T0                // load key mask T0

waitForPress:
        ldrb    r0, [r1]                        // load key values
        tst     r0, r2                          // check, if key T0 is pressed
        beq     waitForPress

waitForRelease:
        ldrb    r0, [r1]                        // load key values
        tst     r0, r2                          // check, if key T0 is released
        bne     waitForRelease

        pop     {r0, r1, r2}
        bx      lr

        .balign 4

// ------------------------------------------------------------------
// End of code
// ------------------------------------------------------------------
        .end
