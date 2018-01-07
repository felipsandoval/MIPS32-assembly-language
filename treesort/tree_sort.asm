## Arquitectura de Computadores curso 2017-2018 
## Computer's Architecture (2017-2018)
## tree_sort.asm -- TREE SORT ALGORYTHM
## code made by Felipe Sandoval Sibada

.data
msg:				.asciiz "Write a number [0 for finish]: "
error_msg:	.asciiz "Error: There is no free memory. Finishing... \n"

.text
main:
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beqz $v0, endProgram
	move $s2, $v0				# valor centinela
	move $a0, $s2				# MY VAL - MY NODO RAIZ
	move $a1, $zero			# MY LEFT
	move $a2, $zero			# MY RIGHT
	
	jal tree_node_create 	#(val, left, right)

	move $s0, $v0				# Guardo en $s0 la dir. al nodo raiz del arbol. $V0 es un array de tres direcciones
										# entre ellos mi nodo raiz

in_loop: 							# STEP 2: reading user numbers and inserting them in the tree

	la $a0, msg
	la $v0, 4
	syscall
	li $v0, 5
	syscall
	
	beqz $v0, finishing	# para imprimir si encuentro un zero
	
	move $a0, $v0						# valor a insertar
	move $a1, $s0						# nodo raiz
	
	jal tree_insert
	b in_loop

finishing:
	move $a0, $s0  				#cargo en a0 dir. del nodo raiz
	jal tree_print
	b endProgram

error_mem:
	la $a0, error_msg
	li $v0, 4
	syscall

endProgram:
	li $v0, 10
	syscall
	
tree_node_create: 			# (val, left, right) PARA CREAR NODO RAIZ
	subu $sp, $sp, 32
	sw $ra, 12($sp)
	sw $fp, 8($sp)
	addiu $fp, $sp, 16	

	sw $a0, 0($fp)
	sw $a1, 4($fp)
	sw $a2, 8($fp)
	
	li $a0, 12
	li $v0, 9						# sbrk - allocate HEAP memory
	syscall
	beqz $v0, error_mem 	# To verify if I have any memory left
	
	lw $t0, 0($fp)
	sw $t0, 0($v0)
	lw $t1, 4($fp)
	sw $t1, 4($v0)
	lw $t2, 8($fp)
	sw $t2, 8($v0)

	lw $ra, 12($sp)
	lw $fp, 8($sp)
	addiu $sp, $sp, 32
	jr $ra
	
tree_insert:	# (val, root)
	subu $sp, $sp, 32
	sw $ra, 8($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 16	
	sw $a0, 0($fp)			# value
	sw $a1, 4($fp)			# root
	
	move $a1, $zero
	move $a2, $zero
	
	jal tree_node_create
	
	move $t1, $v0 			# T1 address of my new node
	sw $t1, 8($fp) 			# Guardo dir. del nuevo nodo en la pila (no se si es necesario) nOOOO
	lw $t0, 4($fp) 			# Cargo dir. nodo raiz

tree_loop:	
	lw $t2, 0($fp) 					# cargo val
	lw $t3, 0($t0) 					#  root_val = root->val, valor del nodo raiz
	
    bgt $t2, $t3, right_tree  	# if (val  > root_val) // Recorro subarbol derecho
        
	lw $t4, 4($t0) 					# ptr = root->left
	beqz $t4, left_tree_null 	# si ptr != NULL
	move $t0, $t4 					# root = root.left
	b tree_loop    					# continue

left_tree_null:
	sw $t1, 4($t0) 					# root.left = new_node LEFT;
	b break_out						# break
	
right_tree:
	lw $t4, 8($t0) 					# Cargo root.right
	beqz $t4, right_tree_null # si root.right != NULL
	move $t0, $t4					# root = root.right
	b tree_loop

right_tree_null:
	sw $t1, 8($t0) 					# root.right = new_node RIGHT;
	b break_out						# break

break_out:
	lw $ra, 8($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 32
	jr $ra

tree_print:
	beqz $a0, end_print	
	
	subu $sp, $sp, 32
	sw $ra, 8($sp)
	sw $fp, 4($sp)
	addiu $fp, $sp, 16
	sw $a0, 0($fp)
	lw $a0, 4($t0)
	
	jal tree_print
	
	lw $t0, 0($fp)
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	
	li $a0, 10				# printing a new line. New Line is char 10
	li $v0, 11
	syscall
	
	lw $t0, 0($fp)			# recorriendo el de la derecha
	lw $a0, 8($t0)
	jal tree_print
	
	lw $ra, 8($sp)
	lw $fp, 4($sp)
	addiu $sp, $sp, 32

end_print:
	jr $ra
