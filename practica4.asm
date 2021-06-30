#Miguel Chaveinte Garcia
#Pablo Bejar Sierra

.data
Pedir:	.ascii "Dime un número: \0"
Resultado: .ascii "El número en hexadecimal: 0x\0"
A:	.space	9	

.text
main:
	li	$v0,4
	la	$a0,Pedir	#Imprime cadena de peticion
	syscall
	li	$v0,5
	syscall			#leemos entero
	
	move	$a0,$v0
	la	$a1,A
	move	$s0,$a1
	jal 	func_hex
	
	li	$v0,4
	la	$a0,Resultado	#Imprime cadena de resultado
	syscall
	
	li	$v0,4
	move	$a0,$s0
	syscall			#Imprime número en hexadecimal
	
	li	$v0,10
	syscall


#################################################

#Funcion que nos guarda en una cadena el numero pasado como argumento en hexadecimal
#Parametros: $a0 - Entero en decimal a convertirl
#	     $a1 - Dirección Cadena donde se pone su conversión en decimal
#

func_hex:
	li	$t0,0
	move	$t3,$a1
		
bucle:	
	andi	$t1,$a0,0xf0000000	#mascara
	srl	$t1,$t1,28		#cogemos la parte enmascarada
	sll	$a0,$a0,4		#movemos a los otros 4 bits
	addi	$t0,$t0,1
	bgt	$t0,8,salir		#8 iteraciones
	addi	$t1,$t1,48
	blt	$t1,58,menor
	addi	$t1,$t1,39
menor:
	add	$t2,$t3,$t0		#&A[i]
	sb	$t1,-1($t2)		#A[i]=caracter // -1 en desplazamiento porque $t0 ya esta incrementado
	j	bucle
salir:
	add	$t2,$t3,$t0		#&A[i]
	sb	$zero,-1($t2)		#fin de cadena
	jr	$ra
	
	
