	.file	"led_pattern.c"
	.option nopic
	.text
 #APP
	li sp, 0x00000040
 #NO_APP
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16
	li	a5,-65536
	sw	a5,-12(s0)
	sw	zero,-16(s0)
	li	a5,1
	sw	a5,-8(s0)
.L2:
	lw	a5,-12(s0)
	lw	a4,-8(s0)
	sw	a4,0(a5)
	lw	a5,-8(s0)
	addi	a5,a5,1
	sw	a5,-8(s0)
	j	.L2
	.size	main, .-main
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
