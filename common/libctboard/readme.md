# `libctboard`

This directory contains the startup code and hardware abstraction
layer for the CT board.
The Makefile compiles the sources and builds a static library to be
used in CT laboratories, or other projects using the CT board.

The makefile generates the following build artifacts in the directory
`./lib`:

* `libctboard.a` - statically linked library
* `headers.tar.xz` - archive containing header files
* `startup.s` - startup routine, containing the interrupt vector table

The make file provides a target `lib` which generates both a `.tar.xz`
and a `.zip` archive, all necessary resources to develop for the CT
board.
