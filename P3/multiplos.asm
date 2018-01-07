## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## multiplos.asm -- Multiplying AxB
## code made by Felipe Sandoval Sibada

.data
instruction:		
	.asciiz "Write a number: "
zeroUsed:		
	.asciiz "Don't use a zero. Program ended."
newLine: 			
	.asciiz "\n"

.text
main:
	la $a0, instruction
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s1, 0($v0)
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s2, 0($v0)			# A = t1, B = t2 cond = t0, total = $t3
	beqz $s2, isZero		# Is my B = zero ?

while:
	bgt $s1, $s2, termina
	mul $s3, $s1, $s2
	li $v0, 1
	la $a0, 0($s3)
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	addi $s1, $s1, 1
	jal while

isZero:
	la $a0, zeroUsed
	li $v0, 4
	syscall

termina:
	li 	 $v0, 10            
	syscall
