## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## fact_opt.asm -- A program to compute factorial of N, N is going to be 10
## code made by Felipe Sandoval Sibada
.data
msg:
.asciiz 	"The factorial of 10 is: " 

.text 
main:     
	la $a0, msg
	li $v0, 4				# Load syscall print-string into $v0 
	syscall 					# Make the syscall 
			
	li $a0, 10   			# Put argument 10 in $a0 
	jal fact     				# Call factorial function
 
	move $a0, $v0  	# Move fact result in $a0 
	li $v0, 1				# Load syscall print-int into $v0 
	syscall					# Make the syscall 
	li $v0, 10				# Load syscall exit into $v0 
	syscall

fact: 
	bgt $a0, 1, fact_recur
    li $v0, 1
    jr $ra
					
fact_recur: 		
	subu $sp, $sp, 32  	# Stack frame is 32 bytes long 
	sw $ra, 20($sp) 		# Save return address 
	sw $fp, 16($sp) 		# Save frame pointer 
	addiu $fp, $sp, 28	# Set up frame pointer
	sw $a0, 0($fp)			# Save argument (n) 

	subi $a0, $a0, 1
	jal fact
	lw $a0, 0($fp)
	mul $v0, $v0, $a0	# My fact total value
	lw $ra, 20($sp) 
	lw	$fp, 16($sp) 
	addiu $sp, $sp, 32 
	jr $ra
