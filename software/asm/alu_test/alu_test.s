# RISC-V Instruction Test

# Register <-> Immediate Instructions
addi x1,x1,2    # The value 2 should be in x1 - Working
slti x2,x1,4    # The value 1 should be in x1 - Working
sltiu x3,x1,4   # The value 1 should be in x1 - Working
xori x4,x1,7    # The value 5 should be in x1 - Working
ori x5,x1,13    # The value 15 should be in x1 - Working
andi x6,x1,3    # The value 2 should be in x1 - Working
slli x7,x1,1    # The value 4 should be in x1 - Working
srli x8,x1,1    # The value 1 should be in x1 - Working
srai x9,x1,1    # The value 1 should be in x1 - Unknown

# Clear Registers
addi x1,x0,0
addi x2,x0,0
addi x3,x0,0
addi x4,x0,0
addi x5,x0,0
addi x6,x0,0
addi x7,x0,0
addi x8,x0,0
addi x9,x0,0
addi x10,x0,0
addi x11,x0,0
addi x12,x0,0
addi x13,x0,0
addi x14,x0,0
addi x15,x0,0

# Get ready for next test
addi x1,x0, 2
addi x2,x0, 1

# Register <-> Register Instructions
add x3,x1,x2   # The value 2 should be in x1 - Working
sub x3,x1,x2   # The value 2 should be in x1 - Working
sll x3,x1,x2   # The value 2 should be in x1 - Working
slt x3,x1,x2   # The value 2 should be in x1 - Working
sltu x3,x1,x2  # The value 2 should be in x1 - Working
xor x3,x1,x2   # The value 2 should be in x1 - Working
srl x3,x1,x2   # The value 2 should be in x1 - Working
sra x3,x1,x2   # The value 2 should be in x1 - Working
or x3,x1,x2    # The value 2 should be in x1 - Working

