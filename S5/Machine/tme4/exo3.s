.data

ch : .asciiz "coucou"

.text

	lui $8, 0x1001
	lb $9, 0($8)
	lb $10, 1($8)
	lb $11, 2($8)
	lb $12, 3($8)
	lb $13, 4($8)
	lb $14, 5($8)
	
	add $4, $9, $0
	ori $2, $0, 11
	syscall
	
	add $4, $10, $0
	ori $2, $0, 11
	syscall
	
	add $4, $11, $0
	ori $2, $0, 11
	syscall
	
	add $4, $12, $0
	ori $2, $0, 11
	syscall
	
	add $4, $13, $0
	ori $2, $0, 11
	syscall
	
	add $4, $14, $0
	ori $2, $0, 11
	syscall
	
	ori $2, $0, 10
	syscall