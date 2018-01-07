## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## atoi_1.asm -- converts ASCII to iNTEGERS Version1
## code made by Felipe Sandoval Sibada

.data
myArray:		.space 1024
instruction:	.asciiz "Write a word: "
result:			.asciiz "ASCII to integer value is: "
endArray: 	.asciiz "\n"

.text

main:
	la $a0, instruction
	li $v0, 4
	syscall
	li	$v0, 8
	la $a0, myArray
	la $a1, 1024
	syscall
	add $t0, $zero, $zero 			# MI posicion para iterar. Sera la que tenga en mi PRIMER pos del array
	lb $s0, myArray($t0)			# Mi puntero apuntando a la primera pos
	lb $s1, endArray
	add $t1, $zero, $zero			# Valor de mi asciiz

loop:
	beq $s0, $s1, finishing		# comparo y si no salto a ese branch
	add $t1, $t1, $s0
	add $t0, $t0, 1
	lb $s0, myArray($t0)
	jal loop

finishing:
	la $a0, result
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	li $v0, 10            
	syscall
