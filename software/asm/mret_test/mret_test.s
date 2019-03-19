# Interrupt handler test
# Written by Jack McEllin

# Initialise the stack pointer
li sp,0x400
j interrupt_setup

# Align the trap handler to 0x10 so we can set out reset vector correctly
.=16
trap:
    # push registers to stack that will be modified
    addi sp, sp, -4
    sw t0, 0(sp)

    # This is where the trap handler would go
    nop

    # restore registers and return from trap handler
    lw t0, 0(sp)
    addi sp, sp, 4

    # Return from handler
    mret

# Enable external interrupts
interrupt_setup:
    csrrw t1, 0xFC0, zero
    ori t1, t1, 1
    csrrw zero, 0x7C0, t1

# Loop waiting for interrupts
loop:
    nop
    j loop
