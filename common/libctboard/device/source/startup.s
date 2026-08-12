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
//     File:      startup.s
//
//     Purpose:   defines the interrupt vector table and
//                initialises data sections
//
//     Author(s): <{????,scbj}@zhaw.ch>
//
//     Date:      ??/????
//                02/2026
//
//  ############################################################
//

.syntax unified
.cpu cortex-m4
.eabi_attribute 25, 1
.thumb

// reserve memory for data/bss start/end addresses, values are set by linker
.word _sidata
.word _sdata
.word _edata
.word _sbss
.word _ebss

// reserve memory for the stack
.equ Stack_Size,      0x00002000

.section .stack, "aw"
.balign 8

.global Stack_Size
.global Stack_Mem

Stack_Mem:
    .space Stack_Size
__initial_sp:

// reserve memory for the heap
.equ Heap_Size,       0x00000800

.section .heap, "aw"
.balign 8

__heap_base:
Heap_Mem:
    .space Heap_Size
__heap_limit:

// interrupt vector table mapped to address 0 at reset
.section .isr_vector, "a"

.global __Vectors
.global __Vectors_End
.global __Vectors_Size
.global __initial_sp

__Vectors:
        // NOTE: the least significant bit in jump instructions determines the
        // instruction set expected after the jump. unfortunately the
        // GNU assembler does not set the bit automatically despite the
        // `.thumb` directive specifying the whole file to be 16 bit
        // instructions. therefore the bit has to be set manually. this can be
        // done by just increasing the labels by one, as instructions are
        // always aligned to two byte boundaries.
        .word __initial_sp                      // Top of Stack
        .word Reset_Handler                 + 1 // Reset Handler
        .word NMI_Handler                   + 1 // NMI Handler
        .word HardFault_Handler             + 1 // Hard Fault Handler
        .word MemManage_Handler             + 1 // MPU Fault Handler
        .word BusFault_Handler              + 1 // Bus Fault Handler
        .word UsageFault_Handler            + 1 // Usage Fault Handler
        .word 0                             + 1 // Reserved
        .word 0                             + 1 // Reserved
        .word 0                             + 1 // Reserved
        .word 0                             + 1 // Reserved
        .word SVC_Handler                   + 1 // SVCall Handler
        .word DebugMon_Handler              + 1 // Debug Monitor Handler
        .word 0                             + 1 // Reserved
        .word PendSV_Handler                + 1 // PendSV Handler
        .word SysTick_Handler               + 1 // SysTick Handler

        // External Interrupts
        .word WWDG_IRQHandler               + 1 // Window WatchDog
        .word PVD_IRQHandler                + 1 // PVD through EXTI Line detection
        .word TAMP_STAMP_IRQHandler         + 1 // Tamper and TimeStamps through the EXTI line
        .word RTC_WKUP_IRQHandler           + 1 // RTC Wakeup through the EXTI line
        .word FLASH_IRQHandler              + 1 // FLASH
        .word RCC_IRQHandler                + 1 // RCC
        .word EXTI0_IRQHandler              + 1 // EXTI Line0
        .word EXTI1_IRQHandler              + 1 // EXTI Line1
        .word EXTI2_IRQHandler              + 1 // EXTI Line2
        .word EXTI3_IRQHandler              + 1 // EXTI Line3
        .word EXTI4_IRQHandler              + 1 // EXTI Line4
        .word DMA1_Stream0_IRQHandler       + 1 // DMA1 Stream 0
        .word DMA1_Stream1_IRQHandler       + 1 // DMA1 Stream 1
        .word DMA1_Stream2_IRQHandler       + 1 // DMA1 Stream 2
        .word DMA1_Stream3_IRQHandler       + 1 // DMA1 Stream 3
        .word DMA1_Stream4_IRQHandler       + 1 // DMA1 Stream 4
        .word DMA1_Stream5_IRQHandler       + 1 // DMA1 Stream 5
        .word DMA1_Stream6_IRQHandler       + 1 // DMA1 Stream 6
        .word ADC_IRQHandler                + 1 // ADC1, ADC2 and ADC3s
        .word CAN1_TX_IRQHandler            + 1 // CAN1 TX
        .word CAN1_RX0_IRQHandler           + 1 // CAN1 RX0
        .word CAN1_RX1_IRQHandler           + 1 // CAN1 RX1
        .word CAN1_SCE_IRQHandler           + 1 // CAN1 SCE
        .word EXTI9_5_IRQHandler            + 1 // External Line[9:5]s
        .word TIM1_BRK_TIM9_IRQHandler      + 1 // TIM1 Break and TIM9
        .word TIM1_UP_TIM10_IRQHandler      + 1 // TIM1 Update and TIM10
        .word TIM1_TRG_COM_TIM11_IRQHandler + 1 // TIM1 Trigger and Commutation and TIM11
        .word TIM1_CC_IRQHandler            + 1 // TIM1 Capture Compare
        .word TIM2_IRQHandler               + 1 // TIM2
        .word TIM3_IRQHandler               + 1 // TIM3
        .word TIM4_IRQHandler               + 1 // TIM4
        .word I2C1_EV_IRQHandler            + 1 // I2C1 Event
        .word I2C1_ER_IRQHandler            + 1 // I2C1 Error
        .word I2C2_EV_IRQHandler            + 1 // I2C2 Event
        .word I2C2_ER_IRQHandler            + 1 // I2C2 Error
        .word SPI1_IRQHandler               + 1 // SPI1
        .word SPI2_IRQHandler               + 1 // SPI2
        .word USART1_IRQHandler             + 1 // USART1
        .word USART2_IRQHandler             + 1 // USART2
        .word USART3_IRQHandler             + 1 // USART3
        .word EXTI15_10_IRQHandler          + 1 // External Line[15:10]s
        .word RTC_Alarm_IRQHandler          + 1 // RTC Alarm (A and B) through EXTI Line
        .word OTG_FS_WKUP_IRQHandler        + 1 // USB OTG FS Wakeup through EXTI line
        .word TIM8_BRK_TIM12_IRQHandler     + 1 // TIM8 Break and TIM12
        .word TIM8_UP_TIM13_IRQHandler      + 1 // TIM8 Update and TIM13
        .word TIM8_TRG_COM_TIM14_IRQHandler + 1 // TIM8 Trigger and Commutation and TIM14
        .word TIM8_CC_IRQHandler            + 1 // TIM8 Capture Compare
        .word DMA1_Stream7_IRQHandler       + 1 // DMA1 Stream7
        .word FMC_IRQHandler                + 1 // FMC
        .word SDIO_IRQHandler               + 1 // SDIO
        .word TIM5_IRQHandler               + 1 // TIM5
        .word SPI3_IRQHandler               + 1 // SPI3
        .word UART4_IRQHandler              + 1 // UART4
        .word UART5_IRQHandler              + 1 // UART5
        .word TIM6_DAC_IRQHandler           + 1 // TIM6 and DAC1&2 underrun errors
        .word TIM7_IRQHandler               + 1 // TIM7
        .word DMA2_Stream0_IRQHandler       + 1 // DMA2 Stream 0
        .word DMA2_Stream1_IRQHandler       + 1 // DMA2 Stream 1
        .word DMA2_Stream2_IRQHandler       + 1 // DMA2 Stream 2
        .word DMA2_Stream3_IRQHandler       + 1 // DMA2 Stream 3
        .word DMA2_Stream4_IRQHandler       + 1 // DMA2 Stream 4
        .word ETH_IRQHandler                + 1 // Ethernet
        .word ETH_WKUP_IRQHandler           + 1 // Ethernet Wakeup through EXTI line
        .word CAN2_TX_IRQHandler            + 1 // CAN2 TX
        .word CAN2_RX0_IRQHandler           + 1 // CAN2 RX0
        .word CAN2_RX1_IRQHandler           + 1 // CAN2 RX1
        .word CAN2_SCE_IRQHandler           + 1 // CAN2 SCE
        .word OTG_FS_IRQHandler             + 1 // USB OTG FS
        .word DMA2_Stream5_IRQHandler       + 1 // DMA2 Stream 5
        .word DMA2_Stream6_IRQHandler       + 1 // DMA2 Stream 6
        .word DMA2_Stream7_IRQHandler       + 1 // DMA2 Stream 7
        .word USART6_IRQHandler             + 1 // USART6
        .word I2C3_EV_IRQHandler            + 1 // I2C3 event
        .word I2C3_ER_IRQHandler            + 1 // I2C3 error
        .word OTG_HS_EP1_OUT_IRQHandler     + 1 // USB OTG HS End Point 1 Out
        .word OTG_HS_EP1_IN_IRQHandler      + 1 // USB OTG HS End Point 1 In
        .word OTG_HS_WKUP_IRQHandler        + 1 // USB OTG HS Wakeup through EXTI
        .word OTG_HS_IRQHandler             + 1 // USB OTG HS
        .word DCMI_IRQHandler               + 1 // DCMI
        .word CRYP_IRQHandler               + 1 // CRYP crypto
        .word HASH_RNG_IRQHandler           + 1 // Hash and Rng
        .word FPU_IRQHandler                + 1 // FPU
        .word UART7_IRQHandler              + 1 // UART7
        .word UART8_IRQHandler              + 1 // UART8
        .word SPI4_IRQHandler               + 1 // SPI4
        .word SPI5_IRQHandler               + 1 // SPI5
        .word SPI6_IRQHandler               + 1 // SPI6
        .word SAI1_IRQHandler               + 1 // SAI1
        .word LTDC_IRQHandler               + 1 // LTDC
        .word LTDC_ER_IRQHandler            + 1 // LTDC error
        .word DMA2D_IRQHandler              + 1 // DMA2D

__Vectors_End:

.equ __Vectors_Size, __Vectors_End - __Vectors

.text
.balign 8

// Reset handler
.global __system
.global __init_syscalls
.type Reset_Handler, %function
Reset_Handler:
        .weak   Reset_Handler

        // load stack pointer
        ldr     r0, =__initial_sp
        mov     sp, r0

        // call to dummy function to explicitly load the object
        // syscalls.o in the linking stage.
        // needed to silence libnosys warnings regarding missing
        // syscall implementations
        bl      __init_syscalls

        // call system initialisation routine
        // (initialise clocks, etc.)
        bl      __system

InitStack:
        // initialise stack
        ldr     r0, =Stack_Mem
        ldr     r1, =Stack_Size
        ldr     r2, =0xEFBEADDE  // stack fingerprint (little endian!)
LoopStack:
        subs    r1, r1, #4       // calculate index of last stack element
        str     r2, [r0, r1]
        bgt     LoopStack

InitData:
        // load constants and initialised variables
        ldr     r0, =_sidata
        ldr     r1, =_sdata
        ldr     r2, =_edata
        subs    r2, r2, r1
DataLoop:
        subs    r2, r2, #4
        ldr     r3, [r0, r2]
        str     r3, [r1, r2]
        bgt     DataLoop

ZeroBss:
        // zero block starting symbol section
        ldr     r0, =_sbss
        ldr     r1, =_ebss
        mov     r2, #0
BssLoop:
        str     r2, [r0]
        adds    r0, r0, #4
        cmp     r0, r1
        bne     BssLoop

        // call user main function
        bl      main

InfiniteLoop:
        b       InfiniteLoop

// __user_setup_stackheap is required by __scatterload
// we do not provide any heap: no C malloc nor C++ new usable
.weak Stack_Size
.weak Stack_Mem


// Dummy Exception Handlers (infinite loops which can be modified)

.type NMI_Handler, %function
NMI_Handler:
        .weak NMI_Handler
        b .

.type NMI_Handler, %function
HardFault_Handler:
        .weak HardFault_Handler
        b .

.type NMI_Handler, %function
MemManage_Handler:
        .weak MemManage_Handler
        b .

.type NMI_Handler, %function
BusFault_Handler:
        .weak BusFault_Handler
        b .

.type NMI_Handler, %function
UsageFault_Handler:
        .weak UsageFault_Handler
        b .

.type NMI_Handler, %function
SVC_Handler:
        .weak SVC_Handler
        b .

.type NMI_Handler, %function
DebugMon_Handler:
        .weak DebugMon_Handler
        b .

.type NMI_Handler, %function
PendSV_Handler:
        .weak PendSV_Handler
        b .

.type NMI_Handler, %function
SysTick_Handler:
        .weak SysTick_Handler
        b .

.type Default_Handler, %function
Default_Handler:
        .weak WWDG_IRQHandler
        .weak PVD_IRQHandler
        .weak TAMP_STAMP_IRQHandler
        .weak RTC_WKUP_IRQHandler
        .weak FLASH_IRQHandler
        .weak RCC_IRQHandler
        .weak EXTI0_IRQHandler
        .weak EXTI1_IRQHandler
        .weak EXTI2_IRQHandler
        .weak EXTI3_IRQHandler
        .weak EXTI4_IRQHandler
        .weak DMA1_Stream0_IRQHandler
        .weak DMA1_Stream1_IRQHandler
        .weak DMA1_Stream2_IRQHandler
        .weak DMA1_Stream3_IRQHandler
        .weak DMA1_Stream4_IRQHandler
        .weak DMA1_Stream5_IRQHandler
        .weak DMA1_Stream6_IRQHandler
        .weak ADC_IRQHandler
        .weak CAN1_TX_IRQHandler
        .weak CAN1_RX0_IRQHandler
        .weak CAN1_RX1_IRQHandler
        .weak CAN1_SCE_IRQHandler
        .weak TIM1_UP_TIM10_IRQHandler
        .weak TIM1_TRG_COM_TIM11_IRQHandler
        .weak TIM1_CC_IRQHandler
        .weak TIM2_IRQHandler
        .weak TIM3_IRQHandler
        .weak TIM4_IRQHandler
        .weak I2C1_EV_IRQHandler
        .weak I2C1_ER_IRQHandler
        .weak I2C2_EV_IRQHandler
        .weak I2C2_ER_IRQHandler
        .weak SPI1_IRQHandler
        .weak SPI2_IRQHandler
        .weak USART1_IRQHandler
        .weak USART2_IRQHandler
        .weak USART3_IRQHandler
        .weak EXTI15_10_IRQHandler
        .weak RTC_Alarm_IRQHandler
        .weak OTG_FS_WKUP_IRQHandler
        .weak TIM8_BRK_TIM12_IRQHandler
        .weak TIM8_UP_TIM13_IRQHandler
        .weak TIM8_TRG_COM_TIM14_IRQHandler
        .weak TIM8_CC_IRQHandler
        .weak DMA1_Stream7_IRQHandler
        .weak FMC_IRQHandler
        .weak SDIO_IRQHandler
        .weak TIM5_IRQHandler
        .weak SPI3_IRQHandler
        .weak UART4_IRQHandler
        .weak UART5_IRQHandler
        .weak TIM6_DAC_IRQHandler
        .weak TIM7_IRQHandler
        .weak DMA2_Stream0_IRQHandler
        .weak DMA2_Stream1_IRQHandler
        .weak DMA2_Stream2_IRQHandler
        .weak DMA2_Stream3_IRQHandler
        .weak DMA2_Stream4_IRQHandler
        .weak ETH_IRQHandler
        .weak ETH_WKUP_IRQHandler
        .weak CAN2_TX_IRQHandler
        .weak CAN2_RX0_IRQHandler
        .weak CAN2_RX1_IRQHandler
        .weak CAN2_SCE_IRQHandler
        .weak OTG_FS_IRQHandler
        .weak DMA2_Stream5_IRQHandler
        .weak DMA2_Stream6_IRQHandler
        .weak DMA2_Stream7_IRQHandler
        .weak USART6_IRQHandler
        .weak I2C3_EV_IRQHandler
        .weak I2C3_ER_IRQHandler
        .weak OTG_HS_EP1_OUT_IRQHandler
        .weak OTG_HS_EP1_IN_IRQHandler
        .weak OTG_HS_WKUP_IRQHandler
        .weak OTG_HS_IRQHandler
        .weak DCMI_IRQHandler
        .weak CRYP_IRQHandler
        .weak HASH_RNG_IRQHandler
        .weak FPU_IRQHandler
        .weak UART7_IRQHandler
        .weak UART8_IRQHandler
        .weak SPI4_IRQHandler
        .weak SPI5_IRQHandler
        .weak SPI6_IRQHandler
        .weak SAI1_IRQHandler
        .weak LTDC_IRQHandler
        .weak LTDC_ER_IRQHandler
        .weak DMA2D_IRQHandler

WWDG_IRQHandler:
PVD_IRQHandler:
TAMP_STAMP_IRQHandler:
RTC_WKUP_IRQHandler:
FLASH_IRQHandler:
RCC_IRQHandler:
EXTI0_IRQHandler:
EXTI1_IRQHandler:
EXTI2_IRQHandler:
EXTI3_IRQHandler:
EXTI4_IRQHandler:
DMA1_Stream0_IRQHandler:
DMA1_Stream1_IRQHandler:
DMA1_Stream2_IRQHandler:
DMA1_Stream3_IRQHandler:
DMA1_Stream4_IRQHandler:
DMA1_Stream5_IRQHandler:
DMA1_Stream6_IRQHandler:
ADC_IRQHandler:
CAN1_TX_IRQHandler:
CAN1_RX0_IRQHandler:
CAN1_RX1_IRQHandler:
CAN1_SCE_IRQHandler:
EXTI9_5_IRQHandler:
TIM1_BRK_TIM9_IRQHandler:
TIM1_UP_TIM10_IRQHandler:
TIM1_TRG_COM_TIM11_IRQHandler:
TIM1_CC_IRQHandler:
TIM2_IRQHandler:
TIM3_IRQHandler:
TIM4_IRQHandler:
I2C1_EV_IRQHandler:
I2C1_ER_IRQHandler:
I2C2_EV_IRQHandler:
I2C2_ER_IRQHandler:
SPI1_IRQHandler:
SPI2_IRQHandler:
USART1_IRQHandler:
USART2_IRQHandler:
USART3_IRQHandler:
EXTI15_10_IRQHandler:
RTC_Alarm_IRQHandler:
OTG_FS_WKUP_IRQHandler:
TIM8_BRK_TIM12_IRQHandler:
TIM8_UP_TIM13_IRQHandler:
TIM8_TRG_COM_TIM14_IRQHandler:
TIM8_CC_IRQHandler:
DMA1_Stream7_IRQHandler:
FMC_IRQHandler:
SDIO_IRQHandler:
TIM5_IRQHandler:
SPI3_IRQHandler:
UART4_IRQHandler:
UART5_IRQHandler:
TIM6_DAC_IRQHandler:
TIM7_IRQHandler:
DMA2_Stream0_IRQHandler:
DMA2_Stream1_IRQHandler:
DMA2_Stream2_IRQHandler:
DMA2_Stream3_IRQHandler:
DMA2_Stream4_IRQHandler:
ETH_IRQHandler:
ETH_WKUP_IRQHandler:
CAN2_TX_IRQHandler:
CAN2_RX0_IRQHandler:
CAN2_RX1_IRQHandler:
CAN2_SCE_IRQHandler:
OTG_FS_IRQHandler:
DMA2_Stream5_IRQHandler:
DMA2_Stream6_IRQHandler:
DMA2_Stream7_IRQHandler:
USART6_IRQHandler:
I2C3_EV_IRQHandler:
I2C3_ER_IRQHandler:
OTG_HS_EP1_OUT_IRQHandler:
OTG_HS_EP1_IN_IRQHandler:
OTG_HS_WKUP_IRQHandler:
OTG_HS_IRQHandler:
DCMI_IRQHandler:
CRYP_IRQHandler:
HASH_RNG_IRQHandler:
FPU_IRQHandler:
UART7_IRQHandler:
UART8_IRQHandler:
SPI4_IRQHandler:
SPI5_IRQHandler:
SPI6_IRQHandler:
SAI1_IRQHandler:
LTDC_IRQHandler:
LTDC_ER_IRQHandler:
DMA2D_IRQHandler:
        b .

.balign 4
.end

