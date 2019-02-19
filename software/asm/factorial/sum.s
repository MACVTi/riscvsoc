	.file	"sum.c"
	.option nopic
	.text
	.align	1
	.globl	_start
	.type	_start, @function
_start:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	sw	zero,-16(s0)
	li	a0,3
	call	sum
	mv	a4,a0
	lw	a5,-16(s0)
	sw	a4,0(a5)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	_start, .-_start
	.align	1
	.globl	sum
	.type	sum, @function
sum:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	sw	a0,-16(s0)
	sw	zero,-8(s0)
	li	a5,1
	sw	a5,-12(s0)
	j	.L3
.L4:
	lw	a4,-8(s0)
	lw	a5,-16(s0)
	add	a5,a4,a5
	sw	a5,-8(s0)
	lw	a5,-12(s0)
	addi	a5,a5,1
	sw	a5,-12(s0)
.L3:
	lw	a4,-12(s0)
	lw	a5,-16(s0)
	ble	a4,a5,.L4
	lw	a5,-8(s0)
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	sum, .-sum
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
