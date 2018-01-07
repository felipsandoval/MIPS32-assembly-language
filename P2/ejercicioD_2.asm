.data
number1:	
.half 5, 3, 40				# En este son palabras de 2 bytes. 16 bits
number2:
.half 5, 0, 20
str: 			
.asciiz "El resultado es: "

.text
main:	
	la $t0, number1
	la $t1, number2
	lh $s0, 4($t0)
	lh $s1, 2($t1)
	add	$s2, $s0, $s1
	la $a0, str
	li $v0, 4
	syscall
	la $a0, 0($s2)
	li $v0, 1
	syscall
	li $v0, 10				# Para terminar mi programa            
	syscall