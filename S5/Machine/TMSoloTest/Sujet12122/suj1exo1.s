.data 
	
	.align 2
num_ch : .space 4

	.align 2
tab_chiffre : .space 40
	
.text

	addiu $29, $29, -16 
	
main :

	ori $2, $0, 5
	syscall
	sw $2, 0($29)  #user_name -> 0($29)
	
	lui $8, 0x1001
	ori $8, $8, 0x0020 # savoir l'adresse de tab
	
occ_num_chiffre :
	
	lw $9, 0($29) # q = user_name
	addu $25, $8, $0   # @ 1ere case tab
	ori $10, $0, 1 # nb_c = 1
	ori $12, $0, 10 # $12 = 10
	
loop : 
	lw $9, 0($29)
	sltiu $11, $9, 10
	bne $11, $0, end
	
	divu $9, $12
	mflo $14 # q = q/10
	mfhi $13 # r = q%10
	
	sw $14, 4($29) # r dans pile
	sw $13, 0($29) # q dans pile 
	
	sll $16, $13, 2
	addu $16, $16, $25
	
	lw $15, 0($16)
	addiu $15, $15, 1
	sw $15, 0($16)
	
	addiu $10, $10, 1
	 
	j loop
	
end :
	lw $9, 0($29)
	sll $16, $9, 2
	addu $16, $16, $25
	
	lw $15, 0($16)
	addiu $15, $15, 1
	sw $15, 0($16)
	
	addiu $29, $29, 16
	
	# PRINT
	addu $4, $0, $10
	ori $2, $0, 1
	syscall
	
	# EXIT 
	ori $2, $0, 10
	syscall
	
	
	
