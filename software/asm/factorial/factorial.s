	.file	"factorial.c"
	.option nopic
	.text
	.align	1
	.globl	__entry__
	.type	__entry__, @function
__entry__:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	sw	zero,-16(s0)
	li	a0,10
	call	factorial
	mv	a4,a0
	lw	a5,-16(s0)
	sw	a4,0(a5)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	j end
	.size	__entry__, .-__entry__
	.globl	__mulsi3
	.align	1
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
	lw	a1,-20(s0)
	lw	a0,-16(s0)
	call	__mulsi3
	mv	a5,a0
	sw	a5,-16(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L3:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	ble	a4,a5,.L4
	lw	a5,-16(s0)
	mv	a0,a5
	lw	ra,20(sp)
	lw	s0,16(sp)
	addi	sp,sp,24
	jr	ra
	.size	factorial, .-factorial
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"

end:
    nop
