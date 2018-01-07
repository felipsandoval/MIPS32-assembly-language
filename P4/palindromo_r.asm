## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## palindromo_r.asm -- check for palindrome words - recursive V.
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
	lb $t2, endArray				# Last comparation value
	jal setLastP						# Setting my last posicition
	jal test_palindrome
	beqz $a0, notPalindrome
	li $v0, 4
	la $a0, SiPalindromo
	syscall
	b exiting

setLastP:
	li $t0, 0
	lb $a2, myArray($zero)
loop:
	beq $a2, $t2, setLast			# comparo y si no salto a ese branch
	add $t0, $t0, 1
	lb $a2, myArray($t0)
	j loop
	
setLast:
	sub $t0, $t0, 1
	jr $ra

test_palindrome:
	lb $a1, myArray($t1)
	lb $a2, myArray($t0)
	bne $a1, $a2, falsePalindrome
	
	subu $sp, $sp, 32  	# Stack frame is 32 bytes long 
	sw $ra, 20($sp) 		# Save return address 
	sw $fp, 16($sp) 		# Save frame pointer
	addiu $fp, $sp, 24	# Set up frame pointer
	sw $t1, 0($fp)			# Save argument (first)
	sw $t0, 4($fp)			# Save argument (last)
	add $t1, $t1, 1
	sub $t0, $t0, 1
	bgt $t1, $t0, truePalindrome
	jal test_palindrome
	
	lw $t1, 0($fp)			# restoring value from first
	lw $t0, 4($fp)			# restoring value from last
	lw $ra, 20($sp) 
	lw	$fp, 16($sp) 
	addiu $sp, $sp, 32 
	jr $ra

truePalindrome:
	li $a0, 1
	jr $ra

falsePalindrome:
	li $a0, 0
	jr $ra

notPalindrome:
	li $v0, 4
	la $a0, NoPalindromo
	syscall

exiting:
	li $v0, 10            
	syscall