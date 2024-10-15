.section .data
hello: 
	.asciz "Hello, World!\n"
.section .text
.global _start

_start:
LDR r0, =1
LDR r1, =hello
LDR r2, =14
MOV r7, #4
SWI 0
MOV r0, #0
MOV r7, #1
SWI 0
