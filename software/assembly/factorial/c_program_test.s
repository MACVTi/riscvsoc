	.file	"c_program_test.c"
	.option nopic
	.text
	.align	1
	.globl	_start
	.type	_start, @function
_start:
	addi	sp,sp,-20
	sw	ra,16(sp)
	sw	s0,12(sp)
	addi	s0,sp,20
	li	a5,3
	sw	a5,-16(s0)
	call	add
	li	a5,11
	sw	a5,-20(s0)
	nop
	lw	ra,16(sp)
	lw	s0,12(sp)
	addi	sp,sp,20
	jr	ra
	.size	_start, .-_start
	.align	1
	.globl	add
	.type	add, @function
add:
	addi	sp,sp,-8
	sw	s0,4(sp)
	addi	s0,sp,8
	li	a5,7
	sw	a5,-8(s0)
	nop
	lw	s0,4(sp)
	addi	sp,sp,8
	jr	ra
	.size	add, .-add
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
