/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  utilities for interrupt laboratory
 * --
 * -- Author(s):    <{ruan,scbj}@zhaw.ch>
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
.global set_sfr
.global clear_sfr


.section .text
// -----------------------------------------------------------------------------
// Set bit of a register (SFR, word -> 32 bit)
// - Address of register in R6
// - Bits to be set in R7
// -----------------------------------------------------------------------------
.type set_sfr, %function
set_sfr:
        push {lr}

        ldr  r2, [r0]           // load register value to r0
        orrs r2, r2, r1         // set bits
        str  r2, [r0]           // store new register value

        pop  {pc}               // restore registers and return

// -----------------------------------------------------------------------------
// Clear all bits of a register (SFR, word -> 32 bit)
// - Address of register in R0
// - Bits to be cleared in R1
// -----------------------------------------------------------------------------
.type clear_sfr, %function
clear_sfr:
        push {lr}

        ldr  r2, [r0]           // load register value to r0
        bics r2, r2, r1         // clear bits
        str  r2, [r0]           // store new register value

        pop  {pc}               // restore registers and return

// -----------------------------------------------------------------------------
// -- End of file
// -----------------------------------------------------------------------------
        .end

