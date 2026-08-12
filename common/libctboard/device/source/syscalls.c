//
//  ############################################################
//
//                             +
//                ---====D                        @
//       o                    *
//                    *              o
//            |
//           -O-                         =( =         +
//      +     |                   *
//                   ____     ________
//                  /  _/__  / __/ __/    .
//                 _/ // _ \/ _/_\ \             +  .
//        *       /___/_//_/___/___/             |
//                                       -O-         @
//      +                                |
//                      *
//                   ,      .
//           .    `
//       @                +    `~---~~`           *
//
//                   *       .            o         +
//
//
//     Institute of Embedded Systems
//     Zurich University of Applied Sciences
//     8401 Winterthur, Switzerland
//
//
//     File:      syscalls.c
//
//
//     Purpose:   provides dummy implementations for unused
//                syscalls to silence linker warnings
//
//
//     Remarks:   -
//
//
//     Author(s): <scbj@zhaw.ch>
//
//
//     Date:      01/2026
//
//  ############################################################
//

/*
 * used to explicitly load object during the linking stage
 */
__attribute__((weak))
void __init_syscalls(void)
{
    return;
}

__attribute__((weak))
void _close(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _fstat(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _getpid(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _isatty(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _kill(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _lseek(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _read(void)
{
    for(;;);
    return;
}

__attribute__((weak))
void _write(void)
{
    for(;;);
    return;
}

