#!/bin/bash 
# riscv-gcc.sh

# Usage: riscv-asm.sh script.c

# This script will create an exectuable binary file that we can run on our FPGA from a C source file.

echo -e "Compiling $FILENAME.c to assembly file"
riscv-none-embed-gcc -march=rv32ec -mabi=ilp32e -fno-verbose-asm -S main.c 

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32ic -mabi=ilp32 -o bootloader_compressed.o bootloader.s
riscv-none-embed-as -march=rv32ic -mabi=ilp32 -o main_compressed.o main.s

echo -e "Linking $FILENAME.s to correct memory locations"
riscv-none-embed-ld -Tlink.ld --oformat=elf32-littleriscv -o program_compressed.elf main_compressed.o bootloader_compressed.o

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d program_compressed.elf

echo -e "\nCopying binary contents of $FILENAME.elf to a machine code binary file"
riscv-none-embed-objcopy -O binary program_compressed.elf program_compressed.bin

echo -e "\nWriting binary file to a .mem file so we can use readmemh() in Vivado"
xxd -p -c 1 program_compressed.bin > program_compressed.mem
