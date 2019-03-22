#!/bin/bash 
# riscv-gcc.sh

# Usage: riscv-asm.sh script.c

# This script will create an exectuable binary file that we can run on our FPGA from a C source file.

echo -e "Compiling $FILENAME.c to assembly file"
riscv-none-embed-gcc -march=rv32ec -mabi=ilp32e -fno-verbose-asm -S main.c 

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32i -mabi=ilp32 -o bootloader.o bootloader.s
riscv-none-embed-as -march=rv32i -mabi=ilp32 -o main.o main.s

echo -e "Linking $FILENAME.s to correct memory locations"
riscv-none-embed-ld -Tlink.ld --oformat=elf32-littleriscv -o program.elf main.o bootloader.o

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d program.elf

echo -e "\nCopying binary contents of $FILENAME.elf to a machine code binary file"
riscv-none-embed-objcopy -O binary program.elf program.bin

echo -e "\nWriting binary file to a .mem file so we can use readmemh() in Vivado"
xxd -p -c 1 program.bin > program.mem
