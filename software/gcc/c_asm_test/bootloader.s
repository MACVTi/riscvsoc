# Bootloader assembly for RV32EC processor
# Written by Jack McEllin

.global __entry

.section .text.prologue

# This is where the reset vector points to
__entry:
    # Initialise Stack Pointer
    li sp,0x40

    # Enable external interrupts
    csrrw t1, 0xFC0, zero
    ori t1,t1,1
    csrrw zero, 0x7c0, t1

    # Start User C Program
    j __main

.=32
__isr:
    # TODO: add stack preservation
    jal x1, __interrupt_handler

    # See if this is returned to from C program
    mret

.text
