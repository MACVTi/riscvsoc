start:
    addi x1,x0,1
    addi x2,x0,2
    sw x1,0(x0)
    sw x2,4(x0)
    addi x1,x0,0
    addi x2,x0,0
    lw x1,0(x0)
    lw x2,4(x0)
    add x3,x1,x2
