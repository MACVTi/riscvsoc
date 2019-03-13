main:
    li sp, 0x40
    li t1, 0xFFFF0000
    sw t0, 0(t1)        # Store variab
    j loop

.=16
interrupt:

loop:
    j loop
