#include <stdint.h>

static uint32_t double_the_value(uint32_t value);

struct parameters {
    uint32_t p1;
    uint32_t p2;
    uint32_t p3;
    uint32_t p4;
    uint32_t p5;
    uint32_t p6;
};

/*
 *
 */
uint32_t my_func(void)
{
    uint32_t example_value;

    example_value = 3;
    return double_the_value(example_value);
}

/*
 *
 */
static uint32_t double_the_value(uint32_t value)
{
    uint32_t local_value;

    local_value = 2 * value;
    return local_value;
}

/*
 *
 */
static uint32_t test_sum3(uint32_t a, uint32_t b, uint32_t c){
    uint32_t sum;
    uint32_t test;

    sum = a + b + c;
    if (sum > 37){
        test = 1;
    } else {
        test = 0;
    }
    return test;
}

/*
 *
 */
static uint32_t test_sum2(uint32_t a, uint32_t b){
    uint32_t sum;
    uint32_t test;

    sum = a + b;
    if (sum > 37){
        test = 1;
    } else {
        test = 0;
    }
    return test;
}

/*
 *
 */
static uint32_t test_sum1(uint32_t a){
    uint32_t sum;
    uint32_t test;

    sum = a + a;
    if (sum > 37){
        test = 1;
    } else {
        test = 0;
    }
    return test;
}

/*
 *
 */
static uint64_t test_long3(uint64_t a, uint64_t b, uint64_t c){
    uint64_t sum;
    uint64_t test;

    sum = a + b + c;
    if (sum > 37){
        test = 1;
    } else {
        test = 0;
    }
    return test;
}


uint32_t caller_test_sum(void){
    uint32_t var1;
    uint32_t var2;
    uint32_t var3;
    uint32_t tmp;
    var1 = 1;
    var2 = 2;
    var3 = 4;
    tmp = test_sum3(var1,var2,var3);
    tmp = test_long3(3,4,6);
    return tmp;
}

    //uint32_t array[8];
/*    for (i = 0;i<8;i++){
        array[i] = i;
    }*/

uint32_t callee_struct(struct parameters p)
{
    uint32_t sum;
    sum = p.p1 + p.p2 + p.p3 + p.p4 + p.p5 + p.p6;
    return sum;
}


uint32_t caller_struct(void)
{
    struct parameters param = {0x11,0x22,0x33,0x44,0x55,0x66};

    callee_struct(param);
}

