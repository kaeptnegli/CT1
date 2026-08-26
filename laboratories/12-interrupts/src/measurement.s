/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  setup of timers and interrupts
 * --
 * -- Author(s):    <{kesr,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

.syntax unified
.arch armv6-m
.cpu cortex-m0
.eabi_attribute 25, 1
.thumb

// -----------------------------------------------------------------------------
// -- Exports
// -----------------------------------------------------------------------------
.global init_measurement
.global clear_IRQ_EXTI0
.global clear_IRQ_TIM2

// -----------------------------------------------------------------------------
// -- Constants
// -----------------------------------------------------------------------------
.equ REG_RCC_AHB1ENR,   0x40023830
.equ REG_RCC_APB1ENR,   0x40023840
.equ REG_RCC_APB2ENR,   0x40023844

.equ REG_GPIOA_PUPDR,   0x4002000C

.equ REG_EXTI_IMR,      0x40013C00
.equ REG_EXTI_RTSR,     0x40013C08
.equ REG_EXTI_PR,       0x40013C14

.equ REG_TIM2_CR1,      0x40000000
.equ REG_TIM2_DIER,     0x4000000C
.equ REG_TIM2_SR,       0x40000010
.equ REG_TIM2_EGR,      0x40000014
.equ REG_TIM2_PSC,      0x40000028
.equ REG_TIM2_ARR,      0x4000002C

// -----------------------------------------------------------------------------
// Initialize EXTI
// -----------------------------------------------------------------------------
.section .text

.type init_measurement, %function
init_measurement:
        push    {lr}

init_exti:
        // Clock configuration
        ldr     r0, =REG_RCC_AHB1ENR
        ldr     r1, =0x1               // Enable GPIOA clock
        bl      set_sfr

        ldr     r0, =REG_RCC_APB2ENR
        ldr     r1, =0x4000            // Enable SYSCFG clock
        bl      set_sfr

        // Input pin configuration (PA.0)
        ldr     r0, =REG_GPIOA_PUPDR
        ldr     r1, =0x2               // Set pin to pull-down mode
        bl      set_sfr

        // Configure EXTI
        ldr     r0, =REG_EXTI_IMR
        ldr     r1, =0x1               // Unmask EXTI0 interrupt
        bl      set_sfr

        ldr     r0, =REG_EXTI_RTSR
        ldr     r1, =0x1               // Trigger on rising edge
        bl      set_sfr

init_timer:
        // Clock configuration
        ldr     r0, =REG_RCC_APB1ENR
        ldr     r1, =0x1               // Enable TIM2 clock
        bl      set_sfr

        // Configure TIM2 frequency
        ldr     r0, =REG_TIM2_PSC
        ldr     r1, =839               // Timer prescaler => 84Mhz / 840 = 100kHz => 10us
        bl      set_sfr

        ldr     r0, =REG_TIM2_ARR
        ldr     r1, =0xFFFFFFFF        // Clear Register first, it gets
        bl      clear_sfr              // initialized with 0xffffffff
        ldr     r1, =199998            // Autoreload value => 99999+1 => 1s
        bl      set_sfr

        ldr     r0, =REG_TIM2_EGR
        ldr     r1, =0x1               // Update TIM2 configuration
        bl      set_sfr

        ldr     r0, =REG_TIM2_DIER
        ldr     r1, =0x1               // Enable interrupt source
        bl      set_sfr

        ldr     r0, =REG_TIM2_CR1
        ldr     r1, =0x1               // Enable TIM2
        bl      set_sfr

        // Return
        pop     {pc}

.type clear_IRQ_EXTI0, %function
clear_IRQ_EXTI0:
        push    {lr}

        ldr     r0, =REG_EXTI_PR
        ldr     r1, =0x1               // clear irq pending bit
        bl      set_sfr

        pop     {pc}

.type clear_IRQ_TIM2, %function
clear_IRQ_TIM2:
        push    {lr}

        ldr     r0, =REG_TIM2_SR
        ldr     r1, =0x1               // Clear irq pending bit
        bl      clear_sfr

        pop     {pc}

// -----------------------------------------------------------------------------
// -- End of file
// -----------------------------------------------------------------------------
        .balign 4
        .end

