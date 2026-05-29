#include <stdint.h>

uint32_t halali;
int32_t intA = 3;
int32_t intB;

/* ------------------------------------------------------------------
 * -- Main function
 * ------------------------------------------------------------------
 */

int main(void)
{
    int32_t i;

    i=-2550;

    halali = 0xAB;

    for (i = 0; i < 10; i++) {
        halali++;
    }
}

int32_t invertSign(void)
{
    intB = -intA;
    return (intB);
}

void example(void)
{
    uint32_t a;

    if (a != 0) {
        a++;
    }
}
