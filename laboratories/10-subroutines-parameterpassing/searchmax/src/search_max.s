/* ------------------------------------------------------------------
 * --  _____       ______  _____
 * -- |_   _|     |  ____|/ ____|
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems
 * --   | | | '_ \|  __|  \___ \   Zurich University of
 * --  _| |_| | | | |____ ____) |  Applied Sciences
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland
 * --
 * -- Description:  search maximum value in a table
 * --
 * -- Author(s):    <{muln,scbj}@zhaw.ch>
 * --
 * ------------------------------------------------------------------
 */

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

