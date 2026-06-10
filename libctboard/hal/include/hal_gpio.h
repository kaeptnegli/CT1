/* ----------------------------------------------------------------------------
 * --  _____       ______  _____                                              -
 * -- |_   _|     |  ____|/ ____|                                             -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems              -
 * --   | | | '_ \|  __|  \___ \   Zurich University of                       -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                           -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland               -
 * ------------------------------------------------------------------------- */
/**
 *  \brief  Interface of module hal_gpio.
 *
 *  The hardware abstraction layer for the GPIO periphery.
 *
 *  \file   hal_gpio.h
 *  $Id$
 * ------------------------------------------------------------------------- */

/* Re-definition guard */
#ifndef _HAL_GPIO_H
#define _HAL_GPIO_H


/* User includes */
#include "reg_stm32f4xx.h"
#include "hal_common.h"


/* -- Type definitions
 * ------------------------------------------------------------------------- */

/**
 *  \enum   hal_gpio_mode_t
 *  \brief  Mode of GPIO port.
 */
typedef enum {
    HAL_GPIO_MODE_IN = 0x00u,           /** < Input mode. */
    HAL_GPIO_MODE_OUT = 0x01u,          /** < Output mode. */
    HAL_GPIO_MODE_AF = 0x02u,           /** < Alternate function mode. */
    HAL_GPIO_MODE_AN = 0x03u            /** < Analog mode. */
} hal_gpio_mode_t;


/**
 *  \enum   hal_gpio_out_speed_t
 *  \brief  Available GPIO output speed.
 */
typedef enum {
    HAL_GPIO_OUT_SPEED_2MHZ = 0x00u,    /** < Max.   2 MHz. */
    HAL_GPIO_OUT_SPEED_10MHZ = 0x01u,   /** < Max.  10 MHz. */
    HAL_GPIO_OUT_SPEED_50MHZ = 0x02u,   /** < Max.  50 MHz. */
    HAL_GPIO_OUT_SPEED_100MHZ = 0x03u   /** < Max. 100 MHz. */
} hal_gpio_out_speed_t;


/**
 *  \enum   hal_gpio_out_type_t
 *  \brief  Output mode.
 */
typedef enum {
    HAL_GPIO_OUT_TYPE_PP = 0x00u,       /** < Push/pull output. */
    HAL_GPIO_OUT_TYPE_OD = 0x01u        /** < Open drain output. */
} hal_gpio_out_type_t;


/**
 *  \enum   hal_gpio_pupd_t
 *  \brief  Available pull-up/down modes.
 */
typedef enum {
    HAL_GPIO_PUPD_NOPULL = 0x00u,       /** < No pull-up/down. */
    HAL_GPIO_PUPD_UP = 0x01u,           /** < Enable pull-up. */
    HAL_GPIO_PUPD_DOWN = 0x02u          /** < Enable pull-down. */
} hal_gpio_pupd_t;


/**
 *  \enum   hal_gpio_af_t
 *  \brief  Defines the available alternate function modes.
 */
typedef enum {
    /* AF0 */
    HAL_GPIO_AF_RTC50HZ   = 0x00u,
    HAL_GPIO_AF_MCO       = 0x00u,
    HAL_GPIO_AF_TAMPER    = 0x00u,
    HAL_GPIO_AF_SWJ       = 0x00u,
    HAL_GPIO_AF_TRACE     = 0x00u,
    /* AF 1 */
    HAL_GPIO_AF_TIM1      = 0x01u,
    HAL_GPIO_AF_TIM2      = 0x01u,
    /* AF 2 */
    HAL_GPIO_AF_TIM3      = 0x02u,
    HAL_GPIO_AF_TIM4      = 0x02u,
    HAL_GPIO_AF_TIM5      = 0x02u,
    /* AF 3 */
    HAL_GPIO_AF_TIM8      = 0x03u,
    HAL_GPIO_AF_TIM9      = 0x03u,
    HAL_GPIO_AF_TIM10     = 0x03u,
    HAL_GPIO_AF_TIM11     = 0x03u,
    /* AF 4 */
    HAL_GPIO_AF_I2C1      = 0x04u,
    HAL_GPIO_AF_I2C2      = 0x04u,
    HAL_GPIO_AF_I2C3      = 0x04u,
    /* AF 5 */
    HAL_GPIO_AF_SPI1      = 0x05u,
    HAL_GPIO_AF_SPI2      = 0x05u,
    HAL_GPIO_AF_SPI4      = 0x05u,
    HAL_GPIO_AF_SPI5      = 0x05u,
    HAL_GPIO_AF_SPI6      = 0x05u,
    /* AF 6 */
    HAL_GPIO_AF_SPI3      = 0x06u,
    HAL_GPIO_AF_SAI1      = 0x06u,
    /* AF 7 */
    HAL_GPIO_AF_USART1    = 0x07u,
    HAL_GPIO_AF_USART2    = 0x07u,
    HAL_GPIO_AF_USART3    = 0x07u,
    HAL_GPIO_AF_I2S3ext   = 0x07u,
    /* AF 8 */
    HAL_GPIO_AF_UART4     = 0x08u,
    HAL_GPIO_AF_UART5     = 0x08u,
    HAL_GPIO_AF_USART6    = 0x08u,
    HAL_GPIO_AF_UART7     = 0x08u,
    HAL_GPIO_AF_UART8     = 0x08u,
    /* AF 9 */
    HAL_GPIO_AF_CAN1      = 0x09u,
    HAL_GPIO_AF_CAN2      = 0x09u,
    HAL_GPIO_AF_TIM12     = 0x09u,
    HAL_GPIO_AF_TIM13     = 0x09u,
    HAL_GPIO_AF_TIM14     = 0x09u,
    /* AF 10 */
    HAL_GPIO_AF_OTG_FS    = 0x0au,
    HAL_GPIO_AF_OTG_HS    = 0x0au,
    /* AF 11 */
    HAL_GPIO_AF_ETH       = 0x0bu,
    /* AF 12 */
    HAL_GPIO_AF_FMC       = 0x0cu,
    HAL_GPIO_AF_OTG_HS_FS = 0x0cu,
    HAL_GPIO_AF_SDIO      = 0x0cu,
    /* AF 13 */
    HAL_GPIO_AF_DCMI      = 0x0du,
    /* AF 14 */
    HAL_GPIO_AF_LTDC      = 0x0eu,
    /* AF 15 */
    HAL_GPIO_AF_EVENTOUT  = 0x0fu
} hal_gpio_af_t;


/**
 *  \enum   hal_gpio_pin_t
 *  \brief  Defines the available pins of a GPIO port.
 */
typedef enum {
    HAL_GPIO_PIN_0   = 0x0001u,
    HAL_GPIO_PIN_1   = 0x0002u,
    HAL_GPIO_PIN_2   = 0x0004u,
    HAL_GPIO_PIN_3   = 0x0008u,
    HAL_GPIO_PIN_4   = 0x0010u,
    HAL_GPIO_PIN_5   = 0x0020u,
    HAL_GPIO_PIN_6   = 0x0040u,
    HAL_GPIO_PIN_7   = 0x0080u,
    HAL_GPIO_PIN_8   = 0x0100u,
    HAL_GPIO_PIN_9   = 0x0200u,
    HAL_GPIO_PIN_10  = 0x0400u,
    HAL_GPIO_PIN_11  = 0x0800u,
    HAL_GPIO_PIN_12  = 0x1000u,
    HAL_GPIO_PIN_13  = 0x2000u,
    HAL_GPIO_PIN_14  = 0x4000u,
    HAL_GPIO_PIN_15  = 0x8000u,
    HAL_GPIO_PIN_All = 0xffffu
} hal_gpio_pin_t;


/**
 *  \enum   hal_gpio_trg_t
 *  \brief  Defines the polarity on wich the interrupt should be triggered.
 */
typedef enum {
    HAL_GPIO_TRG_POS = 0x1u,        /**< Trigger on positive edge. */
    HAL_GPIO_TRG_NEG = 0x2u,        /**< Trigger on negative edge. */
    HAL_GPIO_TRG_BOTH = 0x3u        /**< Trigger on both edges. */
} hal_gpio_trg_t;

/* The compiler will inform that padding will be inserted,
 * which will be unused. This is acceptable. */

/**
 *  \struct hal_gpio_input_t
 *  \brief  Initialisation structure for gpio input mode.
 */
typedef struct {
    uint16_t pins;
    hal_gpio_pupd_t pupd;
} hal_gpio_input_t;

/**
 *  \struct hal_gpio_output_t
 *  \brief  Initialisation structure for gpio output and af mode.
 */
typedef struct {
    uint16_t pins;
    hal_gpio_pupd_t pupd;
    hal_gpio_out_speed_t out_speed;
    hal_gpio_out_type_t out_type;
} hal_gpio_output_t;


/* -- Public function declarations
 * ------------------------------------------------------------------------- */

/**
 *  \brief  Resets gpio port to default values.
 *  \param  port : Defines port to reset.
 */
void hal_gpio_reset(reg_gpio_t *port)
__attribute__((deprecated("Please use GPIOx_RESET().")));

/**
 *  \brief  Initializes a port as input.
 *  \param  port : Defines port to initialize.
 *  \param  init : Structure with mode definitions.
 */
void hal_gpio_init_input(reg_gpio_t *port, hal_gpio_input_t init);

/**
 *  \brief  Initializes a port as analog input.
 *  \param  port : Defines port to initialize.
 *  \param  init : Structure with mode definitions.
 */
void hal_gpio_init_analog(reg_gpio_t *port, hal_gpio_input_t init);

/**
 *  \brief  Initializes a port as output.
 *  \param  port : Defines port to initialize.
 *  \param  init : Structure with mode definitions.
 */
void hal_gpio_init_output(reg_gpio_t *port, hal_gpio_output_t init);

/**
 *  \brief  Initializes a port in alternate function mode.
 *  \param  port : Defines port to initialize.
 *  \param  af_mode : Defines the alternate function mode.
 *  \param  init : Structure with mode definitions.
 */
void hal_gpio_init_alternate(reg_gpio_t *port,
                             hal_gpio_af_t af_mode,
                             hal_gpio_output_t init);

/**
 *  \brief  Reads the specified GPIO input data port.
 *  \param  port : Defines port to interact.
 *  \return The value of the input data register.
 */
uint16_t hal_gpio_input_read(reg_gpio_t *port);

/**
 *  \brief  Reads the specified GPIO output data port.
 *  \param  port : Defines port to interact.
 *  \return The value of the output data register.
 */
uint16_t hal_gpio_output_read(reg_gpio_t *port);

/**
 *  \brief  Writes to the specified GPIO output port.
 *  \param  port : Defines port to interact.
 *  \param  value : The new value of the output port.
 */
void hal_gpio_output_write(reg_gpio_t *port, uint16_t value);

/**
 *  \brief  Sets the specified pins of the output port.
 *  \param  port : Defines port to interact.
 *  \param  pins : Mask of the pins that should be set.
 */
void hal_gpio_bit_set(reg_gpio_t *port, uint16_t pins);

/**
 *  \brief  Resets the specified pins of the output port.
 *  \param  port : Defines port to interact.
 *  \param  pins : Mask of the pins that should be reset.
 */
void hal_gpio_bit_reset(reg_gpio_t *port, uint16_t pins);

/**
 *  \brief  Toggles the specified pins of the output port.
 *  \param  port : Defines port to interact.
 *  \param  pins : Mask of the pins that should be toggled.
 */
void hal_gpio_bit_toggle(reg_gpio_t *port, uint16_t pins);

/**
 *  \brief  Enables interrupt on specified GPIO pins.
 *  \param  port : Defines port to interact.
 *  \param  pins : Mask of the pins that should be enabled.
 *  \param  edge : Edge on which the interrupt should fire.
 *  \param  status : ENABLE/DISABLE specified interrupt.
 */
void hal_gpio_irq_set(reg_gpio_t *port,
                      uint16_t pins,
                      hal_gpio_trg_t edge,
                      hal_bool_t status);

/**
 *  \brief  Return status if specified GPIO interrupt.
 *  \param  pin : Pin / EXTI line to check.
 *  \return Actual status of specified interrupt.
 */
hal_bool_t hal_gpio_irq_status(uint16_t pin);

/**
 *  \brief  Clear specified GPIO interrupt.
 *  \param  pin : Pin / EXTI line interrupt to clear.
 */
void hal_gpio_irq_clear(uint16_t pin);

#endif
