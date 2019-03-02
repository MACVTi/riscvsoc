# Initialise Stack Pointer
addi sp,zero, 0x400

# Set MEIE bit to 1
csrrw t1, 0XFC0, zero
ori t1,t1,1
csrrw zero, 0X7C0, t1

# Read MSTATUS to check that MEIE was set to one
csrrw t2, 0XFC0, zero
ebreak
