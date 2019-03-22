# True - BEQ/BNE
addi x1,x0,1
addi x2,x0,1

beq x1,x2,equal
addi x3,x0,2

equal:
addi x4,x0,2

bne x1,x2,notequal
addi x5,x0,2

notequal:
addi x6,x0,2

# False - BEQ/BNE
addi x1,x0,2
addi x2,x0,3

beq x1,x2,equal2
addi x3,x0,2

equal2:
addi x4,x0,2

bne x1,x2,notequal2
addi x5,x0,2

notequal2:
addi x6,x0,2

# True - BLT/BGE
addi x1,x0,2
addi x2,x0,3

blt x1,x2,less
addi x3,x0,2

less:
addi x4,x0,2

bge x1,x2,greater
addi x5,x0,2

greater:
addi x6,x0,2

# False - BLT/BGE
addi x1,x0,3
addi x2,x0,2

blt x1,x2,less2
addi x3,x0,2

less2:
addi x4,x0,2

bge x1,x2,greater2
addi x5,x0,2

greater2:
addi x6,x0,2

# True - BLTU/BGEU
addi x1,x0,2
addi x2,x0,3

bltu x1,x2,lessu
addi x3,x0,2

lessu:
addi x4,x0,2

bgeu x1,x2,greateru
addi x5,x0,2

greateru:
addi x6,x0,2

# False - BLTU/BGEU
addi x1,x0,3
addi x2,x0,2

bltu x1,x2,less2u
addi x3,x0,2

less2u:
addi x4,x0,2

bgeu x1,x2,greater2u
addi x5,x0,2

greater2u:
addi x6,x0,2
