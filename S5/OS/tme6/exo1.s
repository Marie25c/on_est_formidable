.data 
 
 	.align 0
chaine : .space 10

.text 

	lui $8,0x1001
	lb $9, 0($8)	# &chaine[0]

main :

	ori $2, $0, 5
	syscall
	ori $20, $2, 0 # $20 : nb 
	
	sb $0,10($8) # caract fin de chaine
	
	ori $15, $0, 0

for : 	
	sltiu $16, $15, 10
	bne $16, $0, fin_for
	
	
	
fin_for : 

	ori $2, $0, 10
	syscall