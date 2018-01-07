.data
myArray: .space 4
valor1: .word 4, 8
valor2: .word 20, 10
str: .asciiz "El resultado es: "

.text
main:	
			la $a0, myArray
			la $a1, 2
			la $t1, valor1
			la $t2, valor2
			lw $s1, 4($t1)
			lw $s2, 0($t2)
			#index
				add $t0, $zero, 0
			sw $s1, myArray($zero)
				addi $t0, $zero, 4
			sw $s2, myArray($t0)
			add $t3, $s1, $s2
				addi $t0, $zero, 4
			sw $t3, myArray($t0)
			lw $a0, myArray($t0)
			li $v0, 1
			syscall
			li $v0, 10
			syscall
