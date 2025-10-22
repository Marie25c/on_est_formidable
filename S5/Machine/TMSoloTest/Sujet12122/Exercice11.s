.data 

user_num : 
	.align 2
	.space 4
	   
tab_chiffre : 
	.align 2
	.space 40
	
.text 

	lui $8, 0x1001
	ori $2, $0, 5
	lw $9, 0($8)
	syscall
	sw $2, 0($8)
	
	lw $9, 0($8)
	ori $4, $9, 0
	
	ori $2, $0, 1
	syscall
	
	ori $2, $0, 10
	syscall
	
	
	
	