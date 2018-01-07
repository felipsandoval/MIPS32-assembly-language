## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## bigger.asm -- A program that tells you which number is bigger
## code made by Felipe Sandoval Sibada

.data
isBigger:		
.asciiz "The biggest is "
instruction:	
.asciiz "Write a number: "

.text
main:
	la $a0, instruction
	li $v0, 4
	syscall
	li	$v0, 5
	syscall
	la $t0, 0($v0)	# otra manera de hacerlo sin move
	la $a0, instruction
	li $v0, 4
	syscall
	li 	$v0, 5
	syscall
	move $t1, $v0
	bgt $t0, $t1, mayor
	la $a0, isBigger
	li	$v0, 4
	syscall
	li $v0, 1
	la $a0, 0($t1)
	syscall
	b termina

mayor:		# Se ejecutara unicamente cuando sea mayor el primer numero.
	la $a0, isBigger
	li	$v0, 4
	syscall
	la $a0, 0($t0)
	li $v0, 1
	syscall

termina:
	li 	 $v0, 10            
	syscall
