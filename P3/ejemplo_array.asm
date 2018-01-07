.data
	myArray: 	.space 12
	number: .word 8
.text 
	addi $s1, $zero, 4
	addi $s2, $zero, 9
    la $t3, number
    lw $s3, 0($t3)
	
	#index
	addi $t0, $zero, 0
	sw $s1, myArray($t0)
			addi $t0, $t0, 4
	sw $s2, myArray($t0)
			addi $t0, $t0, 4
	sw $s3, myArray($t0) # para cargar la primera pos
	sub $t0, $t0, 4
	lw $s4, myArray($t0)
	move $a0, $s4
	li $v0, 1
	syscall
