/* ------------------------------------------------------------------
* --  _____       ______  _____                                    -
* -- |_   _|     |  ____|/ ____|                                   -
* --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
* --   | | | '_ \|  __|  \___ \   Zurich University of             -
* --  _| |_| | | | |____ ____) |  Applied Sciences                 -
* -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
* ------------------------------------------------------------------
* --
* -- main.c
* --
* -- main for "CT_ParameterPassing"
* --
* -- $Id: main.c 537 2014-08-29 12:21:09Z muln $
* ------------------------------------------------------------------
*/
#include <stdio.h>


// Start Code Folie 20

//int32_t calcSomething(uint16_t val){
//  uint32_t myArray[8] = {0x1122, 0x2233, 0x3344, 0x4455, 0x5566, 0x6677, 0x7788, 0x8899};
//  uint32_t result = 0;
//  uint8_t i;
//
//  myArray[0] = val;
//
//  for(i = 0; i < 8; i++){
//    result += myArray[i];
//  }

//  return result;
//}

//int main(void)
//{
//  uint16_t start = 0x1234;
//a  uint32_t result = 0;
//
//  result = calcSomething(start);
//}

// End Code Folie 20

// Start Code Folie 22

extern void strcopy(char *d, const char *s);

int main()
{
  const char *srcstr = "First string - source";
  char dststr[] = "Second string";
  strcopy(dststr,srcstr);
  return (0);
}

// End Code Folie 22
