.data
	prompt: .asciz "Enter a positive decimal number: "
	input: .space 256
	err: .asciz "Invalid Input"
.text

.global _start

_start:
	@ Display prompt
	mov r7, #4
	mov r0, #1
	ldr r1, =prompt
	mov r2, #33
	svc 0
	
	@ Read input
	mov r0, #0
	ldr r1, =input
	mov r2, #255
	mov r7, #3
	svc 0
	
	mov r4, #0
	
convert_loop:
	ldrb r2, [r1], #1
	cmp r2, #10
	beq end_convert
	cmp r2, #'0'
	blt invalid_input
	cmp r2, #'9'
	bgt invalid_input
	sub r2, r2, #'0'
	mov r3, r4, lsl #3
	add r3, r3, r4, lsl #1
	add r4, r3, r2
	b convert_loop
	
end_convert:
	cmp r4, #0
	ble invalid_input
	
	b exit
	
invalid_input:
	mov r0, #1
	ldr r1, =err
	mov r2, #14
	mov r7, #4
	svc 0

exit:
	mov r7, #1
	mov r0, #0
	svc 0
	
	
