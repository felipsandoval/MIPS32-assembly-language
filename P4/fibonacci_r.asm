## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## fibonacci_r.asm -- A program to compute Fibonacci sequence (Recursive)
## code made by Felipe Sandoval Sibada
.data
msg:
.asciiz 	"Please put a number for the Fibonacci sequence: "
result:
.asciiz "\nYour result is = "

.text 
main:
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5					# To read my fibonacci number 
	syscall
	move $a0, $v0			# a0 is going to have my result of FbSq
	jal fibon     				# Call Fibonacci sequence function
	la $a0, result
	li $v0, 4
	syscall
	move $a0, $a1
	li $v0, 1					# Load syscall print-int into $v0 
	syscall						# Make the syscall 
	li $v0, 10					# Load syscall exit into $v0 
	syscall

fibon:
	bgt $a0, 2, fibon_recur
	li $a1, 1
	jr $ra

fibon_recur:
	subu $sp, $sp, 32  	# Stack frame is 32 bytes long 
	sw $ra, 16($sp) 		# Save return address 
	sw $fp, 12($sp) 		# Save frame pointer
	addiu $fp, $sp, 20	# Set up frame pointer
	sw $a0, 0($fp)			# Save argument (n)
	subi $a0, $a0, 1
	jal fibon
	lw $a0, 0($fp)
	sw $a1, 4($fp)			# saving value from n-1
	subi $a0, $a0, 2
	jal fibon
	lw $t0, 4($fp)			# restoring value ra from n-1
	add $a1, $t0, $a1		# My value
	lw $ra, 16($sp) 
	lw	$fp, 12($sp) 
	addiu $sp, $sp, 32 
	jr $ra
