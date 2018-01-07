## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## fibonacci_it.asm -- A program to compute Fibonacci sequence (Iterative)
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
	move $a0, $v0
	bgt $v0, 2, fib_it		# Saving time by not iterating this condition
	li $s1, 1
	jal exit

fib_it:
	li $s1, 2	# Current
	li $t1, 4 	# Condition of my loop (F(n))
	li $t0, 1		# Previous
	li $t2, 0		# Next

loop:
	bgt $t1, $v0, exit
	add $t2, $s1, $t0
	move $t0, $s1
	move $s1, $t2
	addi $t1, $t1, 1
	jal loop

exit:
	la $a0, result
	li $v0, 4
	syscall
	move $a0, $s1  		# Move fact result in $a0 
	li $v0, 1					# Load syscall print-int into $v0 
	syscall						# Make the syscall 
	li $v0, 10					# Load syscall exit into $v0 
	syscall