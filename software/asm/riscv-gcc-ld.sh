#!/bin/bash

# This script will compile a assembler file into RV32I binary with the start location at 0

FILE=$1
FILENAME=${FILE%%.*}

echo -e "Compiling $FILENAME.c to assembly file"
riscv-none-embed-gcc -march=rv32ec -mabi=ilp32e -S $FILENAME.c -fno-verbose-asm

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32i -mabi=ilp32 -o $FILENAME.o $FILENAME.s

echo -e "\nLinking $FILENAME.o to correct the memory addresses"
riscv-none-embed-ld -Tlink.ld --oformat=elf32-littleriscv -o $FILENAME.elf $FILENAME.o

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d -M no-aliases $FILENAME.elf

echo -e "\nRelocating $FILENAME.o to $FILENAME.bin to change start location to 0"
riscv-none-embed-objcopy -O binary $FILENAME.elf $FILENAME.bin

echo -e "\nPrinting $FILENAME.bin to look at produced binary"
xxd -c 4 $FILENAME.bin

echo -e "\nWriting binary file to a .mem file"
xxd -p -c 1 $FILENAME.bin > $FILENAME.mem
