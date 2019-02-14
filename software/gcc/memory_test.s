	.file	"memory_test.c"
	.option nopic
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-4
	sw	s0,0(sp)
	addi	s0,sp,4
	li	a5,1
	li	a4,65
	sb	a4,0(a5)
	li	a5,0
	mv	a0,a5
	lw	s0,0(sp)
	addi	sp,sp,4
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
