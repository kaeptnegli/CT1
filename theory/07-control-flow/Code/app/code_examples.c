

#include <stdint.h>




int main(void)
{
    int32_t nr, isPositive;

    if (nr >= 0) {
        isPositive = 1;
    }
    else {
        isPositive = 0;
    }
}

void while_example(void)
{
    int32_t nr, sum;

    sum = 0;
    do {
        sum += nr;
    } while (sum < 100);
}

void do_while_example(void)
{
    int32_t nr, prod;

    prod = 1;
    while (prod < 100) {
        prod *= nr;
        //prod = nr * prod;
    }
}
