.data

.text 

	addi $8, $0, 137   # ajout 137 dans le registre $8
   	add $4, $8, $0     # ajout de la valeur de $8 dans $4
   	addi $2, $0, 1	   # Ajoute le numéro de service (print) à syscall
	syscall
	
	addi $2, $0, 10    # Ajout de n° exit à syscall
	syscall