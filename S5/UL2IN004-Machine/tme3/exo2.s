.data

.text 
	
	addi $8, $0, 137
	move $a0, $t0 
	li $v0, 1    
	syscall 
	
	ori $2, $0, 10
	syscall 