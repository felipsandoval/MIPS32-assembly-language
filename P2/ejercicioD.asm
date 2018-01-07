.data
number1:	
.word 40, 7				#  Palabras de 4 bytes. 32 bits
number2:	
.word 50, 10, 0, 1
str: 			
.asciiz "El resultado es: "

.text
main:	
	la $t0, number1
	la $t1, number2
	lw $s0, 4($t0)		# ejemplo rebuscado accediendo a la segunda pos de mi array.
	lw $s1, 12($t1)		# accedo a la pos 3 de mi array.
	add	$s2, $s0, $s1
	la $a0, str
	li	$v0, 4
	syscall
	li	 $v0, 1
	la	 $a0, 0($s2)			# para imprimir mi resultado
	syscall
	li 	 $v0, 10				# Para terminar mi programa            
	syscall