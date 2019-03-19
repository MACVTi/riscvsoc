	.file	"vga_test.c"
	.option nopic
	.text
	.align	1
	.globl	__main
	.type	__main, @function
__main:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	li	a5,-65536
	sw	a5,-8(s0)
	li	a5,4
	sw	a5,-12(s0)
	sw	zero,-16(s0)
	lw	a5,-8(s0)
	sw	zero,0(a5)
	lw	a5,-12(s0)
	sw	zero,0(a5)
	lw	a5,-16(s0)
	sw	zero,0(a5)
.L2:
	j	.L2
	.size	__main, .-__main
	.align	1
	.globl	__interrupt_handler
	.type	__interrupt_handler, @function
__interrupt_handler:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	li	a5,-65536
	sw	a5,-8(s0)
	li	a5,4
	sw	a5,-12(s0)
	sw	zero,-16(s0)
	lw	a5,-16(s0)
	lw	a5,0(a5)
	addi	a4,a5,1
	lw	a5,-16(s0)
	sw	a4,0(a5)
	lw	a5,-16(s0)
	lw	a4,0(a5)
	li	a5,60
	bne	a4,a5,.L5
	lw	a5,-16(s0)
	sw	zero,0(a5)
	lw	a5,-12(s0)
	lw	a5,0(a5)
	addi	a4,a5,1
	lw	a5,-12(s0)
	sw	a4,0(a5)
	lw	a5,-12(s0)
	lw	a4,0(a5)
	lw	a5,-8(s0)
	sw	a4,0(a5)
.L5:
	nop
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	__interrupt_handler, .-__interrupt_handler
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
