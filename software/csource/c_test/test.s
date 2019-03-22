.globl test
.text

loop:
	add x5, x6, x7
	addi x6, zero, 64
	j loop
