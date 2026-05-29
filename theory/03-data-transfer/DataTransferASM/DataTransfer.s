.section .text.myCode, "ax", %progbits
    .global main

main:
    b trial_start

trial_start:
    @ MOV register to register
    mov     r1, r4              @ low reg to low reg
    mov     r1, r8              @ high reg to low reg
    mov     r8, r1              @ low reg to high reg
    mov     r8, r9              @ high reg to high reg
    movs    r1, r4              @ low reg to low reg

    @ movs r1, r8        @ not possible
    @ movs r8, r1
    @ movs r8, r9

    @ MOVS immediate to register
MY_CONST8 = 0xCD

    movs    r1, #0xFF
    movs    r4, #12
    movs    r7, #MY_CONST8

    @ load from literal pool
    .align 2
ldr_lit:
    ldr     r1, [pc, #0x08]     @ hex offset
    ldr     r2, [pc, #12]       @ dec offset
    ldr     r3, myLit
    ldr     r4, myLit
    ldr     r5, myLit
    b       ldr_lit2

    .align 2
myLit:
    .word   0x12345678
    .word   0x9ABCDEF0

@ LDR pseudo instruction
ldr_lit2:
    ldr     r1, =0x98765432
    ldr     r1, =0x00000012
    ldr     r1, =0x20000012
    b       ldr_lit3
    .ltorg                       @ assemble literal pool immediately

CONST_A = 0x000000AA
CONST_B = 0xBBCCDDEE

ldr_lit3:
    ldr     r7, =0x12
    ldr     r7, =CONST_A
    ldr     r7, =CONST_B
    ldr     r5, mylita
    ldr     r5, =mylita
    b       ldr_dat_init

    .align 2
mylita:
    .word   0xFF001122

    .ltorg

@ init var_array
ldr_dat_init:
    ldr     r1, =my_array
    ldr     r2, =0xFEDCBA98
    str     r2, [r1]
    ldr     r2, =0x76543210
    str     r2, [r1, #0x04]
    ldr     r2, =0xEDCBA987
    str     r2, [r1, #0x08]
    b       ldr_dat
    .ltorg

@ code for slide
ldr_dat:
    ldr     r1, =my_array      @ load address
    ldr     r3, =0x08

    ldr     r4, [r1]
    ldr     r5, [r1, #0x04]
    ldr     r6, [r1, r3]
    b       str_ex
    nop

    .align 2
constArray:
    .word 0x11223344
    .word 0x55667788
    .word 0x99AABBCC
    .ltorg

CONST_C = 0xCCCCCCCC
CONST_D = 0xDDDDDDDD
CONST_E = 0xEEEEEEEE

str_ex:
    ldr     r1, =CONST_C
    ldr     r2, =CONST_D
    ldr     r3, =CONST_E
    ldr     r7, =data_array
    ldr     r6, =0x08
    str     r1, [r7]
    str     r2, [r7, #0x04]
    str     r3, [r7, r6]
    b       ldm_ex

    .align 2
    .ltorg

ldm_ex:
    ldr     r2, =ldm_const
    ldm     r2, {r1, r2, r5-r7}
    b       ldm_ex2

    .align 2
ldm_const:
    .word 0xAAAAAAAA
    .word 0xBBBBBBBB
    .word 0xCCCCCCCC
    .word 0xDDDDDDDD
    .word 0xEEEEEEEE
    .ltorg

ldm_ex2:
    ldr     r2, =ldm_const
    ldm     r2, {r1, r2, r5-r7}
    ldr     r2, =ldm_const
    ldmia   r2, {r1, r2, r5-r7}
    ldr     r2, =ldm_const
    ldm     r2!, {r1, r5-r7}
    @ ldm r2, {r1,r2,r8}  @ not possible

stm_ex:
    ldr     r4, =data_array
    stm     r4!, {r1, r2, r5-r7}
    b       stm_cont

    .align 2
    .ltorg

stm_cont:
loop:
    b loop


@ -------------------------
@ Data sections
@ -------------------------

    .section .progData, "aw", %progbits
my_array:
    .word 0x11223344
    .word 0x55667788
    .word 0x99AABBCC

    .section .progData2, "aw", %progbits
data_array:
    .space 256
