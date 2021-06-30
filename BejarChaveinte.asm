#Miguel Chaveinte García
#Pablo Bejar Sierra

.data
Vector:	.space 400 
variable_a:	.word -5
variable_b:	.word 10
variable_c:	.word -50

.text
main: 
	la	$s0,Vector
	la	$t0,variable_a
	lw	$t0,0($t0)
	sw	$t0,0($s0)
	la	$t0,variable_b
	lw	$t0,0($t0)
	sw	$t0,4($s0)
	la	$t0,variable_c
	lw	$t0,0($t0)
	sw	$t0,8($s0)
	li	$t0,3	#i
bucle:
	bge	$t0,100,fin
	sll	$t1,$t0,2
	add	$t1,$t1,$s0	#c[i]
	
	subi	$t2,$t0,3
	sll	$t2,$t2,2
	add	$t2,$t2,$s0
	lw	$t3,0($t2)	#c[i-3]
	
	
	subi	$t2,$t0,2
	sll	$t2,$t2,2
	add	$t2,$t2,$s0
	lw	$t4,0($t2)	#c[i-2]
	
	subi	$t2,$t0,1
	sll	$t2,$t2,2
	add	$t2,$t2,$s0
	lw	$t5,0($t2)	#c[i-1]
	
	add	$t3,$t3,$t4	#c[i-3]+c[i-2]
	sub	$t3,$t3,$t5	#c[i-3]+c[i-2]-c[i-1]
	
	sw	$t3,0($t1)
	
	addi	$t0,$t0,1
	j	bucle
		
fin:
	li	$v0,10
	syscall


	