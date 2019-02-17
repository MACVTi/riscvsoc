# Use a value that lets us test the different loads and stores
addi x1,x0, 0xFFFFFFFF 

# Check store instructions
sb x1,0(x0)
sh x1,4(x0)
sw x1,8(x0)
lw x2,0(x0)
lw x3,4(x0)
lw x4,8(x0)

# Check load instructions
lb x5,8(x0)
lh x6,8(x0)
lw x7,8(x0)
lbu x8,8(x0)
lhu x9,8(x0)
