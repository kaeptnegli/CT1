; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- Project     : CT1 Slides
; -- Description : Function Stack
; --
; --               As the code is used for slides it frequently uses
; --               LTORG to keep the literal pools close to the example.
; --
; -- $Revision: 720 $
; -- $Id: functionsStack.s 720 2014-09-17 13:51:39Z ruan $
; ------------------------------------------------------------------

                AREA    myCode, CODE, READONLY

main            PROC
                EXPORT  main

                B       trial_start

trial_start
                B       proc_a
                NOP
                NOP
                NOP
                B       proc_a

proc_a          NOP
                B       trial_start

                PUSH    {R0}
                POP     {R0}
                PUSH    {R0,R1}
                PUSH    {R0-R4}

                SUB     SP,SP,#4
                STR     R2,[SP]

                LDR     R2,[SP]
                ADD     SP,SP,#4
                ENDP

                AREA    pushEx, CODE, READWRITE
                PUSH    {R7}
                PUSH    {R1,R3,R4,R5}
                PUSH    {R1,R3-R5}
                PUSH    {LR}
                PUSH    {R7,LR}

                LDR     R1,=0x20010000
                MOV     SP,R1
                LDR     R2,=0x00112233
                LDR     R3,=0x44556677
                PUSH    {R2,R3}

                AREA    popEx, CODE, READWRITE
                POP     {R7}
                POP     {R1,R3,R4,R5}
                POP     {R1,R3-R5}
                POP     {PC}
                POP     {R7,PC}

                AREA    procCall, CODE, READWRITE
                LDR     R0,=10
                BL      MulBy3
                ADDS    R0,#5
                BL      MulBy3
                MOVS    R5,R0
                ADDS    R0,#5
endless         B       endless

                SPACE   62

MulBy3          MOV     R4,R0
                LSLS    R0,#1
                ADD     R0,R4
                BX      LR


                AREA    pushPop, CODE, READWRITE

                ; alternate implementation of PUSH {R2,R3,R6}
                SUB     SP,SP,#12
                STR     R2,[SP]
                STR     R3,[SP,#4]
                STR     R6,[SP,#8]

                ; alternate implementation of POP {R2,R3,R6}
                LDR     R2,[SP]
                LDR     R3,[SP,#4]
                LDR     R3,[SP,#8]
                ADD     SP,SP,#12

                AREA    nestSub, CODE, READWRITE

ADDR_LED_31_0   EQU     0x60000100
LED_PATTERN     EQU     0xA55A5AA5

subrExample     PROC
                PUSH    {R4,R5,LR}

                LDR     R4,=ADDR_LED_31_0
                LDR     R5,=LED_PATTERN
                STR     R5,[R4]
                BL      write7seg
                POP     {R4,R5,PC}
                ENDP

write7seg       BX      LR          ;dummy


                AREA   progData, DATA, READWRITE
varArray
                DCD    0xFEDCBA98
                DCD    0x76543210
                DCD    0xEDCBA987

                AREA   progData2, DATA, READWRITE
data_array      SPACE  256

                END
