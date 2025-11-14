.data

ch : .asciiz "1 exemple \n"

.text

main :

	addiu $29, $29, -4
	
	sw $0, 0($29)
	
	lui $8, 0x1001
	or $4, $0, $8
	ori $2, $0,4
	syscall 

while:
	
	lui $8, 0x1001
	lw $15, 0($29)
	addu $15, $8, $15
	lb $9, 0($15)
	beq $9, $0, fin_while
	
	ori $11, $0, 0x61
	ori $12, $0, 0x7A
	slt $10,$9,$11 # si ch[i] < a alors 1
	bne $10, $0, after_if
	slt $10,$12,$9 # si z < ch[i] alors 1
	bne $10, $0, after_if 
	
	ori $13, $0, 0x20
	subu $9, $9, $13
	sb $9, 0($15)	
	
	
after_if :

	lw $10,0($29)
	addiu $10, $10, 1
	sw $10,0($29) 
	
	j while
	
fin_while:

	lui $8, 0x1001
	or $4, $0, $8
	ori $2, $0, 4
	syscall 

	addiu $29, $29, 4
	ori $2, $0, 10
	syscall
	
	
