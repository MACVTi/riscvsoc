main:
    li sp,0x400
    j interrupt_setup

.=16
trap:
    # push registers to stack that will be modified
    addi sp, sp, -4
    sw t0, 0(sp)

    # restore registers and return from trap handler
    lw t0, 0(sp)
    addi sp, sp, 4
    mret

interrupt_setup:
    csrrw t1, 0XFC0, zero
    ori t1, t1, 1
    csrrw zero, 0X7C0, t1

loop:
    nop
    j loop
