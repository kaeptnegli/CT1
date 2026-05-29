

                AREA    myCode, CODE, READONLY

                ALIGN 4
switch_case     PROC
                EXPORT  switch_case

NR_CASES        EQU  6

                LDR  R1, _n
case_switch     CMP  R1, #NR_CASES
                BGE  case_default

                LSLS R1, #2     ; *4
                LDR  R7, =jump_table
                LDR  R7, [R7, R2]
                BX   R7

case_0          ADDS R2, R2, #17
                B    end_sw_case

case_1          ADDS R2, R2, #13

case_3_5        ADDS R2, R2, #37
                B    end_sw_case

case_default    MOVS R2,#0

end_sw_case     NOP
                B    .

                NOP

jump_table      DCD     case_0
                DCD     case_1
                DCD     case_default
                DCD     case_3_5
                DCD     case_default
                DCD     case_3_5

_n              DCD     5

                ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if_else         PROC
                EXPORT  if_else
                CMP     R1,#0x00
                BLT     else
                MOVS    R2,#1
                B       end_if
else
                MOVS    R2,#0

end_if          NOP

false           NOP
                NOP
                ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
do_while        PROC
                EXPORT  do_while

                MOVS    R2,#0
loop            ADDS    R2,R2,R1
                CMP     R2,#100
                BLT     loop

                ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
while           PROC
                EXPORT  while

                MOVS   R2,#1
                B      test
loop1
                MULS   R2,R1,R2
test
                CMP    R2,#100
                BLT    loop

                ENDP

                NOP
                END