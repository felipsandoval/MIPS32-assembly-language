.text
main: 	
	li $v0, 5				#Con esta linea leo de pantalla en el registro v0	. LOAD INMEDIATE
	syscall
	move $t0, $v0 		# Con esto muevo el valor a la dirección de memoria a t1
	li $v0, 5
	syscall
	#move $t1, $v0
	la $t1, 0($v0)
	add $t2, $t0, $t1
	#move $a0, $t2
	la $a0, 0($t2)		# Cargo la direccion en a0
	li $v0, 1				# Para imprimir mi programa. FN + f1 para ver instrucciones. Se imprime lo que este en a0
	syscall
	li 	 $v0, 10     		# Para terminar mi programa. Salir de el.   
	syscall