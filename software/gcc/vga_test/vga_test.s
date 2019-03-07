	.file	"vga_test.c"
	.option nopic
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-12
	sw	s0,8(sp)
	addi	s0,sp,12
 #APP
# 2 "vga_test.c" 1
	li sp,0x100
# 0 "" 2
 #NO_APP
	li	a5,-286392320
	sw	a5,-12(s0)
	sw	zero,-8(s0)
	j	.L2
.L3:
	lw	a5,-8(s0)
	slli	a5,a5,2
	lw	a4,-12(s0)
	add	a5,a4,a5
	lw	a4,-8(s0)
	sw	a4,0(a5)
	lw	a5,-8(s0)
	addi	a5,a5,1
	sw	a5,-8(s0)
.L2:
	lw	a4,-8(s0)
	li	a5,255
	ble	a4,a5,.L3
.L4:
	j	.L4
	.size	main, .-main
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
