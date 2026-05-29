

#include <stdint.h>


uint32_t callee(uint32_t a, uint32_t b, uint32_t c)
{
    return a + b + c;
}

void caller(void)
{
    uint32_t p = 4;
    uint32_t q = 5;
    uint32_t r = 6;
    uint32_t sum;

    sum = callee(p,q,r);
}

uint32_t callee2(uint32_t a, uint32_t b, uint32_t c, uint32_t d, uint32_t e, uint32_t f)
{
    return a + b + c + d + e + f;
}

uint32_t callee3(uint32_t a, uint32_t b, uint32_t c, uint32_t d, uint32_t e, uint32_t f, uint32_t g)
{
    return a + b + c + d + e + f + g;
}


void caller2(void)
{
    uint32_t p = 4;
    uint32_t q = 5;
    uint32_t r = 6;
    uint32_t s = 7;
    uint32_t t = 8;
    uint32_t u = 9;
    uint32_t v = 10;
    uint32_t sum;

    sum = callee2(p,q,r,s,t,u);
    sum = callee3(p,q,r,s,t,u,v);
}

uint32_t my_callee(uint32_t op1, uint32_t op2){
    uint32_t return_value;
    return_value = op1 & op2;
    return return_value;
}

uint32_t my_caller(void)
{
    uint32_t operand1 = 0x00112233;
    uint32_t operand2 = 0x44556677;
    uint32_t result;

    result = my_callee(operand1, operand2);
    result |= 0x01;
    return result;
}

uint32_t sum(void)
{
    uint32_t vr[8] = {0x23};
    uint32_t vr1 = 0x1;
    uint32_t vr2 = 0x2;
    uint32_t vr3 = 0x3;
    uint32_t var1 = 0x11;
    uint32_t var2 = 0x12;
    uint32_t var3 = 0x13;
    uint32_t var4 = 0x14;
    uint32_t sum;
    sum = var1 + var2;
    vr[0] = vr[0] + vr[1] + vr[2] + vr[3];

    return vr[0] + var3 + var4 + sum;
}
