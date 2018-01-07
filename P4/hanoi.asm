## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## hanoi.asm -- A program to compute Hanoi Tower (Recursive)
## code made by Felipe Sandoval Sibada

.data
	msg:			.asciiz "Number of disks (1-8): "
	moved:		.asciiz "Moving disk "
	from:		.asciiz " from peg "
	to:			.asciiz " to peg "
	newLine:	.asciiz "\n"

.text
main: 
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	la $a0, newLine
	li $v0, 4
	syscall
	move $a0, $t0
	
	li $a1, 1	#start
	li $a2, 2	#finish
	li $a3, 3	#extra
	jal hanoi

endop:
	li $v0, 10
	syscall

hanoi:	# hanoi(n, start, finish, extra)
	bgtz $a0, hanoi_r
	b return_hanoi

hanoi_r:
	subu $sp, $sp, 32
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addiu $fp, $sp, 16

	sw $a0, 0($fp)			# storing all my arguments
	sw $a1, 4($fp)			# start
	sw $a2, 8($fp)			# finish
	sw $a3, 12($fp)		# extra

	subu $a0, $a0, 1
	lw $a2, 12($fp)			# extra
	lw $a3, 8($fp)			# finish
	jal hanoi				# hanoi(n-1, start, extra, finish)
	
	la $a0, moved		# print_string "Move disk”
	li $v0, 4
	syscall
	
	lw $a0, 0($fp)		# print n
	li $v0, 1
	syscall
	
	la $a0, from			# print_string " from ”
	li $v0, 4
	syscall
	
	lw $a0, 4($fp)		# print start
	li $v0, 1
	syscall

	la $a0, to				# print_string " to "
	li $v0, 4
	syscall
	
	lw $a0, 8($fp)		# print finish
	li $v0, 1
	syscall
	
	la $a0, newLine	# print new Line
	li $v0, 4
	syscall
	
	lw $a0, 0($fp)
	subu $a0, $a0, 1
	lw $a1, 12($fp)		# extra
	lw $a2, 8($fp)		# finish
	lw $a3, 4($fp)		#start

	jal hanoi				#OTRA VEZ hanoi(n - 1, extra, finish, start)

	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 32

return_hanoi:
	jr $ra