#Miguel Chaveinte Garcia
#Pablo Bejar Sierra

#PRACTICA FINALIZADA: 121 CASOS SUPERADOS.
#Request 01972

.data
len: .ascii "len\0"
lwc: .ascii "lwc\0"
upc: .ascii "upc\0"
cat: .ascii "cat\0"
cmp: .ascii "cmp\0"
chr: .ascii "chr\0"
rchr: .ascii "rchr\0"
str: .ascii "str\0"
rev: .ascii "rev\0"
rep: .ascii "rep\0"

Entrada: .space 2050
Operacion: .space 50 
Operando1: .space 1000
Operando2: .space 1000

Salida: .space 2000

Error: .ascii "ENTRADA INCORRECTA\0"

Igual: .ascii "IGUAL\0"
Mayor: .ascii "MAYOR\0"
Menor: .ascii "MENOR\0"


.text
main:
	la	$a0,Entrada
	li	$a1,2050
	li	$v0,8
	syscall
	
	la	$s1,Operacion
	la	$s2,Operando1
	la	$s3,Operando2
	la	$s4,Salida
	
	move	$a1,$s1
	move	$a2,$s2
	move	$a3,$s3
	jal	funcion_separar
	move	$s5,$v0
	beq	$s5,-1,sacar_error	#error por mas argumentos o 1 solo
	
	move	$a0,$s1
	la	$a1,len
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f1
	move	$a0,$s2
	move	$a1,$s4
	jal	funcion_len
	beq	$v1,666,imprimir_salida		#el return en $v1 de 666 indica que la funcion se ha ejecutado y correctamente

analisis_f1:	
	move	$a0,$s1
	la	$a1,lwc
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f2
	move	$a0,$s2
	move	$a1,$s4
	jal	funcion_lwc
	beq	$v1,666,imprimir_salida

analisis_f2:		
	move	$a0,$s1
	la	$a1,upc
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f3
	move	$a0,$s2
	move	$a1,$s4
	jal	funcion_upc
	beq	$v1,666,imprimir_salida
	
analisis_f3:
	move	$a0,$s1
	la	$a1,rev
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f4
	move	$a0,$s2
	move	$a1,$s4
	jal	funcion_rev
	beq	$v1,666,imprimir_salida
	
################################### funciones de 3 parametros

analisis_f4:	
	
	bne	$s5,2,sacar_error	#comprobar que tienen los 2 argumentos
	
	
	move	$a0,$s1
	la	$a1,cat
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f5
	move	$a0,$s2
	move	$a1,$s3
	move	$a2,$s4
	jal	funcion_cat
	beq	$v1,666,imprimir_salida

analisis_f5:	
	move	$a0,$s1
	la	$a1,cmp
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f6
	move	$a0,$s2
	move	$a1,$s3
	move	$a2,$s4
	jal	funcion_cmp
	beq	$v1,666,imprimir_salida_cmp

analisis_f6:	
	move	$a0,$s1
	la	$a1,chr
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f7
	move	$a0,$s2
	move	$a1,$s3
	move	$a2,$s4
	jal	funcion_chr
	beq	$v1,666,imprimir_salida

analisis_f7:	
	move	$a0,$s1
	la	$a1,rchr
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f8
	move	$a0,$s2
	move	$a1,$s3
	move	$a2,$s4
	jal	funcion_rchr
	beq	$v1,666,imprimir_salida

analisis_f8:	
	move	$a0,$s1
	la	$a1,str
	jal	funcion_cmp
	bne	$v0,$zero,analisis_f9
	move	$a0,$s2
	move	$a1,$s3
	move	$a2,$s4
	jal	funcion_str
	beq	$v1,666,imprimir_salida

analisis_f9:	
	move	$a0,$s1
	la	$a1,rep
	jal	funcion_cmp
	bne	$v0,$zero,sacar_error
	move	$a0,$s2
	move	$a1,$s3
	move	$a2,$s4
	jal	funcion_rep
	beq	$v0,-1,sacar_error
	beq	$v1,666,imprimir_salida

######################################################33
sacar_error:
#Imprime el mensaje de error
	la 	$a0,Error
	li	$v0,4
	syscall		
	
	li	$v0,10
	syscall	
	
imprimir_salida:
#Imprime la cadena salida
	move	$a0,$s4
	li	$v0,4
	syscall
	li	$v0,10
	syscall
	
imprimir_salida_cmp:
	beq	$v0,$zero,salida_iguales
	beq	$v0,1,salida_mayor
	la	$a0,Menor	
	li	$v0,4
	syscall
	li	$v0,10
	syscall

salida_iguales:
	la	$a0,Igual	
	li	$v0,4
	syscall
	li	$v0,10
	syscall
		
salida_mayor:
	la	$a0,Mayor	
	li	$v0,4
	syscall
	li	$v0,10
	syscall
#################################################################
	
	
###############################################################################
funcion_separar:
#a0 : Entrada que metieron por teclado
#a1 : Operacion
#a2 : Operando 1
#a3 : Operando 2

	li	$t0,0			#contador parametos
	li	$v0,0

separar:
	lb	$t3,0($a0)	
	beq	$t3,$zero,salir		#Si es igual \0
	blt	$t3,33,continuar1	#si es un espacio o  tabulador
	sb	$t3,0($a1)
	addi	$a1,$a1,1	
	addi	$a0,$a0,1
	j	separar
continuar1:
	sb	$zero,0($a1)		#guardamos \0 
bucle_espacios: 
	addi	$a0,$a0,1		#obviamos los espacios y tabuladores
	lb	$t3,0($a0)
	beq	$t3,$zero,salir
	blt	$t3,33,bucle_espacios
	
	#ya caracter
	beq	$t0,1,continuar2	#para operando2
	beq	$t0,2,error_label	#ya todo los operandos maximos
	add	$t0,$t0,1
	move	$a1,$a2		#Operando1
	j	separar
	
continuar2:
	add	$t0,$t0,1
	move	$a1,$a3		#Operando2
	j	separar
	

error_label:	
	li	$v0,-1			#codigo error mas de tres palabras
	jr	$ra

salir:
	beq	$t0,$zero,error_label
	move	$v0,$t0
	jr	$ra
	

	
##############################################################################	

funcion_cmp:
#a0 : Cadena 0
#a1 : Cadena 1
#return: $v0: 0 si las cadenas son iguales, 1 si a0 es mayor que a1, -1 si es menor

	li	$v0,0
	li	$v1,666	
bucle_cmp:
	lb	$t2,0($a0)
	lb	$t3,0($a1)
	addi	$a0,$a0,1
	addi	$a1,$a1,1
	add	$t4,$t2,$t3
	beq	$t4,$zero,fin_cmp
	beq	$t2,$t3,bucle_cmp
	blt	$t2,$t3,menor1
	add	$v0,$v0,2
menor1:
	add	$v0,$v0,-1
fin_cmp:
	jr	$ra
	
#############################################################################3

funcion_len:
#$a0: operando1
#$a1: cadena salida
	addi 	$sp, $sp, -4 # reserva un lugar en la pila
	sw 	$ra, 0($sp)
	
	li	$v1,666	
	
	li	$t0,-1
	
bucle_len:
	lb	$t1,0($a0)
	addi	$t0,$t0,1
	addi	$a0,$a0,1
	bne	$t1,$zero,bucle_len
	
fin_len:
	move	$a0,$t0
	jal 	funcion_hex
	lw 	$ra, 0($sp)
	addi 	$sp, $sp,4
	jr	$ra
	
	
#################################################

#Funcion que nos guarda en una cadena el numero pasado como argumento en hexadecimal
#Parametros: $a0 - Entero en decimal a convertirl
#	     $a1 - Dirección Cadena donde se pone su conversión en decimal
#

funcion_hex:
	li	$t0,0
	move	$t3,$a1
		
bucle:	
	andi	$t1,$a0,0xf0000000	#mascara
	srl	$t1,$t1,28		#cogemos la parte enmascarada
	sll	$a0,$a0,4		#movemos a los otros 4 bits
	addi	$t0,$t0,1
	bgt	$t0,8,salir_hex		#8 iteraciones
	addi	$t1,$t1,48
	blt	$t1,58,menor
	addi	$t1,$t1,39
menor:
	add	$t2,$t3,$t0		#&A[i]
	sb	$t1,-1($t2)		#A[i]=caracter // -1 en desplazamiento porque $t0 ya esta incrementado
	j	bucle
salir_hex:
	add	$t2,$t3,$t0		#&A[i]
	sb	$zero,-1($t2)		#fin de cadena
	jr	$ra
	
#######################################################################################

funcion_lwc:

#$a0: operando1
#$a1: cadena salida

	li	$v1,666	
bucle_lwc:
	lb	$t1,0($a0)
	addi	$a0,$a0,1
	bgt	$t1,96,guardar_lwc
	blt	$t1,65,guardar_lwc
	addi	$t1,$t1,32
	
guardar_lwc:
	sb	$t1,0($a1)
	addi	$a1,$a1,1
	bne	$t1,$zero,bucle_lwc
	jr	$ra
	
#######################################################################################

funcion_upc:
#$a0: operando1
#$a1: cadena salida

	li	$v1,666	
bucle_upc:
	lb	$t2,0($a0)
	addi	$a0,$a0,1
	blt	$t2,97,guardar_upc
	bge	$t2,123,guardar_upc
	addi	$t2,$t2,-32
guardar_upc:
	sb	$t2,0($a1)
	addi	$a1,$a1,1
	bne	$t2,$zero,bucle_upc
	jr	$ra	
	
#######################################################################################

funcion_cat:
#$a0 Cadena1
#$a1 Cadena2
#$a2 Salida

	li	$t7,0
	li	$v1,666	
bucle1_cat:
	lb	$t3,0($a0)
	addi	$a0,$a0,1
	sb	$t3,0($a2)
	addi	$a2,$a2,1
	bne	$t3,$zero,bucle1_cat
bucle2_cat:
	addi	$a2,$a2,-1
	move	$a0,$a1
	addi	$t7,$t7,1
	bne	$t7,2,bucle1_cat
	jr	$ra
	
#################################################################################
funcion_chr:
#$a0 Cadena1
#$a1 Cadena2
#$a2 Salida
	addi 	$sp, $sp, -4 # reserva un lugar en la pila
	sw 	$ra, 0($sp)
	
	li	$v1,666	
	
	lb	$t1,0($a0)
	move	$t2,$a1
	
bucle_chr:			
	lb	$t3,0($t2)
	add	$t2,$t2,1
	beq	$t3,$zero,no_encontrado_chr
	bne	$t1,$t3,bucle_chr
	sub	$t0,$t2,$a1
fin_chr:
	move	$a0,$t0
	move	$a1,$a2
	jal 	funcion_hex
	lw 	$ra, 0($sp)
	addi 	$sp, $sp,4
	jr	$ra
no_encontrado_chr:
	li	$t0,0	
	j	fin_chr				
		
#################################################################################
funcion_rchr:
#$a0 Cadena1
#$a1 Cadena2
#$a2 Salida
				
	addi 	$sp, $sp, -4 # reserva un lugar en la pila
	sw 	$ra, 0($sp)
	
	li	$v1,666	
	
	lb	$t1,0($a0)
	move	$t2,$a1	
	
	li	$t5,-1	
	
recorrer_cadena:
	lb	$t3,0($t2)
	addi	$t2,$t2,1
	bne	$t3,$zero,recorrer_cadena
	addi	$t2,$t2,-1
	sub	$t4,$t2,$a1
	addi	$t2,$t2,-1

bucle_rchr:			
	lb	$t3,0($t2)
	add	$t2,$t2,-1
	addi	$t5,$t5,1
	beq	$t3,$zero,no_encontrado_rchr
	bne	$t1,$t3,bucle_rchr
	sub	$t0,$t4,$t5
	
fin_rchr:
	move	$a0,$t0
	move	$a1,$a2
	jal 	funcion_hex
	lw 	$ra, 0($sp)
	addi 	$sp, $sp,4
	jr	$ra
no_encontrado_rchr:
	li	$t0,0	
	j	fin_rchr	
#############################################################################	
	
funcion_str:
#$a0 Cadena1
#$a1 Cadena2
#$a2 Salida
	addi 	$sp, $sp, -4 # reserva un lugar en la pila
	sw 	$ra, 0($sp)
	li	$t3,0
	li	$t6,0

	move	$t0,$a1
	
	li	$v1,666	
	
nueva_busqueda:
	li	$t1,0
	add	$t1,$a0,$t1
	lb	$t5,0($t1)
	add	$t0,$t0,$t6
	li	$t6,0
bucle_str:
	lb	$t2,0($t1)
	beq	$t2,0,retornar_str
	lb	$t4,0($t0)
	beq	$t4,0,retornar_str
	addi	$t0,$t0,1
	bne	$t2,$t4,nueva_busqueda
	addi	$t1,$t1,1
	bne	$t4,$t5,bucle_str
	addi	$t6,$t6,-1
	j	bucle_str
retornar_str:
	beq	$t1,$a0,no_encontradostr
	bne	$t2,0,no_encontradostr
	sub	$t1,$t1,$a0
	sub	$t3,$t0,$a1
	sub	$t1,$t1,$t3
	abs	$a0,$t1	
	addi	$a0,$a0,1

fin_str:
	move	$a1,$a2
	jal 	funcion_hex
	move	$a0,$s0
	move	$a1,$s1
	lw 	$ra, 0($sp)
	addi 	$sp, $sp,4
	jr	$ra
		
no_encontradostr:
	li	$a0,0
	j	fin_str
	
	
############################################################################################
funcion_rev:
#a0 cadena1
#a1 salida:	
	move	$t2,$a0
	
	li	$v1,666	
	
recorrer_cadena_rev:
	lb	$t3,0($t2)
	addi	$t2,$t2,1
	bne	$t3,$zero,recorrer_cadena_rev
	addi	$t2,$t2,-2
guardar_cadena_rev:
	lb	$t3,0($t2)
	addi	$t2,$t2,-1
	sb	$t3,0($a1)
	addi	$a1,$a1,1
	bge	$t2,$a0,guardar_cadena_rev
salir_rev:
	sb	$zero,0($a1)
	jr	$ra	
	
##########################################################################

funcion_rep:
#a0 cadena1
#a1 numero
#a2 salida
	li	$t0,0
	
	li	$v1,666	
	
obtener_numero:
	lb	$t4,0($a1)
	addi	$a1,$a1,1
	beq	$t4,$zero,hacer_cadena_rep
	beq	$t0,$zero,analisis_primero
analisis_byte:
	blt	$t4,48,error_numero_rep
	addi	$t4,$t4,-48
	blt	$t4,10,guardar_numero_rep
	addi	$t4,$t4,-7
analisis_letra_rep:
	blt	$t4,10,error_numero_rep
	blt	$t4,16,guardar_numero_rep
	addi	$t4,$t4,-32
	j	analisis_letra_rep
	
analisis_primero:
	bne	$t4,48,analisis_byte

error_numero_rep:
	li	$v0,-1
	jr	$ra

guardar_numero_rep:
	sll	$t0,$t0,4
	add	$t0,$t0,$t4
	j	obtener_numero
	
hacer_cadena_rep:
	ble	$t0,$zero,error_numero_rep
	move	$t6,$a0
bucle_cadena_rep:
	lb	$t5,0($t6)
	addi	$t6,$t6,1
	sb	$t5,0($a2)
	addi	$a2,$a2,1
	bne	$t5,$zero,bucle_cadena_rep
	addi	$a2,$a2,-1
	addi	$t0,$t0,-1
	move	$t6,$a0
	bne	$t0,$zero,bucle_cadena_rep
	jr	$ra
	
	
