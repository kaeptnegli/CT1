/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Project     : CT - Slides for architecture
 * -- Description : Show the use of different variables
 * --               --> in which sections are they located?
 * --                       |.text|   --> code
 * --                       |.bss|    --> uninitialized data
 * --                       |.data|   --> initialized data
 * --
 * -- $Id: main.c 371 2014-07-24 06:28:41Z ruan $
 * ------------------------------------------------------------------
 */

#include <stdint.h>

// initialized global variables     --> |.data|
uint32_t  g_init_var = 0x4D5E6F70;

// UN-initialized global variables  --> |.data|
// DCB, DCW, DCD and initialized to zero
// ??? if the variables are not used in an assignment, then the compiler
// ??? will produce a .bss section
uint32_t  g_noinit_var;

// global constants                 --> |.constdata|
const uint32_t g_const = 0xDDEEFF00;

/*!
 *   \brief example function to demonstrate the use of different variables
 */
void show_variables(void)
{
    // local variables --> registers
    uint32_t local_var;

    // local constants
    const uint32_t local_const = 0x7261504F;

    // locally defined variables with qualifier static
    static uint32_t static_local_var;

    // initialize local variables with literals
    local_var = 0xD4E5F607;

    // write un-initialized global variables
    g_noinit_var  = local_var;

    // use local constants and static variables
    static_local_var = local_const;

    // use local static variables
    local_var = static_local_var;
}

/*!
 *   \brief when the address operator is used on a local variable
 *          the local variable needs to be allocated on the stack
 */
void show_local_variables_on_stack(void)
{
    // local variables --> registers
    uint32_t local_var;

    uint32_t local_s;
    uint32_t *pointer;

    // initialize local variable with literal
    local_var = 0xD4E5F607;

    pointer = &local_s;       // address operator causes the variable
                              // local32_s to be allocated on the stack
                              // instead of in a register
    *pointer = local_var;
}
