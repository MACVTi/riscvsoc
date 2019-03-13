#!/bin/bash
# riscv-asm.sh

# Usage: riscv-asm.sh script.s

# This script will create an exectuable binary file that we can run on our FPGA from an assembly source file.

# Get input file name
FILE=$1
FILENAME=${FILE%%.*}

# Get this scripts location so we know where to find link.ld
SCRIPTDIR=$(dirname "$(realpath $0)")
LINKLD="$SCRIPTDIR/link.ld"

echo -e "Assembling $FILENAME.s to object file"
riscv-none-embed-as -march=rv32i -mabi=ilp32 -o $FILENAME.o $FILENAME.s

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d -M no-aliases $FILENAME.o

echo -e "Linking $FILENAME.s to correct memory locations"
riscv-none-embed-ld -T$LINKLD --oformat=elf32-littleriscv -o $FILENAME.elf $FILENAME.o

echo -e "\nDisassembling $FILENAME.o for output check"
riscv-none-embed-objdump -d -M no-aliases $FILENAME.elf

echo -e "\nCopying binary contents of $FILENAME.elf to a machine code binary file"
riscv-none-embed-objcopy -O binary $FILENAME.elf $FILENAME.bin

echo -e "\nPrinting $FILENAME.bin to look at produced binary"
xxd -c 4 $FILENAME.bin

echo -e "\nWriting binary file to a .mem file"
xxd -p -c 1 $FILENAME.bin > $FILENAME.mem
