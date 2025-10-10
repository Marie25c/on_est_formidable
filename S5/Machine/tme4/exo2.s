.data

v1 : .word -1
v2 : .word 0xFF


.text

	# Chargement
	
	lui $8, 0x1001 # base adresse
	lw $9, 0($8) # Charge les données
	lw $10, 4($8)
	
	# Affichage 
	
	add $4, $9, $0 # Affiche v1
	ori $2, $0, 1
	syscall
	
	ori $4, $0, 10 # saut de ligne dans $4
	ori $2, $0, 11 # print char 
	syscall
	
	add $4, $10, $0 # Affiche v2
	ori $2, $0, 1
	syscall
	
	# Ajout + stock en memoire
	
	addi $9, $9, 1
	addi $10, $10, 1 
	
	sw $9, 0($8)
	sw $10, 4($8)

	
	# Affichage 
	
	ori $4, $0, 10 # Saut de ligne dans $4
	ori $2, $0, 11 # Print char 
	syscall
	
	add $4, $9, $0 # Affiche v1
	ori $2, $0, 1
	syscall
	
	ori $4, $0, 10 # Saut de ligne dans $4
	ori $2, $0, 11 # Print char 
	syscall
	
	add $4, $10, $0 # Affiche v2
	ori $2, $0, 1
	syscall
	
		
	ori $2, $0, 10 # EXIT 
	syscall
	


