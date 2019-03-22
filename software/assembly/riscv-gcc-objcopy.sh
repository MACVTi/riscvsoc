#!/bin/bash 
# riscv-gcc.sh
# This script will create an exectuable binary file that we can run on our FPGA from a C source file.

FILE=$1
FILENAME=${FILE%%.*}

echo -e "Compiling $FILENAME.c to assembly file"
riscv-none-embed-gcc -march=rv32ec -mabi=ilp32e -S $FILENAME.c -fno-verbose-asm

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32i -mabi=ilp32 -o $FILENAME.o $FILENAME.s

echo -e "Linking $FILENAME.s to correct memory locations"
riscv-none-embed-ld -Tlink.ld --oformat=elf32-littleriscv -o $FILENAME.elf $FILENAME.o

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d -M no-aliases $FILENAME.elf

echo -e "\nCopying binary contents of $FILENAME.elf to a machine code binary file"
riscv-none-embed-objcopy -O binary $FILENAME.elf $FILENAME.bin

echo -e "\nPrinting $FILENAME.bin to look at produced binary"
xxd -c 4 $FILENAME.bin

echo -e "\nWriting binary file to a .mem file so we can use readmemh() in Vivado"
xxd -p -c 1 $FILENAME.bin > $FILENAME.mem
