    PRESERVE8
    AREA    SCopy, CODE, READONLY
    EXPORT strcopy

strcopy               ; R0 points to destination string.
                      ; R1 points to source string.
    LDRB R2, [R1]     ; Load byte and update address.
    ADDS R1, R1, #1
    STRB R2, [R0]     ; Store byte and update address.
    ADDS R0, R0, #1
    CMP  R2, #0       ; Check for null terminator.
    BNE  strcopy      ; Keep going if not.
    BX   lr           ; Return.
    END