## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## bublesort.asm -- A program that uses bublesort to re-arrenge numbers
## DOES NOT ALLOW ZEROS AS INPUT
## code made by Felipe Sandoval Sibada

.data
myArray:
	.space 1024
instruction:				
	.asciiz "Write a number: "
newLine:
	.asciiz "\n"

.text

main:
	li $t0, 1		# For iterating in my loop
	li $t1, 0		# My array index

loop:				# To read all my numbers and store it in a word value array
	bgt $t0, 20, arrange
	la $a0, instruction
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, myArray($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	jal loop

arrange:
	li $t0, 0		# First pos
	li $t1, 4		# Last pos
repeat:
	lw $s0, myArray($t0)
	lw $s1, myArray($t1)
	beq $s1, 0, exit
	bgt $s0, $s1, Do
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	jal repeat

Do:
	sw $s0, myArray($t1)
	sw $s1, myArray($t0)
	jal arrange
	
exit:
	li $t0, 1		# For iterating in my loop
	li $t1, 0		# My Array index

print:
	bgt $t0, 20, finish
	li $v0, 1
	lw $a0, myArray($t1)
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	jal print

finish:
	li $v0, 10
	syscall
