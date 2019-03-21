	.file	"vga_test.c"
	.option nopic
	.text
	.align	1
	.globl	__main
	.type	__main, @function
__main:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	li	a5,1801674752
	addi	a5,a5,330
	sw	a5,-36(s0)
	li	a5,1164136448
	addi	a5,a5,-736
	sw	a5,-32(s0)
	li	a5,1852403712
	addi	a5,a5,-916
	sw	a5,-28(s0)
	li	a5,540688384
	addi	a5,a5,1097
	sw	a5,-48(s0)
	li	a5,925970432
	addi	a5,a5,1329
	sw	a5,-44(s0)
	li	a5,875835392
	addi	a5,a5,304
	sw	a5,-40(s0)
	li	a5,-65536
	sw	a5,-16(s0)
	li	a5,-1431699456
	sw	a5,-20(s0)
	li	a5,-1431695360
	addi	a5,a5,704
	sw	a5,-24(s0)
	lw	a5,-16(s0)
	li	a4,45056
	addi	a4,a4,-1366
	sw	a4,0(a5)
	sw	zero,-8(s0)
	j	.L2
.L3:
	lw	a4,-8(s0)
	li	a5,4096
	addi	a5,a5,544
	add	a5,a4,a5
	lw	a4,-20(s0)
	add	a5,a4,a5
	lw	a4,-8(s0)
	addi	a3,s0,-4
	add	a4,a3,a4
	lbu	a4,-32(a4)
	sb	a4,0(a5)
	lw	a4,-8(s0)
	li	a5,4096
	addi	a5,a5,544
	add	a5,a4,a5
	lw	a4,-24(s0)
	add	a5,a4,a5
	li	a4,4
	sb	a4,0(a5)
	lw	a5,-8(s0)
	addi	a5,a5,1
	sw	a5,-8(s0)
.L2:
	lw	a4,-8(s0)
	li	a5,11
	bleu	a4,a5,.L3
	sw	zero,-12(s0)
	j	.L4
.L5:
	lw	a4,-12(s0)
	li	a5,4096
	addi	a5,a5,624
	add	a5,a4,a5
	lw	a4,-20(s0)
	add	a5,a4,a5
	lw	a4,-12(s0)
	addi	a3,s0,-4
	add	a4,a3,a4
	lbu	a4,-44(a4)
	sb	a4,0(a5)
	lw	a4,-12(s0)
	li	a5,4096
	addi	a5,a5,624
	add	a5,a4,a5
	lw	a4,-24(s0)
	add	a5,a4,a5
	li	a4,2
	sb	a4,0(a5)
	lw	a5,-12(s0)
	addi	a5,a5,1
	sw	a5,-12(s0)
.L4:
	lw	a4,-12(s0)
	li	a5,11
	ble	a4,a5,.L5
.L6:
	j	.L6
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
	bne	a4,a5,.L9
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
.L9:
	nop
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	__interrupt_handler, .-__interrupt_handler
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
