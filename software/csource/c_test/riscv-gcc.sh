#!/bin/bash

# This script will compile a c file into RV32I binary with the start location at 0

FILE=$1
FILENAME=${FILE%%.*}

echo -e "Compiling $FILENAME.c to assembly file"
riscv-none-embed-gcc -march=rv32ec -mabi=ilp32e -S ctest.c -fno-verbose-asm

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32ic -mabi=ilp32 -o $FILENAME.o $FILENAME.s

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d $FILENAME.o

echo -e "\nRelocating $FILENAME.o to $FILENAME.bin to change start location to 0"
riscv-none-embed-objcopy -O binary ctest.o ctest.bin
# riscv-none-embed-ld -e 0 --oformat binary -o $FILENAME.bin $FILENAME.o

echo -e "\nPrinting $FILENAME.bin to look at produced binary"
xxd -c 4 $FILENAME.bin
