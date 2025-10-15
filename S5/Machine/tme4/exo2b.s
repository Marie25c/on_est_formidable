.data

b1 : .byte 0xFF

.text

	# Charge en mémoire 
	
	lui $8, 0x1001
	lb $9, 0($8)
	lbu $10, 0($8)
	
	add $4, $9, $0
	ori $2, $0, 1
	syscall
	
	ori $4, $0, 10 # saut de ligne dans $4
	ori $2, $0, 11 # print char 
	syscall
	
	add $4, $10, $0
	ori $2, $0, 1
	syscall 
	
	ori $2, $0, 10
	syscall 
	