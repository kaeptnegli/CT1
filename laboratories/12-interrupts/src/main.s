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
//     File:      main.s
//
//     Purpose:   Reading the user button as interrupt source
//
//     Author(s): <{akdi,scbj}@zhaw.ch>
//
//     Date:      05/2020
//                02/2026
//
//  ############################################################
//

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb

// -----------------------------------------------------------------------------
// -- Imports
// -----------------------------------------------------------------------------
.global init_measurement
.global clear_IRQ_EXTI0
.global clear_IRQ_TIM2

// -----------------------------------------------------------------------------
// -- Exports
// -----------------------------------------------------------------------------
.global main
.global EXTI0_IRQHandler
.global TIM2_IRQHandler

// -----------------------------------------------------------------------------
// -- Constants
// -----------------------------------------------------------------------------
.equ ADDR_LED_15_0,     0x60000100
.equ ADDR_LED_16_31,    0x60000102
.equ ADDR_7SEG,         0x60000114
.equ ADDR_SETENA0,      0xE000E100

// -----------------------------------------------------------------------------
// -- Variables
// -----------------------------------------------------------------------------
.section .my_var,"aw"

// STUDENTS: To be programmed



// END: To be programmed


// -----------------------------------------------------------------------------
// -- Main
// -----------------------------------------------------------------------------
.section .my_code,"ax"

.type main, %function
main:
        bl      init_measurement

        // Configure NVIC (enable interrupt channel)
        // STUDENTS: To be programmed



        // END: To be programmed

        // Initialize variables
        // STUDENTS: To be programmed



        // END: To be programmed

loop:
        // Output counter on 7-seg
        // STUDENTS: To be programmed



        // END: To be programmed

        b       loop

        .balign 4


// -----------------------------------------------------------------------------
// Handler for EXTI0 interrupt
// -----------------------------------------------------------------------------
        // STUDENTS: To be programmed



        // END: To be programmed
        .balign 4

// -----------------------------------------------------------------------------
// Handler for TIM2 interrupt
// -----------------------------------------------------------------------------
        // STUDENTS: To be programmed



        // END: To be programmed
        .balign 4

// -----------------------------------------------------------------------------
// -- End of file
// -----------------------------------------------------------------------------
        .end
