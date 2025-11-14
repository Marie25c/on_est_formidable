.data 

ch : .asciiz "1 exemple d'exemple \n"

.text 

main :

	addiu $29, $29, -4
	sw $0, 0($29)
	
while:
	
	lui $8, 0x1001
	lw $15, 0($29)
	addu $15, $8, $15
	lb $9, 0($15)
	beq $9, $0, fin_while
	
	or $4, $9, $0
	jal min_to_maj_char
	
	sb $2, 0($15)
	
	lw $10,0($29)
	addiu $10, $10, 1
	sw $10,0($29) 
	
	j while

fin_while :	

	addiu $29, $29, 4
	ori $2, $0, 10
	syscall

min_to_maj_char :

	addiu $29, $29, -4
	sw $31, 0($29)
	
	or $9, $4, $0
	ori $11, $0, 0x61
	ori $12, $0, 0x7A
	slt $10,$9,$11 # si ch[i] < a alors 1
	bne $10, $0, after_if
	slt $10,$12,$9 # si z < ch[i] alors 1
	bne $10, $0, after_if 
	
	ori $13, $0, 0x20
	subu $9, $9, $13
	or $2, $9, $0
	
	lw $31, 0($29)
	jr $31
	
after_if :

	lw $31, 0($29)
	or $2, $9, $0
	jr $31