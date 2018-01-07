.data
myArray:		   			.space 1024
instruction:				.asciiz "Introduce una palabra: "
SiPalindromo: 			.asciiz "La palabra es palindromo. "
NoPalindromo: 		.asciiz "La palabra NO es palindromo."
endArray: 				.asciiz "\n"

.text
main:
	la $a0, instruction
	li $v0, 4
	syscall
	li $v0, 8
	la $a0, myArray
	la $a1, 1024	
	syscall
	lb $s1, 0($a0)						# Mi puntero apuntando a la primera pos
	add $t1, $zero, 0 				# MI posicion para iterar. Sera la que tenga en mi PRIMER pos del array
	add $t2, $zero, 0 				# MI posicion para iterar. Sera la que tenga en mi ultima pos del array
	lb $s2, myArray($t2)
	lb $s3, endArray					# Mi barra n para verificar ultima posicion

setLastP:
	beq $s2, $s3, verify
	add $t2, $t2, 1
	lb $s2, myArray($t2)
	jal setLastP

verify:
	sub $t2, $t2, 1
	lb $s2, myArray($t2)

validity:
	bgt $s1, 122, notValidPOne
	bgt $s2, 122, notValidPTwo
	blt $s1, 48, checkValidPOne
	blt $s2, 48, checkValidPTwo
	bgt $s1, 57, check1POne
	bgt $s2, 57, check1PTwo
	b checking

check1POne:
	blt $s1, 65, notValidPOne
	blt $s1, 97, check2POne
	b checking

check2POne:
	bgt $s1, 90, notValidPOne
	b checking

check1PTwo:
	blt $s2, 65, notValidPTwo
	blt $s2, 97, check2PTwo
	b checking
	
check2PTwo:
	bgt $s2, 90, notValidPTwo
	b checking

checking:
	bne $s1, $s2, isNot
	add $t1, $t1, 1
	sub $t2, $t2, 1
	lb $s1, myArray($t1)
	lb $s2, myArray($t2)
	bgt $t1, $t2, isIt
	jal validity

notValidPOne:
	add $t1, $t1, 1
	lb $s1, myArray($t1)
	b validity

notValidPTwo:
	sub $t2, $t2, 1
	lb $s2, myArray($t2)
	b validity

checkValidPOne:
	add $t3, $s1, 124
	beq $t3, $s2, accentPOne
	add $t4, $s2, 124
	beq $t3, $t4, accentPOne
	add $t3, $s1, 128
	beq $t3, $s2, otheraccentPOne
	add $t4, $s2, 128
	beq $t3, $t4, otheraccentPOne
	b notValidPOne

accentPOne: 
	add $s1, $s1, 124
	b validity

otheraccentPOne: 
	add $s1, $s1, 128
	b validity

checkValidPTwo:
	add $t3, $s2, 124	
	beq $t3, $s1, accentPTwo
	add $t4, $s1, 124
	beq $t3, $t4, accentPTwo
	add $t3, $s2, 128
	beq $t3, $s1, otheraccentPTwo
	add $t4, $s1, 128
	beq $t3, $t4, otheraccentPTwo
	b notValidPTwo

accentPTwo: 
	add $s2, $s2, 124
	b validity

otheraccentPTwo: 
	add $s2, $s2, 128
	b validity

# atencion. puede ser igual pero hay mayusculas y minusculas
isNot:
	bgt $s2, $s1, mayuscula
	add $s2, $s2, 32
	b again

mayuscula:
	sub $s1, $s1, -32
	b again

again:
	bne $s1, $s2, sureNot
	b validity

sureNot:
	la $a0, NoPalindromo
	li $v0, 4
	syscall
	b termina

isIt:
	la $a0, SiPalindromo
	li $v0, 4
	syscall

termina:
	li $v0, 10            
	syscall