.data
	msg1: .asciiz "\nDigite um numero (1 < n <= 50000): "
	msg2: .asciiz "Numero invalido! Tente novamente.\n"
	msg3: .asciiz "\nO primeiro primo anterior e: "
	msg4: .asciiz "\nNao existe primo anterior a 2."
.text
main:
	li $v0, 4
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	add $t0, $v0, 0

	blt $t0, 2, invalido
	bgt $t0, 50000, invalido
	j valido

invalido:
	li $v0, 4
	la $a0, msg2
	syscall
	j main

valido:
	beq $t0, 2, sem_primo

	sub $t1, $t0, 1

enquanto_candidato:
	li $t2, 2
	li $t3, 1

enquanto_divisor:
	mul $t4, $t2, $t2
	bgt $t4, $t1, fim_divisor

	rem $t5, $t1, $t2
	beq $t5, 0, nao_primo

	add $t2, $t2, 1
	j enquanto_divisor

nao_primo:
	li $t3, 0

fim_divisor:
	beq $t3, 1, achou
	sub $t1, $t1, 1
	j enquanto_candidato

achou:
	li $v0, 4
	la $a0, msg3
	syscall

	li $v0, 1
	add $a0, $t1, 0
	syscall
	j fim

sem_primo:
	li $v0, 4
	la $a0, msg4
	syscall

fim:
	li $v0, 10
	syscall