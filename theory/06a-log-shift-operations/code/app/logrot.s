; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- Project     : CT1 slides 6
; -- Description : logic and rotate operations
; --
; -- $Revision: 723 $
; -- $Id: logrot.s 723 2014-09-20 08:27:39Z ruan $
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

                ENTRY
Reset_Handler
                B       trial_start


trial_start
                ;-----------------------------------------
                ; Bit operations WITH update of flags
                ; encoding T1 --> M0 allows only low registers
                ; allows destination and 2 different operands
                ;-----------------------------------------

                ANDS    R1,R1,R2    ; R1 = R1 AND R2
                ANDS    R1,R2       ; the same (dest = R1)
                ORRS    R7,R7,R6    ; R7 = R7 OR R6
                EORS    R3,R3,R4    ; R3 = R3 EXOR R4
                BICS    R0,R0,R1    ; R0 = R0 AND NOT(R1)
                MVNS    R1,R2       ; R1 = NOT(R2)


                ;-----------------------------------------
                ; multiply/divide by 2^n
                ; ----------------------------------------

                ; multiply for signed and unsigned
                LSLS R0,R1,#1   ; *2
                LSLS R0,R1,#2   ; *4
                LSLS R0,R1,#3   ; *8

                ; divide for unsigned
                LSRS R0,R1,#1    ; /2
                LSRS R0,R1,#2    ; /4
                LSRS R0,R1,#3    ; /8

                ; divide for signed
                ASRS R0,R1,#1    ; /2
                ASRS R0,R1,#2    ; /4
                ASRS R0,R1,#3    ; /8

                ;-----------------------------------------
                ; multiplication by constant
                ; ----------------------------------------
                ; R0 = 13 * R1
                MOVS    R0, R1      ; R0 = R1
                LSLS    R1, R1, #2  ; 4 • R1
                ADDS    R0, R0, R1  ; R0 = R0 + 4 • R1
                LSLS    R1, R1, #1  ; 2 • R1 -> 8 • R1
                ADDS    R0, R0, R1  ; R0 = R0 + 8 • R1

                ; logic shift left with immediate value zero is possible
                LSLS    R1,R2,#0
                LSLS    R1,R1,#0
                ; logic shift right with immediate zero is not possible
                ;LSRS    R1,R2,#0
                ;LSRS    R1,R1,#0
                ; arithmetic shift right with zero is not possible
                ;ASRS    R1,R2,#0
                ;ASRS    R1,R1,#0

loop
                B       loop
                NOP

                AREA    myCode2, CODE, READONLY

                ;-----------------------------------------
                ; shift/rotate examples
                ; ----------------------------------------

                LDR     R1,=0xCCCCCCCC
                MOVS    R2,#3
                LDR     R3,=0x66666666
                LDR     R4,=0x99999999
                MOVS    R5,#0xE3

                ; arithmetic shift right
                ASRS    R1,R1,R2    ; register
                ASRS    R3,R3,#4    ; immediate
                RORS    R4,R4,R2    ; register
                LSLS    R5,R5,#3    ; immediate

                NOP
; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
                END
