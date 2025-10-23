.data 
 	.align 0
chaine : .space 11

.text 

	lui $8,0x1001
	lb $9, 0($8)	# &chaine[0]

main :

	ori $2, $0, 5
	syscall
	ori $20, $2, 0 # $20 : nb 
	
	sb $0,10($8) # caract fin de chaine
	
	ori $15, $0, 9 # i
	ori $17,$0, 0 #r
	ori $18, $0, 10 #10
	ori $19, $0, 1 #1


for : 	
	blez $15, fin_for # i >= 0
	divu $20, $18 # nb / 10
	mflo $17 # r
	mfhi $20 # nb
	addu $10, $8, $15 #&chaine[i]
	addiu $11, $17, 0x30
	sb $11, 0($10) 
	subu $15, $15, $19
	j for
		
fin_for : 
	
	lb $10, 0($8)
	ori $2, $0, 1
	or $4, $0, $10
	syscall
	
	lb $10, 1($8)
	ori $2, $0, 1
	or $4, $0, $10
	syscall
	
	
	
	ori $2, $0, 10 # Exit 
	syscall
