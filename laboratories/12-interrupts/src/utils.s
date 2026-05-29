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
//     File:      utils.s
//
//     Purpose:   common procedures
//
//     Author(s): <{ruan,scbj}@zhaw.ch>
//
//     Date:      02/2015
//                02/2026
//
//  ############################################################
//

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb

// -----------------------------------------------------------------------------
// -- Exports
// -----------------------------------------------------------------------------
.global set_sfr
.global clear_sfr

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

