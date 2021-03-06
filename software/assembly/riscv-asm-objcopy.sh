#!/bin/bash
# riscv-asm.sh

# This script will compile a assembler file into RV32I binary with the start location at 0

FILE=$1
FILENAME=${FILE%%.*}

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32i -mabi=ilp32 -o $FILENAME.o $FILENAME.s

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d -M no-aliases $FILENAME.o

echo -e "\nRelocating $FILENAME.o to $FILENAME.bin to change start location to 0"
riscv-none-embed-objcopy -O binary $FILENAME.o $FILENAME.bin

echo -e "\nPrinting $FILENAME.bin to look at produced binary"
xxd -c 4 $FILENAME.bin

echo -e "\nWriting binary file to a .mem file"
xxd -p -c 1 $FILENAME.bin > $FILENAME.mem
