#!/usr/bin/env bash

# prefix for toolchain packages in MSYS2
PREFIX="mingw-w64-ucrt-x86_64"

# list of required packages
PACKAGES=(
    "git"
    "make"
    "${PREFIX}-arm-none-eabi-toolchain"
    "${PREFIX}-arm-none-eabi-gdb"
    "${PREFIX}-arm-none-eabi-binutils"
    "${PREFIX}-openocd"
)

# system upgrade, terminal can be killed if there is a msys-runtime upgrade
pacman -Syu --noconfirm

# install packages
pacman -S --needed --noconfirm "${PACKAGES[@]}"
