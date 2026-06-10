/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Necessary stubs to satisfy the linker due to usage of the lib
 *          function __scatterlaod.
 *
 *          Disable semi hosting.
 *          See https://www.keil.com/pack/doc/compiler/RetargetIO/html/_retarget__overview.html
 *          and https://community.arm.com/support-forums/f/keil-forum/40752/debug-is-getting-stuck-at-bkpt-0xab.
 *
 *  \file   retarget.c
 *  $Id$
 * ------------------------------------------------------------------------- */
/* Necessary stubs to satisfy the linker due to usage of the libc function __scatterload. */
#include <stddef.h>


/* Didsabling Semihosting */
//#if __ARMCC_VERSION >= 6000000
//    __asm(".global __use_no_semihosting");
//#elif __ARMCC_VERSION >= 5000000
//    #pragma import(__use_no_semihosting)
//#else
//    #error Unsupported compiler
//#endif


/* -- Public function definitions
 * ------------------------------------------------------------------------- */

char *_sys_command_string(char* cmd, int len);
void _ttywrch(int ch);
void _sys_exit(int return_code) __attribute__((noreturn));


/**
 *  \brief  No Semihosting retargeting function.
 *
 */
char *_sys_command_string(char* cmd __attribute__((__unused__)), int len __attribute__((__unused__))){
    return NULL;
}


/**
 *  \brief  No Semihosting retargeting function.
 *
 */
void _ttywrch(int ch __attribute__((__unused__))){
}


/**
 *  \brief  No Semihosting retargeting function.
 *
 */
void _sys_exit(int return_code __attribute__((__unused__))) {
    for(;;);
}
