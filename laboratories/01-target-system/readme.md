# Target System

<!--toc:start-->

- [Target System](#target-system)
  - [Introduction](#introduction)
  - [Learning Objectives](#learning-objectives)
  - [Procedure and Terminology](#procedure-and-terminology)
    - [Program Structure](#program-structure)
    - [CT-Board Wiki](#ct-board-wiki)
  - [**Task**: Setup work your
    environment](#task-setup-work-your-environment)
  - [**Task**: Write your own C program](#task-write-your-own-c-program)
    - [Functions to read from and write to the
      memory](#functions-to-read-from-and-write-to-the-memory)
    - [Reading the DIP switches and writing to the
      LEDs](#reading-the-dip-switches-and-writing-to-the-leds)
  - [**Task**: Extend the C program](#task-extend-the-c-program)
    - [Additional DIP switches](#additional-dip-switches)
    - [Control a seven segment
      display](#control-a-seven-segment-display)
  - [Grading](#grading) <!--toc:end-->

## Introduction

In this laboratory you will familiarise yourself with the CT Board and
its input and output capabilities.

## Learning Objectives

- You can compile a C program, link it and load the executable onto the
  target system
- You know the input and output options of the CT board
- You are able to write simple C programs for reading switches,
  controlling LEDs and a 7-segment display

## Procedure and Terminology

For all our labs, we use a target system (CT-Board) based on the STM32F4
microcontroller. The PC (host) serves as a development system (editing,
compiling and assembling etc.) to build an executable of the program.
Next the generated executable is loaded through USB onto the CT Board.

### Program Structure

The programs which you are going to write are usually repetitive. E.g.
changes on input devices (switch position, etc.) can only be detected
through repetitive queries. This type of query is called polling.
Therefore, the main program has to contain an infinite loop:

``` c
int main(void) {
    /* initialization */
    for (;;) {
        /* application */
    }
}
```

Of course, in real systems this does not always make sense, the
processor is permanently active and consumes energy. Therefore, most
processors have mechanisms with which they can go to sleep until they
are woken up by an external event. This is a topic for CT2 though.

### CT-Board Wiki

Most information about the CT-Board can be found on the [CT-Board Wiki
(ennis.zhaw.ch)](https://ennis.zhaw.ch/). Heres an non-exhaustive list
of information to be found on ennis:

- setting up a project for assembly or C
- GPIO assignment
- addresses and explanations (with examples) for all peripherals

## **Task**: Setup work your environment

Follow the guide in the Rootlevel Readme (`../readme.md`) and setup your
work environment. You can either choose to work directly with the
Makefiles, or install Visual Studio Code.

## **Task**: Write your own C program

The next step will be to read the switch states from the associated
memory address and write the values to the associated LED address.

### Functions to read from and write to the memory

The module `utils_ctboard` provides functions to access the memory. It
contains interface declarations in the headerfile `utils_ctboard.h` and
the implementation in the `utils_ctboard.c`.

Study the header file:

- Which functions are provided by the module?
- Which parameters have to be passed to each of the functions?
- Which return values are returned by the function?

Add the module utils_ctboard to your C-project.

> - Copy both files utils_ctboard.h and utils_ctboard.c to the app
>   directory of your project.
> - Add the file utils_ctboard.c to your project by using the menu entry
>   “Add Existing Files to …”.
> - utils_ctboard.h does not have to be added. Keil uVision only needs
>   to know which *.c files belong to the project. The *.h files will be
>   included in the \*.c files through the \#include statement.

### Reading the DIP switches and writing to the LEDs

Write a program which repeatedly reads a single byte from the dip
switches S7 till S0 (at the address `0x6000_0200`) and writes those
values to LED7 till LED0 (at the address `0x6000_0100`).

> - Include the functions of utils_ctboard in your main.c by using
>   \#include “utils_ctboard.h”.
> - Which function is used to read a single byte and to write a single
>   byte respectively?
> - Define appropriate macros (#define) for the memory addresses, which
>   you are using in the function call.
> - Define an appropriate variable for the read value. Implement the
>   output of this variable on an individual line. This will simplify
>   debugging

Create an executable of your program, run the debugger and start the
program. Check the correct function of your program with different
positions of the dip switches.

> - Read the root level readme for instructions on these steps.
> - Familiarize yourself with the features of the debugger like “Single
>   Stepping” and “Breakpoints”.
> - Checkout the Register View. It displays the contents of the
>   processors registers at every step.

## **Task**: Extend the C program

### Additional DIP switches

Change your program to read the values of all DIP switches (31..0) and
display the values on the LEDs (31..0).

> - This can be achieved by reading and writing a word (32 bits) at
>   once. The addresses stay the same.
> - This task is an extension of the first program. No need to show the
>   first task seperately.

Check the correct function of your program with different positions of
the DIP switches.

### Control a seven segment display

Expand your program further. Additionally, read the value of the Hex
rotary switch P11 from address `0x6000_0211` and output the read value
on the seven-segment display DS0 at address `0x6000_0110`. The
conversion to seven segment code shall be done in software and not using
the provided “hardware” module at address `0x6000_0114`.

> - After reading the byte the value of the rotary switch will be
>   located in the least significant nibble (bits B3 – B0). Extract the
>   value of the rotary switch through an AND-operation with a mask of
>   `0x0F`. This removes the upper 4 bits.
> - To control the seven-segment display an array holding 16 elements of
>   the type const uint8_t can be defined. The element with index 0
>   contains the bit pattern for the number 0 the element with index 1
>   contains the bit pattern for the number 1, etc. Determine the bit
>   patterns accordingly. Keep in mind that the individual segments of
>   the display are active-low. The value read from the rotary switch is
>   used as an index to access the array.
> - On the 7-segment display the uppercase letter B cannot be
>   distinguished from the number 8. Likewise, the uppercase letter D
>   cannot be distinguished from the number 0. Therefore, display the
>   hex numbers as lower case b and d to allow a distinction.
> - For debugging purposes, you can output the value read from address
>   `0x6000_0211` on the LEDs at address `0x6000_0100`. In parallel, you
>   can output the value of the seven-segment display (i.e. the value of
>   the array access) on the LEDs at address 0x6000‘0101.

Verify the correct function with all possible positions of the rotary
switch.

## Grading

The working program has to be presented to the lecturer. The
**individual** student has to understand the solution/source code and
has to be able to explain it to the lecturer.

| **Criteria** | **Weight** |
|:---|:--:|
| [**Task**: Write your own C program](#task-write-your-own-c-program) | 2 / 4 |
| [**Task**: Extend the C program](#task-extend-the-c-program) | 2 / 4 |
