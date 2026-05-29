; ------------------------------------------------------------------
; --  _____       ______  _____                                    -
; -- |_   _|     |  ____|/ ____|                                   -
; --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
; --   | | | '_ \|  __|  \___ \   Zurich University of             -
; --  _| |_| | | | |____ ____) |  Applied Sciences                 -
; -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
; ------------------------------------------------------------------
; --
; -- Project     : CT1 slides 6 --> branches
; -- Description : examples for slides
; --
; -- $Revision: 4657 $
; -- $Id: jump.s 4657 2019-02-07 07:11:55Z ruan $
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

                ;******************************
                ; entry example
                ;******************************
THIN            EQU     0x00000004
CONTINUE        EQU     0x0000000F
DIGEST          EQU     0x00000008

                BL      wait_for_fly
                CMP     R1, #THIN
                BNE     else

                LDR     R2, =CONTINUE
                B       end_if
else
                BL      catch_it
                LDR     R2, =DIGEST
end_if          NOP
                ADD     R1, SP,#8
				LDR		R1,=-8
				CMP		R1,#8
				CMP		R1,#-8

loop
                B       loop

wait_for_fly
                B       wait_for_fly

catch_it
                B       catch_it

                AREA    myCode1, CODE, READONLY
                ;******************************
                ; compare
                ;******************************

                AREA    myCode2, CODE, READONLY
                ;******************************
                ; test
                ;******************************
                NOP                 ;avoid padding
SWITCH_ADDR     EQU     0x00000704
                LDR	R1,=SWITCH_ADDR
                LDR	R0,[R1]	  	    ; read data from switch
                LDR R2,=0x00000010  ; bitmask
                TST	R0,R2	        ; bit Nr. 4 = 1 ?
                BNE	address	  	    ; if true then branch

address

                AREA    myCode3, CODE, READONLY
                ;******************************
                ; relative jumps
                ;******************************
                NOP
back 	        MOVS  R1,#0x12
                MOVS  R0,#0x29
                B     forward
                NOP
                NOP
                NOP
                NOP
forward	        SUBS  R1,R1,R0
                B     back

                ;SPACE 0x4000

                ;AREA    myCode4, CODE, READONLY, ALIGN=0x2000
                ;******************************
                ; absolute jumps
                ;******************************
                LDR R0,=jmpaddr
                BX  R0
                NOP
                NOP
jmpaddr         ADDS R0,R0,#0x13
                NOP

                AREA    myCode5, CODE, READONLY
                ;******************************
                ; CMP
                ;******************************
                CMP 	R0, R1	; R0 > R1 ?
                BHI 	go_on	; if higher -> go_on
                MOVS	R2,R1	; otherwise exchange registers
                MOVS	R1,R0
                MOVS	R0,R2
go_on           MOVS    R3,#5

                AREA    myCode6, CODE, READONLY
                ;******************************
                ; CMN
                ;******************************
                CMN 	R0, R1	; R0 equal minus R1?
                BEQ 	next
                NOP
                NOP
                NOP
next            MOVS    R3,#5


                AREA    myCode7, CODE, READONLY
                ;******************************
                ; TST
                ;******************************
SWITCH_ADDRESS  EQU 0x60000200
S3_MASK         EQU 0x00000008

                LDR    R1,=SWITCH_ADDRESS
                LDR    R0,[R1]        ; read data from switch
                LDR    R2,=S3_MASK
                TST    R0,R2          ; bit S3 = 1 ?
                BNE    s3_equal_one   ; branch if Z = 0
s3_equal_zero   NOP
                NOP
s3_equal_one    NOP



demoprg
; ------------------------------------------------------------------
; End of code
; ------------------------------------------------------------------
                END
