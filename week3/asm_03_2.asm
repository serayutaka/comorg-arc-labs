.data
	hex: .word 0x0C
	res: .space 20 @ Allocate 20 bytes for the output string

.global _start	
	
_start:
	ldr r0, =hex	@ Load address of hex to r0
	ldr r0, [r0]	@ Load value of that address
	ldr r1, =res
	bl setup_loop
	
	@ Display result
	mov r0, #1		@ Tell Linux to the stdout
	ldr r1, =res	
	mov r2, #20		@ Tell Linux kernal to allocate for 20 bytes
	mov r7, #4		@ Syscall for write
	svc 0			@ Software Interrupt (Call Linux Kernal)
	
	B exit
	
	
setup_loop:
	push {LR}
	mov r2, r1		@ Assign address of res to r2
	mov r3, #10
	
	mov r4, r0		@ Assign hex to r4
	mov r5, r2		@ Assign address of res to r5
	add r5, r5, #20	@ Plus 20 to address of res to point it at the end
	
convert_to_string:
	udiv r7, r4, r3
	mls r8, r7, r3, r4
	add r8, r8, #'0'
	sub r5, r5, #1
	strb r8, [r5]
	mov r4, r7
	
	cmp r4, #0
	bne convert_to_string
	
	sub r5, r5, #1
	mov r8, #0
	strb r8, [r5]
	
	mov r1, r5
	pop {LR}
	bx lr
	
exit:
	mov r7, #1
	mov r0, #0
	svc 0
	
