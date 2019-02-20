	.file	"add.c"
	.option nopic
	.text
 #APP
	addi sp,zero,0x00000400
 #NO_APP
	.align	2
	.globl	__main
	.type	__main, @function
__main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	sw	zero,-16(s0)
	li	a0,6
	call	factorial
	mv	a4,a0
	lw	a5,-16(s0)
	sw	a4,0(a5)
 #APP
# 11 "add.c" 1
	EBREAK
# 0 "" 2
 #NO_APP
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	__main, .-__main
	.align	2
	.globl	factorial
	.type	factorial, @function
factorial:
	addi	sp,sp,-24
	sw	ra,20(sp)
	sw	s0,16(sp)
	addi	s0,sp,24
	sw	a0,-24(s0)
	li	a5,1
	sw	a5,-16(s0)
	li	a5,1
	sw	a5,-20(s0)
	j	.L3
.L4:
	lw	a5,-20(s0)
	mv	a1,a5
	lw	a0,-16(s0)
	call	multiply
	sw	a0,-16(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	lw	a4,-24(s0)
	bgeu	a4,a5,.L4
	lw	a5,-16(s0)
	mv	a0,a5
	lw	ra,20(sp)
	lw	s0,16(sp)
	addi	sp,sp,24
	jr	ra
	.size	factorial, .-factorial
	.align	2
	.globl	multiply
	.type	multiply, @function
multiply:
	addi	sp,sp,-20
	sw	s0,16(sp)
	addi	s0,sp,20
	sw	a0,-16(s0)
	sw	a1,-20(s0)
	sw	zero,-8(s0)
	li	a5,1
	sw	a5,-12(s0)
	j	.L7
.L8:
	lw	a4,-8(s0)
	lw	a5,-16(s0)
	add	a5,a4,a5
	sw	a5,-8(s0)
	lw	a5,-12(s0)
	addi	a5,a5,1
	sw	a5,-12(s0)
.L7:
	lw	a5,-12(s0)
	lw	a4,-20(s0)
	bgeu	a4,a5,.L8
	lw	a5,-8(s0)
	mv	a0,a5
	lw	s0,16(sp)
	addi	sp,sp,20
	jr	ra
	.size	multiply, .-multiply
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
