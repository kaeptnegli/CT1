#include <stdint.h>

static uint32_t array_index;
static uint8_t  byte_array_noinit[20];

/*
 * initialized arrays go to
 * AREA ||.data||, DATA, ALIGN=2
 *
 */
static uint32_t word_array[] = {0xFFEEDDCC,
                                0xBBAA9988,
                                0x77665544,
                                0x33221100};

static uint16_t halfword_array[] =
        {0x0011, 0x2233,
         0x4455, 0x6677,
         0x8899, 0xAABB};

static uint8_t byte_array[] =
        {0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};

/*
 * constant arrays go to
 * AREA ||.constdata||, DATA, READONLY, ALIGN=0
 *
 */
static const uint8_t const_byte_array[] = { 0xAA,0xBB,0xCC,0xDD,
                                            0xEE,0xFF};

/*
 * Example for slides
 */
void access_byte_array(void)
{
    byte_array[3] = 0x12;
}

void access_word_array(void)
{
    word_array[3] = 0xAABBCCDD;
}



void pointer_example(void)
{
    static uint32_t x;
    static uint32_t *xp;

    xp = &x;
    *xp = 0x0C;
}


                                            /*
 * Make use of the variables to avoid compiler warnings
 */
void avoid_warnings(void)
{
    byte_array[0] = byte_array[1];
    byte_array[2] = const_byte_array[2];
    halfword_array[0] = halfword_array[1];
    word_array[0] = word_array[1];
    byte_array_noinit[0] = byte_array[0];
    byte_array[3] = byte_array_noinit[0];
}


void example_function(void)
{
    array_index = 17;
    byte_array_noinit[array_index] = 0;
}

void example_stack_variables(void)
{
    uint32_t a_index;
    uint8_t  b_array[20];

    a_index = 17;
    b_array[a_index] = 0;

    b_array[0] =  b_array[1];
}
