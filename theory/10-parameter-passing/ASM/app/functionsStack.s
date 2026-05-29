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
; -- Description : Parameter Passing
; --
; --               As the code is used for slides it frequently uses
; --               LTORG to keep the literal pools close to the example.
; --
; -- $Revision: 405 $
; -- $Id: main.s 405 2014-08-05 06:54:14Z ruan $
; ------------------------------------------------------------------

TABLE_LENGTH    EQU     16

                AREA    myCode, CODE, READONLY

                ALIGN 4
main            PROC
                EXPORT  main

                ; pass by value through registers
                MOVS    R1,#0x03
                BL      double
                MOVS    R4,R0

                ;pass by reference through register
                LDR     R0,=p1Table         ; load address of table
                MOVS    R1,#TABLE_LENGTH
                BL      doubleTableValues

                ; pass through global variables
                LDR     R4,=param1
                MOVS    R5,#0x03
                STRB    R5,[R4]
                BL      double_g
                LDR     R4,=result
                LDRB    R0,[R4]

                ENDP

                ALIGN 4
double          FUNCTION
                MOV     R1,R0
                LSLS    R0,R1,#1
                BX      LR
                ENDFUNC

                ALIGN 4
doubleTableValues FUNCTION
                ; double each table element
                ; byte --> ignore potential carry
                ; without callee saving of r4-r11
                LDRB    R4,[R0]
                LSLS    R4,R4,#1
                STRB    R4,[R0]
                ADDS    R0,#1
                CMP     R0,R1
                BLO     doubleTableValues

                BX      LR
                ENDFUNC

double_g        PROC
                LDR     R4,=param1
                LDRB    R1,[R4]
                LSLS    R0,R1,#1
                LDR     R4,=result
                STR     R0,[R4]
                BX      LR
                ENDP

                ;NOP

                AREA   exData, DATA, READWRITE
p1Table         SPACE TABLE_LENGTH
param1          SPACE 1
result          SPACE 1


                AREA   progData2, DATA, READWRITE
data_array      SPACE  256


                END
