.data

str:  
.asciiz "El resultado es: "
.text

main:
	li	$v0, 5
	syscall
	move $t0, $v0 
	li $v0, 5
	syscall
	#move $t1, $v0
	la $t1, 0($v0)
	add $t2, $t0, $t1
	la $a0, str				#Instrucciones usadas para imprimir por pantalla el str
	li $v0, 4
	syscall
	li $v0, 1
	la $a0, 0($t2)
	syscall
	li $v0, 10            
	syscall