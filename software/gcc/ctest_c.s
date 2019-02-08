	.file	"ctest.c"
	.option nopic
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,20
	li	a0,10
	call	add
	sw	a0,-16(s0)
	call	halt
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.align	1
	.globl	add
	.type	add, @function
add:
	addi	sp,sp,-12
	sw	s0,8(sp)
	addi	s0,sp,12
	sw	a0,-8(s0)
	sw	a1,-12(s0)
	lw	a4,-8(s0)
	lw	a5,-12(s0)
	add	a5,a4,a5
	mv	a0,a5
	lw	s0,8(sp)
	addi	sp,sp,12
	jr	ra
	.size	add, .-add
	.align	1
	.globl	halt
	.type	halt, @function
halt:
	addi	sp,sp,-4
	sw	s0,0(sp)
	addi	s0,sp,4
.L5:
	j	.L5
	.size	halt, .-halt
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
