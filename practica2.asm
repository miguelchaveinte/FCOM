#Miguel Chaveinte Garcia
#Pablo Bejar Sierra

.data
A:	.ascii "Hola Mund\0"
B:	.space	15
C:	.space	15
.align 2
D:	.word	0

.text

main:
	la	$t0,A
	la	$t1,B
	la	$t2,C
	add	$t3,$t0,$s0	#A[i]
	la	$t4,D
	li	$s1,0		#contador para D
	
recorre:	
	lb	$t5,0($t3)
	beq	$t5,$zero,contador	#Si A[i]=='\0'
	addi	$t3,$t3,1
	bne	$t5,32,recorre
	addi	$s1,$s1,1		#suma 1 porque hay espacio en blanco
	j	recorre
	
contador:
	addi	$s1,$s1,1	#suma 1 por fin de cadena
	sw	$s1,0($t4)	#guardamos en D el contador
	sub	$t0,$t3,$t0	#Longitud cadena leida
	beq	$t0,$zero,fin
ejecucion:	
	lb	$t4,-1($t3)
	addi	$t0,$t0,-1
	sb	$t4,0($t2)
	addi	$t2,$t2,1	#movemos el apuntador de C
	beq	$t0,$zero,fin	#comprueba que todavia hay cadena
	lb	$t4,-2($t3)
	addi	$t0,$t0,-1
	sb	$t4,0($t1)
	addi	$t1,$t1,1	#movemos el apuntador de B
	addi	$t3,$t3,-2	#movemos el apuntador de A
	bne	$t0,$zero,ejecucion	#comprueba que todavia hay cadena
fin:
	sb	$zero,0($t2)
	sb	$zero,0($t1)
	li	$v0,10
	syscall
