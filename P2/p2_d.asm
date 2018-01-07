.data
number1:	.word 4
number2:	.word 5
str:  .asciiz "El resultado es: "
.text
main:	la $s0, number1
					la $s1, number2
					lw $t0, 0($s0)
					lw $t1, 0($s1)
					add	$t2, $t0, $t1
					la $a0, str
					li	$v0, 4
					syscall
					li	 $v0, 1
					la	 $a0, 0($t2)		# para imprimir mi resultado
					syscall
					li 	 $v0, 10				# Para terminar mi programa            
					syscall