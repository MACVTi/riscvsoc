main:
    li sp, 0x40
    li t0, 0xAAAAAAAA
    sw t0, 0(zero)
    lw t2, 0(zero)
    li t1, 0xFFFF0000
    sw t2, 0(t1)

loop:
    addi zero,zero,0
    j loop
