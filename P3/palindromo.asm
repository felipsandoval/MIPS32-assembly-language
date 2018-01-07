## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## palindromo.asm -- A program that tells you is a word is palindrome.
## NOTE: this code is in spanish.
## code made by Felipe Sandoval Sibada

.data
	myArray:		   		.space 1024
	instruction:			.asciiz "Introduce una palabra: "
	SiPalindromo: 		.asciiz "La palabra es palindromo. "
	NoPalindromo: 	.asciiz "La palabra NO es palindromo."
	endArray: 			.asciiz "\n"

.text
	main:
		la $a0, instruction
		li $v0, 4
		syscall
		li $v0, 8
		la $a0, myArray				# Address of my Array
		la $a1, 1024						# Maximum bit value
		syscall
		lb $s0, myArray($zero)
		lb $s1, myArray($zero)
		addi $t1, $zero, 0 			# MI posicion para iterar. Sera la que tenga en mi PRIMER pos del array
		addi $t0, $zero, 0 			# MI posicion para iterar. Sera la que tenga en mi ultima pos del array
		lb $t2, endArray				# Mi ultima posicion

setLastP:
		beq $s1, $t2, verify			# comparo y si no salto a ese branch
		add $t0, $t0, 1
		lb $s1, myArray($t0)
		jal setLastP

verify:
		sub $t0, $t0, 1
		lb $s1, myArray($t0)

loop:
		bne $s0, $s1, isNot
		add $t1, $t1, 1
		sub $t0, $t0, 1
		lb $s0, myArray($t1)
		lb $s1, myArray($t0)
		bgt $t1, $t0, itIs
		jal loop

isNot:
		la $a0, NoPalindromo
		li $v0, 4
		syscall
		b exiting

itIs:
		la $a0, SiPalindromo
		li $v0, 4
		syscall

exiting:
		li $v0, 10            
		syscall
