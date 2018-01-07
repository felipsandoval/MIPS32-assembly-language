## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## atoi_1.asm -- converts ASCII to iNTEGERS Version2
## code made by Felipe Sandoval Sibada

.data
myArray: .space 1024
instruction: .asciiz "Write your sentence: "
result: .asciiz "ASCII to integer value is:  "
endArray:  .asciiz "\n"

.text

main:
	la $a0, instruction
	li $v0, 4
	syscall
	li	$v0, 8
	la $a0, myArray					# Getting text from User
	la $a1, 1024							# My last position is my "\n", remember that
	syscall
	add $t0, $zero, $zero 			# My index position to go through the aray
	lb $s0, myArray($t0)			# My pointer in pos. 0
	lb $s1, endArray
	add $t1, $zero, $zero			# Variable with the total value of my ascii
	add $t2, $zero, 1					# T2 is going to mult. t1. this case is positive
	bne $s0, 45, loop					# If equal is negative.
	mul $t2, $t2, -1					# T2 is going to mult. t1. this case is negative
	add $t0, $t0, 1
	lb $s0, myArray($t0)

loop:
	beq $s0, $s1, finish			# Checking if my pointer is in the last pos. \n
	add $t1, $t1, $s0
	add $t0, $t0, 1
	lb $s0, myArray($t0)
	jal loop

finish:
	la $a0, result
	li $v0, 4
	syscall
	mul $t1, $t1, $t2
	move $a0, $t1
	li $v0, 1
	syscall
	li $v0, 10            
	syscall
