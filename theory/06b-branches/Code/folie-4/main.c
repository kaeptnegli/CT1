/* -----------------------------------------------------------------
* --  _____       ______  _____                                    -
* -- |_   _|     |  ____|/ ____|                                   -
* --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
* --   | | | '_ \|  __|  \___ \   Zurich University of             -
* --  _| |_| | | | |____ ____) |  Applied Sciences                 -
* -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
* ------------------------------------------------------------------
* --
* -- Module main.c
* --
* -- Code für CT06_Sprungbefehle Folie 4
* --
* -- $Id: main.c 508 2014-08-28 08:18:10Z ruan $
* ------------------------------------------------------------------
*/


#include "stm32f4xx.h"
#include "io.h"

/* == main ================================================================ */

void catchIt(void)
{
}
int waitforfly(void)
{
    return 10;
}

int main(void)
{

    // Code für BSP CT06_Sprungbefehle bsp 1
    static int thin = 10;
    int doit = 0, fly;
    static int digest = 10;
    static int cont = 20;

    fly = waitforfly();
    if (fly == thin){
        doit = cont;
    } else {
	catchIt();
    doit = digest;
    }
}

