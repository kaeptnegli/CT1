/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Project     : CT - Slides for data transfer
 * -- Description : Show the use of different variables
 * --               --> in which sections are they located?
 * --                       |.text|   --> code
 * --                       |.bss|    --> uninitialized data
 * --                       |.data|   --> initialized data
 * --
 * -- $Id: main.c 514 2014-08-28 11:15:50Z ruan $
 * ------------------------------------------------------------------
 */

#include <stdint.h>

// initialized global variables     --> |.data|
// DCB, DCW, DCD
uint8_t   g_init_var8  = 0x1A;
uint16_t  g_init_var16 = 0x2B3C;
uint32_t  g_init_var32 = 0x4D5E6F70;
uint64_t  g_init_var64 = 0x4D5E6F70;
uint8_t   g_init_array8[4] = { 0x81, 0x92, 0xA3, 0xB4 };

// UN-initialized global variables  --> |.data|
// DCB, DCW, DCD and initialized to zero
// ??? if the variables are not used in an assignment, then the compiler
// ??? will produce a .bss section
uint8_t   g_noinit_var8;
uint16_t  g_noinit_var16;
uint32_t  g_noinit_var32;
uint64_t  g_noinit_var64;
uint32_t  g_noinit_array32[4];

// global constants                 --> |.constdata|
const uint8_t  g_const8  = 0xAA;
const uint16_t g_const16 = 0xBBCC;
const uint32_t g_const32 = 0xDDEEFF00;
const uint64_t g_const64 = 0x1122334455667788;

/*!
 *   \brief main process
 */
int main(void)
{
    // local variables --> registers
    uint8_t  local8;
    uint16_t local16;
    uint32_t local32;
    uint64_t local64;

    uint32_t local32_s;
    uint32_t *pointer;

    // local constants
    const uint8_t  local_const8  = 0xA5;
    const uint16_t local_const16 = 0x9483;
    const uint32_t local_const32 = 0x7261504F;
    const uint64_t local_const64 = 0x3E2D1C0BFAE9D8C7;

    // locally defined variables with qualifier static
    static uint8_t  static_local8;
    static uint16_t static_local16;
    static uint32_t static_local32;
    static uint64_t static_local64;

    // initialize local variables with literals
    local8  = 0xA1;
    local16 = 0xB2C3;
    local32 = 0xD4E5F607;
    local64 = 0x18293A4B5C6D7E8F;

    local32_s = 0x12345678;

    // write un-initialized global variables
    g_noinit_var8   = local8;
    g_noinit_var16  = local16;
    g_noinit_var32  = local32;
    g_noinit_var64  = local64;

    // use local constants and static variables
    static_local8  = local_const8;
    static_local16 = local_const16;
    static_local32 = local_const32;
    static_local64 = local_const64;

    pointer = &local32_s;       // address operator causes the variable
                                // local32_s to be allocated on the stack
                                // instead of in a register

    // use local static variables
    local8  = static_local8;
    local16 = static_local16;
    local32 = static_local32;
    local64 = static_local64;

    // LDR
    g_noinit_array32[2] = 0x1234;
    g_noinit_array32[3] = 0xA1B2C3D4;

    // pointer
    pointer = (uint32_t *) 0x60000000;
    *pointer = 0x1A2B3C4D;

}

void access_io(void){
   volatile uint32_t *p;
   p = (volatile uint32_t *) 0x60000100;
   *p = 0x1A2B3C4D;
}

void SystemInit(void)
{}
