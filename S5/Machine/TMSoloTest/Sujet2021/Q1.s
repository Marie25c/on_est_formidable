.data

s : .space 20
ch_ok : .asciiz "bien parenthésé\n"
ch_nok : .asciiz "mal parenthésé\n"

.text 

	addiu $29, $29, -12
	
main : 

	lui $8, 0x1001
	
	# Lit la chaine écrit
	or $4, $0, $8
	ori $5, $0, 20
	ori $2, $0, 8
	syscall
	
	# Affiche la chaine lue
	ori $2, $0, 4
	syscall
	
	li $11, '('
	li $12, ')'
	
	sw $0, 0($29) # d
	sw $0, 4($29) # i 
	
loop :  

	lw $14, 4($29)
	addu $15, $8, $14
	lbu $15, 0($15)
	beq $15, $0, end
	
	bne $15, $11, if_2
	lw $24, 0($29)
	addu $24, $24, 1
	sw $24, 0($29)
	
if_2 : 

	bne $15, $12, if_3
	lw $24, 0($29)
	subu $24, $24, 1
	sw $24, 0($29)
	
if_3 :

	lw $24, 0($29)
	slti $9, $24, 0
	bne $9, $0, end
	
	lw $24, 4($29)
	addu $24, $24, 1
	sw $24, 4($29)
	
	j loop

end :

 	lw $24, 0($29)
	bne $24, $0, else 
	
	lui $10, 0x1001
	ori $10, $10, 0x0014     # adresse de ch_ok
	or $4, $0, $10
	ori $2, $0, 4
	syscall
	
	j ex
	

else : 
	
	lui $10, 0x1001
	ori $10, $10, 0x002B   # adresse de ch_nok
	or $4, $0, $10
	ori $2, $0, 4
	syscall
	
ex :
	
	addiu $29, $29, 12
	
	ori $2, $0, 10
	syscall