.data 

chaine : .space 11

.text 

	lui $8,0x1001
	lb $9, 0($8)	# &chaine[0]
	addiu $29, $29, -16 

main :

	ori $2, $0, 5
	syscall

	sw $2, 0($29) # nb
	
	sb $0,10($8) # caract fin de chaine
	
	ori $10, $0, 9 # i
	sw $10, 4($29) # i dans pile
	
	ori $11,$0, 0 # r
	sb $11, 8($29) # r dans pile
	
	sw $0, 12($29) # nbzero
	
	ori $24, $0, 10 #10
	ori $25, $0, 1 #1


for : 	lw $10, 4($29)
	lw $9, 12($29)
	beq $10, $9, fin_for # i >= 0

	lw $14, 0($29)
	divu $14, $24 # nb / 10
	
	mflo $11 # r
	sw $11, 8($29)
	
	mfhi $14 # nb
	sw $14, 0($29)
	
	addu $13, $8, $10 #&chaine[i]
	addiu $11, $11, 0x30
	
	sb $11, 0($13) 
	
	subu $10, $10, $25
	sw $10, 4($29)
	j for

fin_for :
	
	addiu $29, $29, 16 
	
	or $4, $0, $9
	ori $2, $0, 4
	syscall
	
	ori $2, $0, 10 # Exit 
	syscall
