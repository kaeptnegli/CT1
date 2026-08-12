/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Interface of module system_ctboard.
 *
 *  \file   system_ctboard.h
 *  $Id$
 * ------------------------------------------------------------------------- */

/* Re-definition guard */
#ifndef _SYSTEM_CTBOARD_H
#define _SYSTEM_CTBOARD_H


/* User includes */
#include "hal_gpio.h"
#include "hal_fmc.h"
#include "hal_pwr.h"
#include "hal_rcc.h"


/* -- Public function declarations
 * ------------------------------------------------------------------------- */

/**
 *  \brief  Entry point used in startup.
 */
void __system(void);

/**
 *  \brief  Enters into run mode.
 *  Initializes all necessary peripherals for running the ct board:
 *  - System clock
 *  - Flexible memory controller -> CT board
 *  - LCD display on CT board
 */
void system_enter_run(void);


/* --- low power modes --- */

/**
 *  \brief  Enter the sleep mode.
 *  \param  entry : Should the stop mode be entered with WFI or WFE.
 */
void system_enter_sleep(void); /*Parameter: hal_pwr_lp_entry_t entry*/


/**
 *  \brief  Enter the stop mode.
 *  \param  regulator : Specifies the voltage regulator used in stop mode.
 *  \param  entry : Should the stop mode be entered with WFI or WFE.
 */
void system_enter_stop(void); /*Parameter: hal_pwr_regulator_t regulator, hal_pwr_lp_entry_t entry*/

/**
 *  \brief  Enter the standby mode.
 */
void system_enter_standby(void);

#endif
