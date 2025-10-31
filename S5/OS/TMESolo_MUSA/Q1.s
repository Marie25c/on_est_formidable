.data 

ch : .asciiz "npotfdsfu" # taille = 10
ch2: .space 10 # 000A
decalage : .byte 1 # 0014

.text 
	addiu $29, $29, -12 # var local : i et tmp
	
main : 

	lui $8, 0x1001 # Première adresse de .data
	
	# print de ch
	or $4, $0, $8 
	ori $2, $0, 4
	syscall 
	
decipher_cesar :

	sw $0, 0($29) # i = 0
	lui $13, 0x1001
	ori $13,$13, 0x0014
	lbu $13, 0($13) # $13 : decalage
	
	addiu $25, $0, 26
	addiu $15, $0, 0x61 # + 26
	
loop :	lw $10, 0($29) # lecture de i
	
	lui $11, 0x1001
	or $11, $11, $10 # src[i]
	lbu $11, 0($11)
	
	beq $11, $0, end
	
	subu $12, $11, $15 # - a
	subu $12, $12, $13 # - decal
	addiu $12, $12, 26 # + 26	
	divu $12,$25
	mfhi $24 # tmp%26
	
	addu $24, $24, $15 # + 'a'
	
	lui $14, 0x1001
	ori $14,$14,0x000A
	addu $14, $14, $10 
	sb $24, 0($14) # dst[i]
	
	addiu $10, $10, 1 # i++
	sw $10, 0($29)
	
	j loop
	
end : 
	
	 # Mettre un caractère nul à la fin de la chaîne décryptée
   	lui $14, 0x1001
    	ori $14, $14, 0x000A       # Adresse de ch2
    	addu $14, $14, $10         # Déplacer à la position suivante
    	sb $0, 0($14) 
    
	# Affichage de la chaîne décryptée
	lui $4, 0x1001         # Charger l'adresse de ch2
	ori $4, $4, 0x000A     # ch2 est à l'adresse 0x1001 + 0x000B
	ori $2, $0, 4          # Code syscall pour afficher une chaîne
	syscall

	
	ori $2,$0, 10
	syscall
	