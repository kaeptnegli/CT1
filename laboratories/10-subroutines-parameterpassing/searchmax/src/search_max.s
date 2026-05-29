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
//     File:      search_max.s
//
//     Purpose:   search max
//
//     Author(s): <{muln,scbj}@zhaw.ch>
//
//     Date:      10/2014
//                02/2026
//
//  ############################################################
//

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb

// -------------------------------------------------------------------
// -- Exports
// -------------------------------------------------------------------
.global search_max

// -------------------------------------------------------------------
// -- Constants
// -------------------------------------------------------------------
.section .my_code,"ax"

// STUDENTS: To be programmed



// END: To be programmed


// Searchmax
// - tableaddress in R0
// - table length in R1
// - result returned in R0
.type search_max, %function
search_max:
                // STUDENTS: To be programmed



                // END: To be programmed
                .balign 4

// -------------------------------------------------------------------
// -- End of file
// -------------------------------------------------------------------
                .end

