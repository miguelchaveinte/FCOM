#Miguel Chaveinte Garcia
#Pablo Bejar Sierra

.data
Pedir:	.ascii "Dime una cadena:\0"
Resultado: .ascii "La cadena resultante es: \0"
Caracteres: .ascii " y tiene estos caracteres: \0"
A:	.space	200
B:	.space	200
C:	.space	400 

.text
main:
	li	$v0,4
	la	$a0,Pedir	#Imprime cadena de peticion
	syscall
	li	$v0,8
	la	$a0,A
	li	$a1,200
	syscall			#leemos cadena
	
	la	$a1,C
	move	$s0,$a1		#C[0]
	jal	juntar		#copiamos cadenas en la resultante
	move	$s3,$v0		#&C[A.length]
	
	li	$v0,4
	la	$a0,Pedir	#Pedimos la otra cadena
	syscall
	li	$v0,8
	la	$a0,B	
	li	$a1,200
	syscall			#leemos cadena
	
	
	move	$a1,$s3		
	jal	juntar
	move	$s1,$v0		#C[n]
	sub	$s2,$s1,$s0	#caracteres que tiene la cadena
	addi	$a1,$s1,-1	#para apuntar al ultimo caracter y no a \0
	move	$a0,$s0		#C[0]
	jal	invertir	#invertimos cadena
	
	li	$v0,4		#imprimimos cadenas y caracteres
	la	$a0,Resultado
	syscall
	
	li	$v0,4
	move	$a0,$s0
	syscall
	
	li	$v0,4
	la	$a0,Caracteres
	syscall
	
	li	$v0,1
	move	$a0,$s2
	syscall
	
	li	$v0,10		#fin programa
	syscall
	
#################################################

#Funcion que nos copia una cadena pasada por parámetro a otra
#Parametros: $a0 - Dirección Cadena a copiar
#	     $a1 - Dirección Cadena donde se copia
#
#Retorno:    $v0- Dirección que apunta al ultimo caracter de la cadena copiada (\0)
juntar:
	li	$t0,0		#i
	add	$t3,$a1,$t0
	
bucle:
	add	$t1,$a0,$t0 	#&A[i] // &B[i]
	lb	$t2,0($t1)
	beq	$t2,10,salir	#Si ==\n salimos
	beq	$t2,$zero,salir #Si ==\0 salimos
	add	$t3,$a1,$t0	#&C[i]
	sb	$t2,0($t3)
	addi	$t0,$t0,1
	j	bucle
	
salir:
	beq	$t0,$zero,exit
	addi	$t3,$t3,1
	sb	$zero,0($t3)	#ponemos \0
exit:
	move	$v0,$t3
	jr	$ra		#retornamos

#Funcion que nos invierta de sentido una cadena
#Parametros: $a0 - Dirección inicio cadena a invertir &C[0]
#	     $a1 - Dirección final cadena a invertir &C[n]	
invertir:
	lb	$t0,0($a0)
	lb	$t1,0($a1)
	sb	$t1,0($a0)
	sb	$t0,0($a1)
	addi	$a0,$a0,1
	addi	$a1,$a1,-1
	blt	$a0,$a1,invertir
	jr	$ra
	
	

	
	
