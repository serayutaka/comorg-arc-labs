.section .data
	matrix_a:
		.word 1, 2, 3
		.word 3, 5, 6

	matrix_b:
		.word 7, 8, 9
		.word 10, 11, 12

	matrix_c:
		.space 24

.section .text

.global _start
_start:
	LDR R0, =matrix_a
	LDR R1, =matrix_b
	LDR R2, =matrix_c
	MOV R3, #6
	LDR R4, [R0] @ A
	LDr R5, [R1] @ B
	
loop:
	CMP R3, #0
	BEQ end
	ADD r4, r4, r5
	STR r4, [r2], #4
	SUB R3, R3,#1
	LDR R4, [r0, #4]!
	LDR r5, [r1, #4]!
	b loop
	
	
end:
	MOV R0, #0
	MOV R7, #1
