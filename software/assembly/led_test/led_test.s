main:
    li sp, 0x100
    li t0, 0xAAAAAAAA
    li t1, 0xFFFF0000
    sw t0, 0(t1)

loop:
    addi zero,zero,0
    j loop
