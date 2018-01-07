## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## primos.asm -- 100 Prime numbers - recursive
## code made by Felipe Sandoval Sibada
.data 
newLine:	.asciiz "\n"

.text

main:
	li $t0, 2		# for iterate my loop. my N
	li $t1, 1		# my other loop iterator. my D

loop:
	bgt $t0, 100, finish
	jal test_prime
	beq $a0, $zero, notPrint
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, newLine
	syscall
	addi $t0, $t0, 1					# next char
	addi $t1, $t1, 1					# next char
	jal loop

notPrint:
	addi $t0, $t0, 1					# next char
	jal loop

test_prime:		# Basically a boolean. a1 = 1 for TRUE, a1 = 0 for FALSE
	beq $t1, 1, truePrime
	div $t0, $t1
	mfhi $t2
	beqz $t2, falsePrime
	
	subu $sp, $sp, 32  	# Stack frame is 32 bytes long 
	sw $ra, 20($sp) 		# Save return address 
	sw $fp, 16($sp) 		# Save frame pointer
	addiu $fp, $sp, 24	# Set up frame pointer
	sw $t0, 0($fp)			# Save argument (n)
	sw $t1, 4($fp)			# Save argument (d)
	subi $t1, $t1, 1
	jal test_prime
	
	lw $t1, 4($fp)			# restoring value from d
	lw $ra, 20($sp) 
	lw	$fp, 16($sp) 
	addiu $sp, $sp, 32 
	jr $ra

truePrime:
	li $a0, 1
	jr $ra

falsePrime:
	li $a0, 0
	jr $ra

finish:
	li $v0, 10
	syscall
