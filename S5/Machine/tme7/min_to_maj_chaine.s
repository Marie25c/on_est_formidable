.data 

ch1 : .asciiz "1 exemple \n"
ch2 : .asciiz "Hello word! \n"

.text 

main :
	
	lui $8, 0x1001
	or $4, $0, $8 #$4 <- adresse de ch1
	ori $2, $0, 4
	syscall
	 
	jal min_to_maj # appel fct min_to_maj

	lui $8, 0x1001
	or $4, $0, $8
	ori $2, $0, 4
	syscall 
	
	lui $8, 0x1001
	addiu $9, $8, 0xc #$4 <- adresse de ch2
	or $4, $0, $9
	ori $2, $0, 4
	syscall 
	
	jal min_to_maj
	
	lui $8, 0x1001
	addiu $9, $8, 12
	or $4, $0, $9
	ori $2, $0, 4
	syscall 
	
	ori $2, $0, 10
	syscall
	

min_to_maj :

	addiu $29, $29, -8 # 2 args : adresse de retour + i 
	
	sw $0, 0($29) # i = 0
	sw $31, 4($29) # @ val de retour

while:

	lw $15, 0($29) # lit i
	addu $15, $4, $15 # adresse de chaine à i : @ch + i
	lb $9, 0($15) # chaine[i]
	beq $9, $0, fin_while # chaine[i] != 0x00
	
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
	
	lw $31, 4($29)
	addiu $29, $29, 8
	jr $31

