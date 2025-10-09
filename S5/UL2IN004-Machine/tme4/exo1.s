.data

o1 : .byte 1
o2 : .byte 2
o3 : .byte 3
o4 : .byte 4
m1 : .word 0xAABBCCDD

.text

	lui $8, 0x1001 	# Charge la premiere instruction à la premiere adresse en memoire
	lb $9, 0($8)   	#  Charge les autres lignes selon leurs types
	lb $10, 1($8)
	lb $11, 2($8)
	lw $12, 3($8)
	
	ori $2, $0, 10 # Exit
	syscall
	