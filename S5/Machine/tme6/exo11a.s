.data

chaine : .space 11

.text

main : addiu $29, $29, -16
	ori $2, $0, 5
	syscall
	
	ori $9, $0, 9
	sw $9, 0($29)  # i = 9
	sw  $2, 4($29)  # entier lue au clavier dans nb 
	
	lui $8, 0x1001
	ori $8, $8, 0x000A
	lbu $0, 0($8)
	
for : lw $9, 0($29)
	slt $10, $9, $0
	bne $10, $0, end_for
	
	lw $11, 4($29)
	ori $10, $0, 10
	div $11,$10
	mfhi $12
	mflo $13
	
	sw $13, 4($29)
	
	lui $14, 0x1001
	addu $14, $14 $9
	
	addiu $12, $12, 0x30
	
	sb $12, 0($14)
	
	subu $9, $9, 1
	sw $9,0($29)
	j for
	
end_for :

	lui $10, 0x1001
	or $4, $0, $10
	ori $2, $0, 4
	syscall 
	