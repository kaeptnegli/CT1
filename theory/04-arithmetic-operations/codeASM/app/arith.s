; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- Project     : CT1 slides 3/4
; -- Description : Arithmetic operations
; --
; -- $Revision: 1163 $
; -- $Id: main.s 1163 2013-12-11 13:53:08Z feur $
; ------------------------------------------------------------------

                ;PRESERVE8
                THUMB

; ------------------------------------------------------------------
; -- RESET area -> See scatter file
; ------------------------------------------------------------------

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
__Vectors
                DCD  0x2002FFFF     ; stack pointer value when stack is empty
                DCD  Reset_Handler  ; reset vector


; ------------------------------------------------------------------
; -- myCode
; ------------------------------------------------------------------

                AREA    myCode, CODE, READONLY

MY_CONST8       EQU     0xCD
MY_CONST16      EQU     0xABCD
MY_CONST32      EQU     0x6789ABCD

                ENTRY
Reset_Handler
                B       trial_start

trial_start
                ; ADD (register) WITH update of flags
                ; encoding T1 --> M0 allows only low registers
                ; allows destination and 2 different operands
                ADDS	R1,R2,R3
                ADDS	R1,R1,R2
                ADDS	R1,R2       ; the same (dest = R1)

                ;ADDS    R9,R2 	    ; not possible (high reg)
                ;ADDS    R1,R10     ; not possible (high reg)

                ; ADD (register) WITHOUT update of flags
                ; encoding T2 --> M0 allows high and low registers
                ; BUT dest and 2nd source must be same
                ADD     R1,R1,R2    ; low regs
                ADD 	R9,R9,R10   ; high regs
                ADD		R9,R10		; the same (dest = R9)
                ADD		R1,R1,R2
                ;ADD    R1,R2,R3    ; not possible

                ; ADD (immediate) WITH update of flags
                ; encoding T1 --> 2 different low regs and immediate 0-7
                ADDS    R3,R4,#5
                ;ADDS    R3,R4,#8    ; out of range immediate
                ;ADDS    R10,R11,#5  ; not possible (high reg)

                ; ADD (immediate) WITH update of flags
                ; encoding T2 --> one low reg and immediate 0-255
                ADDS    R3,R3,#240
                ADDS    R3,#240     ; the same (dest = R3)
                ;ADDS    R8,R8,#240 ; not possible (high reg)
                ;ADDS    R3,#260    ; out of range immediate

                ; SUB (register) WITH update of flags
                ; allows destination and 2 operands
                ; only low registers
                SUBS    R1,R2,R3
                SUBS    R4,R4,R5
                SUBS    R4,R5       ; the same (dest = R4)

                ;SUBS    R8,R4,R5   ; not possible (high reg)
                ;SUBS    R4,R8,R5   ; not possible (high reg)
                ;SUBS    R4,R5,R8   ; not possible (high reg)

                ; SUB (immediate) WITH update of flags
                ; encoding T1 --> 2 different low regs and immediate 0-7
                SUBS    R3,R4,#5
                ;SUBS    R3,R4,#8    ; out of range immediate
                ;SUBS    R10,R11,#5  ; not possible (high reg)

                ; SUB (immediate) WITH update of flags
                ; encoding T2 --> one low reg and immediate 0-255
                SUBS    R3,R3,#240
                SUBS    R3,#240     ; the same (dest = R3)
                ;SUBS    R8,R8,#240 ; not possible (high reg)
                ;SUBS    R3,#260    ; out of range immediate

                ; RSBS
                RSBS    R1,R2,#0
                RSBS    R7,R7,#0
                RSBS    R7,#0       ; the same (dest = R7)

                ;RSBS    R8,R1,#0   ;not possible (high reg)
                ;RSBS    R1,R8,#0   ;not possible (high reg)

                ; multi-word addition A + B
                ; Operand A: 96-bit value in R3(MSW), R2, R1 (LSW)
                ; Operand B: 96-bit value in R6(MSW), R5, R4 (LSW)
                ; Result:    96-bit value in R3(MSW), R2, R1 (LSW)
                ADDS    R1,R1,R4
                ADCS    R2,R2,R5
                ADCS    R3,R3,R6

                ; multi-word subtraction A - B
                ; Operand A: 96-bit value in R3(MSW), R2, R1 (LSW)
                ; Operand B: 96-bit value in R6(MSW), R5, R4 (LSW)
                ; Result:    96-bit value in R3(MSW), R2, R1 (LSW)
                SUBS    R1, R1, R4     ; subtract the least significant words
                SBCS    R2, R2, R5     ; subtract the middle words with carry
                SBCS    R3, R3, R6     ; subtract the most significant words with carry

                ; MUL
                MULS    R1,R2,R1
                ;MULS    R1,R1,R2    ; not possible: destination and
                                     ; 2nd source must be same
                ;MULS    R1,R8,R1    ; not possible: high reg

                ADDS    R0,#0x34
                ADD     R0,R0,R1
                SUBS    R1,R1,#0xf4

                LDR     R1,=0xABCDEF12
				LDR     R1,=-2550
                MOVS    R1,#1
                ;MOVS    R1,#-1
                LDR     R0,[R0,#0]

loop
                B       loop

                AREA    myCode2, CODE, READONLY

                NOP     ; nay instruction before label

demoprg         MOVS    R0,#0xA5    ; copy 0xA5 into register R0
                MOVS    R1,#0x11    ; copy 0x11 into register R1
                ADDS    R0,R0,R1    ; add contents of R0 and R1
                                    ; store result in R0
                LDR     R2,=0x2000  ; load an address into R2
                STR     R0,[R2]     ; store content of R0 at
                                    ; the address given by R2
; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
                END
