/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  exercise for interrupts
 * --
 * -- Author(s):    <{akdi,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

.syntax unified
.arch armv6-m
.cpu cortex-m0
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
.section .data

// STUDENTS: To be programmed



// END: To be programmed


// -----------------------------------------------------------------------------
// -- Main
// -----------------------------------------------------------------------------
.section .text

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
