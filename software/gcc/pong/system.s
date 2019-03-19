	.file	"system.c"
	.option nopic
	.text
	.align	1
	.globl	enable_interrupt
	.type	enable_interrupt, @function
enable_interrupt:
	addi	sp,sp,-4
	sw	s0,0(sp)
	addi	s0,sp,4
 #APP
# 4 "system.c" 1
	csrrw t1, 0xFC0, zero
# 0 "" 2
# 5 "system.c" 1
	ori t1, t1, 1
# 0 "" 2
# 6 "system.c" 1
	csrrw zero, 0x7C0, t1
# 0 "" 2
 #NO_APP
	nop
	lw	s0,0(sp)
	addi	sp,sp,4
	jr	ra
	.size	enable_interrupt, .-enable_interrupt
	.align	1
	.globl	wait_for_interrupt
	.type	wait_for_interrupt, @function
wait_for_interrupt:
	addi	sp,sp,-4
	sw	s0,0(sp)
	addi	s0,sp,4
	nop
	lw	s0,0(sp)
	addi	sp,sp,4
	jr	ra
	.size	wait_for_interrupt, .-wait_for_interrupt
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.1.0"
